from flask import Flask, render_template, Response
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


def sse_format(message):
    """Định dạng tin nhắn cho SSE"""
    return f"data: {message}\n\n"


def start_codespace():
    url = f"{GITHUB_API}/user/codespaces/{CODESPACE_NAME}/start"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}
    r = requests.post(url, headers=headers)
    if r.status_code not in [200, 202]:
        raise Exception(f"Lỗi bật Codespace: {r.text}")
    return True


def wait_for_codespace():
    url = f"{GITHUB_API}/user/codespaces/{CODESPACE_NAME}"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}
    while True:
        r = requests.get(url, headers=headers).json()
        state = r.get("state")
        yield f"Trạng thái hiện tại: {state}"
        if state == "Available":
            conn = r.get("connection", {}).get("ssh", {})
            yield f"Codespace đã sẵn sàng!"
            return conn.get("host"), conn.get("port")
        time.sleep(5)


def ssh_and_run(host, port):
    yield "Đang kết nối SSH..."
    key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, port=port, username=SSH_USER, pkey=key)

    yield "Đang chạy start_server.sh..."
    stdin, stdout, stderr = client.exec_command(
        "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
    )

    for line in stdout:
        yield f"OUT: {line.strip()}"
    for line in stderr:
        yield f"ERR: {line.strip()}"

    client.close()
    yield "Hoàn tất!"


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/start-stream')
def start_stream():
    def generate():
        try:
            yield sse_format("Bắt đầu bật Codespace...")
            start_codespace()
            yield sse_format("Đang chờ Codespace sẵn sàng...")
            for msg in wait_for_codespace():
                yield sse_format(msg)
            host, port = msg.split("Host: ")[1].split(" Port: ")
            for msg in ssh_and_run(host, int(port)):
                yield sse_format(msg)
        except Exception as e:
            yield sse_format(f"Lỗi: {str(e)}")

    return Response(generate(), mimetype='text/event-stream')


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
