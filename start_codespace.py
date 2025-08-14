import subprocess
import time
import os

GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")
CODESPACE_NAME = os.environ.get("CODESPACE_NAME")
SCRIPT_PATH = os.environ.get("SCRIPT_PATH", "/workspaces/LangBatOn/web-control/start_server.sh")

def run_cmd(cmd):
    result = subprocess.run(cmd, shell=True, text=True, capture_output=True)
    if result.returncode != 0:
        raise Exception(result.stderr.strip())
    return result.stdout.strip()

def gh_login():
    print("🔑 Đang đăng nhập GitHub CLI...")
    run_cmd(f'echo "{GITHUB_TOKEN}" | gh auth login --with-token')
    print("✅ Đăng nhập thành công!")

def start_codespace_and_server():
    gh_login()

    print("🚀 Bắt đầu bật Codespace...")
    run_cmd(f"gh codespace start -c {CODESPACE_NAME}")

    print("⏳ Đang chờ Codespace sẵn sàng...")
    while True:
        status = run_cmd(f"gh codespace list --json name,state | grep {CODESPACE_NAME}")
        if "Available" in status:
            break
        time.sleep(5)

    print("✅ Codespace đã sẵn sàng!")
    run_cmd(f'gh codespace ssh -c {CODESPACE_NAME} --command "bash {SCRIPT_PATH}"')
    print("🎉 Đã chạy xong script trên Codespace!")
