from flask import Flask, request, jsonify, render_template
import subprocess
import threading
import time
import json
import os
import psutil
import logging
import requests

app = Flask(__name__)
STATUS_FILE = "server_status.json"

# Tắt log dòng "GET /status"
log = logging.getLogger("werkzeug")
log.setLevel(logging.WARNING)

# Ghi trạng thái server
def write_status(is_running, started_at=None):
    with open(STATUS_FILE, "w") as f:
        json.dump({
            "running": is_running,
            "started_at": started_at if started_at else None
        }, f)

# Đọc trạng thái server
def read_status():
    if not os.path.exists(STATUS_FILE):
        return {"running": False, "started_at": None}
    with open(STATUS_FILE, "r") as f:
        return json.load(f)

# Kiểm tra tiến trình Minecraft đang chạy
def is_server_running():
    for proc in psutil.process_iter(['name']):
        if proc.info['name'] == 'bedrock_server':
            return True
    return False

# Gửi lệnh tắt Flask (phải gọi nội bộ vì không có request context)
def shutdown_flask():
    try:
        requests.post("http://127.0.0.1:5000/__shutdown__")
    except:
        pass

# Giám sát server và tắt Flask nếu server Minecraft tắt
def monitor_server():
    while True:
        time.sleep(5)
        if read_status()["running"] and not is_server_running():
            print("[Monitor] Server Minecraft đã tắt. Cập nhật trạng thái và tắt Flask.")
            write_status(False, None)
            shutdown_flask()
            break

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/start", methods=["POST"])
def start():
    if read_status()["running"]:
        return jsonify({"status": "Server đã bật."}), 200

    def run_server():
        write_status(True, time.time())
        subprocess.run(["bash", "start_server.sh"])
        write_status(False, None)

    threading.Thread(target=run_server).start()
    threading.Thread(target=monitor_server, daemon=True).start()
    return jsonify({"status": "Đang bật server..."})

@app.route("/stop", methods=["POST"])
def stop():
    if not read_status()["running"]:
        return jsonify({"status": "Server đã tắt."}), 200

    subprocess.run(["bash", "stop_server.sh"])
    write_status(False, None)
    return jsonify({"status": "Đã gửi lệnh tắt server."})

@app.route("/status", methods=["GET"])
def status():
    return jsonify(read_status())

@app.route("/__shutdown__", methods=["POST"])
def shutdown():
    func = request.environ.get("werkzeug.server.shutdown")
    if func:
        func()
        return "Flask server shutting down..."
    return "Không thể tắt Flask", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
