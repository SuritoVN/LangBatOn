from flask import Flask, Response
import requests
import paramiko
import time
import os

app = Flask(__name__)

# Environment variables
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
CODESPACE_NAME = os.getenv("CODESPACE_NAME")
SSH_USER = os.getenv("SSH_USER", "codespace")
SSH_KEY_PATH = os.getenv("SSH_KEY_PATH", "/etc/secrets/render_key")

GITHUB_API = "https://api.github.com"


def log_stream(messages):
    """Tạo stream log cho trình duyệt"""
    for msg in messages:
        yield msg + "\n"


def start_codespace():
    """Bật Codespace qua GitHub API"""
    url = f"{GITHUB_API}/user/codespaces/{CODESPACE_NAME}/start"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}
    r = requests.post(url, headers=headers)
    if r.status_code not in [200, 202]:
        raise Exception(f"Không thể bật Codespace: {r.text}")
    return True


def wait_for_codespace():
    """Chờ Codespace sẵn sàng"""
    url = f"{GITHUB_API}/user/codespaces/{CODESPACE_NAME}"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}
    while True:
        r = requests.get(url, headers=headers).json()
        state = r.get("state")
        yield f"Trạng thái hiện tại: {state}"
        if state == "Available":
            conn = r.get("connection", {}).get("ssh", {})
            yield f"Codespace đã sẵn sàng! Host: {conn.get('host')} Port: {conn.get('port')}"
            return conn.get("host"), conn.get("port")
        time.sleep(5)


def ssh_and_run(host, port):
    """SSH vào Codespace và chạy lệnh"""
    yield "Kết nối SSH..."
    key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, port=port, username=SSH_USER, pkey=key)

    yield "Chạy lệnh khởi động Minecraft server..."
    stdin, stdout, stderr = client.exec_command(
        "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
    )

    for line in stdout:
        yield "OUT: " + line.strip()
    for line in stderr:
        yield "ERR: " + line.strip()

    client.close()
    yield "Hoàn tất!"


@app.route('/')
def home():
    return '<a href="/start-server">Bấm để khởi động Minecraft Codespace</a>'


@app.route('/start-server')
def start_server():
    def generate():
        try:
            yield "Bắt đầu bật Codespace..."
            start_codespace()
            yield "Đang chờ Codespace sẵn sàng..."
            host, port = None, None
            for msg in wait_for_codespace():
                yield msg
                if msg.startswith("Codespace đã sẵn sàng!"):
                    break
            # Lấy lại host, port từ msg cuối
            host, port = msg.split("Host: ")[1].split(" Port: ")
            for msg in ssh_and_run(host, int(port)):
                yield msg
        except Exception as e:
            yield f"Lỗi: {str(e)}"

    return Response(log_stream(generate()), mimetype='text/plain')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
