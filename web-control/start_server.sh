#!/bin/bash

cd /workspaces/LangBatOn/Minecraft

echo "🟢 Khởi động Minecraft Bedrock Server..."
LD_LIBRARY_PATH=. ./bedrock_server > bedrock_log.txt 2>&1 &

sleep 2

echo "🟢 Khởi động Playit.gg tunnel..."
./playit