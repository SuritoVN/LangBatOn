from flask import Flask, render_template_string
import requests
import time
import paramiko
import os

app = Flask(__name__)

# Lấy cấu hình từ Environment Variables
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
CODESPACE_NAME = os.getenv("CODESPACE_NAME")
SSH_USER = os.getenv("SSH_USER", "codespace")
SSH_KEY_PATH = "/tmp/private_key"

# Lưu private key vào file (Render sẽ set biến PRIVATE_KEY)
PRIVATE_KEY = os.getenv("PRIVATE_KEY")
if PRIVATE_KEY:
    with open(SSH_KEY_PATH, "w") as f:
        f.write(PRIVATE_KEY)
    os.chmod(SSH_KEY_PATH, 0o600)  # Sửa quyền cho SSH key

# HTML đơn giản
HTML = """
<h1>Điều khiển Minecraft Codespace</h1>
<form action="/start-server" method="post">
    <button type="submit">🚀 Start Minecraft Server</button>
</form>
<pre>{{ result }}</pre>
"""

@app.route("/")
def home():
    return render_template_string(HTML, result="")

@app.route("/start-server", methods=["POST"])
def start_server():
    try:
        # 1️⃣ Gọi GitHub API để start Codespace
        headers = {"Authorization": f"token {GITHUB_TOKEN}"}
        url = f"https://api.github.com/user/codespaces/{CODESPACE_NAME}/start"
        r = requests.post(url, headers=headers)
        if r.status_code not in [200, 202]:
            return render_template_string(HTML, result=f"❌ Lỗi start Codespace: {r.text}")

        # 2️⃣ Chờ Codespace sẵn sàng
        for i in range(20):
            time.sleep(5)
            info = requests.get(
                f"https://api.github.com/user/codespaces/{CODESPACE_NAME}",
                headers=headers
            ).json()
            if info.get("state") == "Available":
                SSH_HOST = info["connection"]["ssh"]["host"]
                SSH_PORT = info["connection"]["ssh"]["port"]
                break
        else:
            return render_template_string(HTML, result="❌ Codespace không khởi động kịp.")

        # 3️⃣ SSH vào Codespace
        key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(SSH_HOST, port=SSH_PORT, username=SSH_USER, pkey=key)

        # 4️⃣ Chạy lệnh start_server.sh
        stdin, stdout, stderr = ssh.exec_command(
            "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
        )
        output = stdout.read().decode()
        error = stderr.read().decode()
        ssh.close()

        return render_template_string(HTML, result=f"✅ Server started!\n{output}\n{error}")

    except Exception as e:
        return render_template_string(HTML, result=f"❌ Lỗi: {str(e)}")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
