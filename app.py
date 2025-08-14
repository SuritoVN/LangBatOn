from flask import Flask
import os, time, requests, paramiko

app = Flask(__name__)

# Lấy config từ Environment Variables
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
CODESPACE_NAME = os.getenv("CODESPACE_NAME")
SSH_USER = os.getenv("SSH_USER", "codespace")
SSH_KEY_PATH = os.getenv("SSH_KEY_PATH", "/etc/secrets/private_key")

# URL API GitHub Codespaces
API_BASE = "https://api.github.com"

def start_codespace():
    """Gọi API GitHub để bật Codespace"""
    url = f"{API_BASE}/user/codespaces/{CODESPACE_NAME}/start"
    headers = {"Authorization": f"Bearer {GITHUB_TOKEN}"}
    r = requests.post(url, headers=headers)
    if r.status_code not in [200, 202]:
        raise Exception(f"Không thể start Codespace: {r.text}")

def get_codespace_host():
    """Lấy hostname SSH của Codespace"""
    url = f"{API_BASE}/user/codespaces/{CODESPACE_NAME}"
    headers = {"Authorization": f"Bearer {GITHUB_TOKEN}"}
    r = requests.get(url, headers=headers)
    if r.status_code != 200:
        raise Exception(f"Lỗi lấy thông tin Codespace: {r.text}")
    data = r.json()
    return data["connection"]["ssh"]["host"], data["connection"]["ssh"]["port"]

def wait_until_running(timeout=120):
    """Chờ Codespace online"""
    url = f"{API_BASE}/user/codespaces/{CODESPACE_NAME}"
    headers = {"Authorization": f"Bearer {GITHUB_TOKEN}"}
    for _ in range(timeout // 5):
        r = requests.get(url, headers=headers)
        if r.status_code == 200 and r.json()["state"] == "Available":
            return True
        time.sleep(5)
    return False

def run_command_over_ssh(host, port, command):
    """Chạy lệnh qua SSH"""
    key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, port=port, username=SSH_USER, pkey=key)
    stdin, stdout, stderr = client.exec_command(command)
    output = stdout.read().decode()
    error = stderr.read().decode()
    client.close()
    return output, error

@app.route('/')
def home():
    return "Trang điều khiển Minecraft Codespace"

@app.route('/start-server')
def start_server():
    try:
        # 1. Bật Codespace
        start_codespace()
        if not wait_until_running():
            return "Không thể khởi động Codespace trong thời gian chờ"

        # 2. Lấy host & port SSH
        host, port = get_codespace_host()

        # 3. Chạy lệnh trong Codespace
        output, error = run_command_over_ssh(
            host, port,
            "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
        )

        return f"<pre>Server đã khởi động:\n{output}\n{error}</pre>"

    except Exception as e:
        return f"Lỗi: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
