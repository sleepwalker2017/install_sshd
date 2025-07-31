#!/bin/bash

# 启动后台任务并保存 PID
task=$1
bash $task &> task.log &
pid=$!
echo "Started task with PID $pid"

# 每隔 10 秒检查 del 文件
while true; do
    if [ -f del ]; then
        echo "Found 'del' file. Killing PID $pid..."
        kill $pid 2>/dev/null
        rm -f del
        echo "Killed and deleted 'del' file. Exiting monitor."
        break
    fi
    sleep 10
done
