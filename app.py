from flask import Flask
import requests
import time
import os

app = Flask(__name__)

# Environment variables từ Render
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
CODESPACE_NAME = os.getenv("CODESPACE_NAME")
REPO_OWNER = os.getenv("REPO_OWNER")
REPO_NAME = os.getenv("REPO_NAME")

# Headers cho GitHub API
HEADERS = {
    "Authorization": f"Bearer {GITHUB_TOKEN}",
    "Accept": "application/vnd.github+json"
}

@app.route("/")
def home():
    return "Trang điều khiển Minecraft Codespace (GitHub API)"

@app.route("/start-server")
def start_server():
    # 1. Bật Codespace
    start_url = f"https://api.github.com/user/codespaces/{CODESPACE_NAME}/start"
    r = requests.post(start_url, headers=HEADERS)
    if r.status_code not in (200, 202):
        return f"Lỗi khi bật Codespace: {r.text}", 500

    # 2. Chờ Codespace sẵn sàng
    status_url = f"https://api.github.com/user/codespaces/{CODESPACE_NAME}"
    for _ in range(30):
        s = requests.get(status_url, headers=HEADERS).json()
        if s.get("state") == "Available":
            break
        time.sleep(5)
    else:
        return "Codespace không sẵn sàng sau 150 giây", 500

    # 3. Chạy file start_server.sh qua API
    exec_url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/codespaces/{CODESPACE_NAME}/exec"
    payload = {
        "command": "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
    }
    run = requests.post(exec_url, headers=HEADERS, json=payload)
    if run.status_code not in (200, 201, 202):
        return f"Lỗi khi chạy lệnh: {run.text}", 500

    return "Đã gửi lệnh khởi động server Minecraft!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
