from flask import Flask
import paramiko  # Thư viện SSH trong Python

app = Flask(__name__)

# Thông tin Codespace của bạn
SSH_HOST = "bookish-memory-r4v4pqw94rqwfqrv.github.dev"  # Đổi thành host của Codespace
SSH_PORT = 2222
SSH_USER = "bookish-memory-r4v4pqw94rqwfqrv"  # Đổi thành username của bạn
SSH_KEY_PATH = "/etc/secrets/private_key"  # Nơi Render sẽ lưu SSH key

@app.route('/')
def home():
    return "Trang điều khiển Minecraft Codespace"

@app.route('/start-server')
def start_server():
    try:
        # Nạp private key
        key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)

        # Tạo SSH client
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        # Kết nối tới Codespace
        client.connect(SSH_HOST, port=SSH_PORT, username=SSH_USER, pkey=key)

        # Chạy lệnh trong Codespace
        stdin, stdout, stderr = client.exec_command(
            "cd /workspaces/LangBatOn/Minecraft && ./start_server.sh"
        )

        # Lấy output
        output = stdout.read().decode()
        client.close()

        return f"<pre>Server đã khởi động:\n{output}</pre>"

    except Exception as e:
        return f"Lỗi: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
