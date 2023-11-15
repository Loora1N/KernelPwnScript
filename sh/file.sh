#!/bin/bash
#
# Script Name: unfile.sh
# Author: Loora1N
# Update Date: 2023-11-15
# Version: 1.2
# Description: 这个脚本用于将fs目录下的文件打包成cpio文件系统，并将exp.c自动静态编译成exp，打包后的文件系统将保存至rootfs.cpio


function usage()
{
    echo ""
    echo "Usage: file.sh <dirname> <exp_filepath>"
    echo "   eg: file.sh ./fs ./exp.c"
}

if [ -z "$1" ]; then
    echo "Error: please provide the file as argument."
    usage
    exit 1
fi

if [ -z "$2" ]; then
    echo "Error: please provide the exp.c as argument."
    usage
    exit 1
fi

#TODO: 支持其他文件系统打包

dirname="${1}"
exp_pathname="${2}"


gcc "$exp_pathname" -static -masm=intel -g -o "$dirname"'/exp'  || exit

cd "$dirname" || exit
find . | cpio -o --format=newc > '../rootfs.cpio' || exit
