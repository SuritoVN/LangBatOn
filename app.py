import os
import time
import requests
import paramiko
from flask import Flask, render_template, request
from dotenv import load_dotenv

load_dotenv()
app = Flask(__name__)

# Lấy config từ .env
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
CODESPACE_NAME = os.getenv("CODESPACE_NAME")
SSH_KEY_PATH = os.getenv("SSH_KEY_PATH")
SCRIPT_PATH = os.getenv("SCRIPT_PATH")
API_URL = f"https://api.github.com/user/codespaces/{CODESPACE_NAME}/start"

def start_codespace():
    r = requests.post(API_URL, headers={
        "Authorization": f"token {GITHUB_TOKEN}",
        "Accept": "application/vnd.github+json"
    })
    if r.status_code not in (200, 202):
        raise Exception(f"Lỗi bật Codespace: {r.text}")

def wait_until_ready():
    while True:
        r = requests.get(f"https://api.github.com/user/codespaces/{CODESPACE_NAME}",
                         headers={"Authorization": f"token {GITHUB_TOKEN}"})
        data = r.json()
        if data.get("state") == "Available":
            conn = data["connection"]["ssh"]
            return conn["host"], conn["port"], conn["user"]
        time.sleep(5)

def run_script_via_ssh(host, port, user):
    key = paramiko.RSAKey.from_private_key_file(SSH_KEY_PATH)
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=host, port=port, username=user, pkey=key)
    stdin, stdout, stderr = ssh.exec_command(f"bash {SCRIPT_PATH}")
    output = stdout.read().decode()
    error = stderr.read().decode()
    ssh.close()
    return output, error

@app.route("/", methods=["GET"])
def index():
    return render_template("index.html")

@app.route("/start", methods=["POST"])
def start():
    try:
        start_codespace()
        host, port, user = wait_until_ready()
        output, error = run_script_via_ssh(host, port, user)
        return render_template("index.html", message=f"✅ Server started!\nOutput:\n{output}\nError:\n{error}")
    except Exception as e:
        return render_template("index.html", message=f"❌ Error: {e}")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
