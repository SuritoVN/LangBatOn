from flask import Flask
import os, time, requests, paramiko

app = Flask(__name__)

GITHUB_TOKEN = os.environ["GITHUB_TOKEN"]
CODESPACE_NAME = os.environ["CODESPACE_NAME"]
SSH_USER = os.environ["SSH_USER"]
SSH_KEY_PATH = os.environ["SSH_KEY_PATH"]

# API base
API_URL = "https://api.github.com"


def start_codespace():
    """Bật Codespace"""
    r = requests.post(
        f"{API_URL}/user/codespaces/{CODESPACE_NAME}/start",
        headers={"Authorization": f"Bearer {GITHUB_TOKEN}"}
    )
    r.raise_for_status()


def get_codespace_ssh():
    """Lấy SSH host & port"""
    r = requests.get(
        f"{API_URL}/user/codespaces/{CODESPACE_NAME}",
        headers={"Authorization": f"Bearer {GITHUB_TOKEN}"}
    )
    r.raise_for_status()
    data = r.json()
    return data["connection"]["ssh"]["host"], data["connection"]["ssh"]["port"]


@app.route("/")
def home():
    return '<a href="/start-server">Bấm để bật Codespace & chạy Minecraft</a>'


@app.route("/start-server")
def start_server():
    try:
        # 1. Bật Codespace
        start_codespace()

        # 2. Chờ Codespace sẵn sàng
        for i in range(30):
            try:
                host, port = get_codespace_ssh()
                if host:
                    break
            except:
                pass
            time.sleep(5)
        else:
            return "Không thể lấy thông tin SSH."

        # 3. SSH vào và chạy lệnh
        key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(host, port=port, username=SSH_USER, pkey=key)

        stdin, stdout, stderr = client.exec_command(
            "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
        )
        output = stdout.read().decode()
        client.close()

        return f"<pre>Server đã khởi động:\n{output}</pre>"

    except Exception as e:
        return f"Lỗi: {e}"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
