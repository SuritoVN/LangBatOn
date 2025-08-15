from flask import Flask
import paramiko

app = Flask(__name__)

SSH_HOST = "bookish-memory-r4v4pqw94rqwfqrv@app.github.dev"  # Đổi thành của bạn
SSH_PORT = 2222
SSH_USER = "bookish-memory-r4v4pqw94rqwfqrv"  # giống phần trước @
SSH_KEY_PATH = "/etc/secrets/private_key"  # Render sẽ lưu key tại đây

@app.route('/')
def home():
    return "Trang điều khiển Codespace Minecraft"

@app.route('/start-server')
def start_server():
    try:
        key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(SSH_HOST, port=SSH_PORT, username=SSH_USER, pkey=key)

        # Chạy script start_server.sh
        stdin, stdout, stderr = client.exec_command(
            "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
        )
        output = stdout.read().decode()
        client.close()

        return f"<pre>Server started:\n{output}</pre>"
    except Exception as e:
        return f"Lỗi: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
