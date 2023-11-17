#!/bin/bash
#
# Script Name: unfile.sh
# Author: Loora1N
# Update Date: 2023-11-17
# Version: 0.7
# Description: This script is designed for gdb kernel

# Function to display usage instructions
usage() {
    echo "Usage: $0 <vmlinux_file> [-s|--symbol <path> <offset>]"
}

if [ -z "$1" ]; then
    echo "Error: please provide the file as argument."
    usage
    exit 1
fi

vmlinux="${1}"
symbol_flag=false

if [[ "$2" == "--symbol" || "$2" == "-s" ]]; then
    if [ -z "$3" ] || [ -z "$4" ]; then
        echo "Error: Please provide both path and offset after --symbol or -s."
        usage
        exit 1
    fi
    path="$3"
    offset="$4"
    symbol_flag=true
fi

#TODO: 增加break point功能

gdb_cmd="gdb $vmlinux -ex 'target remote localhost:1234'"
if [ "$symbol_flag" = true ]; then
    gdb_cmd+=" -ex 'add-symbol-file $path $offset'"
fi

#保证运行
gdb_cmd+=" -ex c"
eval "$gdb_cmd"
