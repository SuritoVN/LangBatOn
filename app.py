from flask import Flask
from start_codespace import start_codespace_and_server

app = Flask(__name__)

@app.route("/")
def home():
    return '<h1>Điều khiển Minecraft</h1><a href="/start">Bật Server</a>'

@app.route("/start")
def start():
    try:
        start_codespace_and_server()
        return "✅ Đã bật server Minecraft!"
    except Exception as e:
        return f"❌ Lỗi: {str(e)}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
