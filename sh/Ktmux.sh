#!/bin/bash
#
# Script Name: Ktmux.sh
# Author: Loora1N
# Update Date: 2023-11-17
# Version: 1.0
# Description: This script is designed for running qemu-system and gdb in tmux



cmd_qemu="./run.sh" #qemu-system script
cmd_gdb="../KernelPwnScript/sh/gdb_kernel.sh" #gdb-kernel script
vmlinux="./vmlinux"
symbol="./fs/rwctf.ko"
offset=0xffffffffc0000000   # offset of xxx.ko, for gdb add-symbol-file
session_name="KernelSession" #session name

usage () {
    echo ""
    echo "Usage: $0 [-s|--symbol]"
    echo "  -s,--symbol: use for add-symbol-file"
}

if [[ "$1" == "--symbol" || "$1" == "-s" ]]; then
    symbol_flag=true
fi

# 检查是否在tmux中
if [ -n "$TMUX" ]; then
    tmp_name=$(tmux display-message -p '#S')
    if [[ "$session_name" == "$tmp_name" ]]; then
        tmux split-window -h -t "$session_name:0"
    else
        echo "Error: The name of this session is not equal to session_name"
        echo "Please do not use this script in other session created by yourself"
        usage
        exit 1
    fi
else
    # 不在tmux中，创建新的tmux会话
    tmux new-session -d -s "$session_name"
    tmux split-window -h -t "$session_name:0"
fi

# 运行第一个脚本 run.sh
tmux send-keys -t "$session_name:0.0" "$cmd_qemu" C-m

# 选择第二个面板并运行第二个脚本 gdbkernel
tmux select-pane -t "$session_name:1.0"
if [[ $symbol_flag == true ]]; then
    tmux send-keys "$cmd_gdb $vmlinux -s $symbol $offset" C-m
else
    tmux send-keys "$cmd_gdb $vmlinux" C-m
fi

# 让用户可以看到执行结果
tmux attach-session -t "KernelSession"
