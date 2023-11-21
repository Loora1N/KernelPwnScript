#!/bin/bash
#
# Script Name: Ktmux.sh
# Author: Loora1N
# Update Date: 2023-11-17
# Version: 0.5
# Description: This script is designed for two things. one is make vmliunx from bzimage and store symbol table,
#              the other is to get all gadget into gadget.txt


usage() {
    echo "Usage: $0 <bzImage> <outputfile>"
}

if [ -z "$1" ]; then
    echo "Error: please provide two files as argument."
    usage
    exit 1
fi

if [ -z "$2" ]; then
    echo "Error: please provide output file as argument."
    usage
    exit 1
fi

bzImage=$1
vmlinux=$2

#   获取带符号表的vmlinux文件
file_type=$(file -b "$bzImage")
if [[ "$file_type" == *bzImage* ]];then
    vmlinux-to-elf "$bzImage" "$vmlinux"
else
    echo "TypeError: this file is not bzImage type"
    usage
    exit 1 
fi

#   获取gadget.txt

echo "Using ROPgadget...."

ROPgadget --binary "$vmlinux" > gadget.txt

echo "Using ropper...."

ropper --file vmlinux --nocolor >> gadget.txt
