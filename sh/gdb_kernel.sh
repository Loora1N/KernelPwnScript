#!/bin/bash
#
# Script Name: unfile.sh
# Author: Loora1N
# Update Date: 2023-11-15
# Version: 0.6
# Description: This script is designed for gdb kernel


#TODO:自定义程度太低

if [ -z "$1" ]; then
    echo "Error: please provide the file as argument."
    usage
    exit 1
fi

vmlinux="${1}"

gdb "$vmlinux"\
    -ex 'target remote localhost:1234' 
    # -ex 'add-symbol-file ./core/fs/core.ko offset'\
    # -ex 'b breakpoint'\