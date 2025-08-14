from flask import Flask, render_template, jsonify
import paramiko

app = Flask(__name__)

# SSH thông tin
SSH_HOST = "bookish-memory-r4v4pqw94rqwfqrv.github.dev"
SSH_PORT = 2222
SSH_USER = "codespace"
SSH_KEY = "C:/Users/DELL/.ssh/codespaces_termux"  # private key

def run_ssh_command(cmd):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(SSH_HOST, port=SSH_PORT, username=SSH_USER, key_filename=SSH_KEY)
    stdin, stdout, stderr = ssh.exec_command(cmd)
    output = stdout.read().decode()
    ssh.close()
    return output

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/start", methods=["POST"])
def start():
    run_ssh_command("bash /workspaces/LangBatOn/Minecraft/start_server.sh")
    return jsonify({"status": "Server is starting..."})

@app.route("/stop", methods=["POST"])
def stop():
    run_ssh_command("bash /workspaces/LangBatOn/Minecraft/stop_server.sh")
    return jsonify({"status": "Server is stopping..."})

@app.route("/status", methods=["GET"])
def status():
    output = run_ssh_command("pgrep -f bedrock_server || true")
    running = bool(output.strip())
    return jsonify({"running": running})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
