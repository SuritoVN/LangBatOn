#!/bin/bash
cd /workspaces/LangBatOn/Minecraft

# Chạy playit trong nền
tmux new-session -d -s playit './playit'

# Chạy server Minecraft trong phiên tmux khác
tmux new-session -s mc './bedrock_server'

echo "✅ Server started in tmux sessions"
