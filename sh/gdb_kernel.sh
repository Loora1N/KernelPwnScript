#!/bin/bash
#
# Script Name: unfile.sh
# Author: Loora1N
# Update Date: 2023-11-15
# Version: 0.5
# Description: This script is designed for gdb kernel


#TODO:自定义程度太低
gdb ./vmlinux\
    -ex 'add-symbol-file filepath offset'\
    -ex 'target remote localhost:1234' \
    -ex 'b breakpoint'