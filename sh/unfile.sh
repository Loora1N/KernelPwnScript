#!/bin/bash
#
# Script Name: unfile.sh
# Author: Loora1N
# Update Date: 2023-11-15
# Version: 1.2
# Description: This script is designed for unfile cpio filesystem into fs directory


function usage()
{
    echo ""
    echo "Usage: unfile.sh <filename>"
    echo "   eg: unfile.sh rootfs.cpio"
}

if [ -z "$1" ]; then
    echo "Error: please provide the file as argument."
    usage
    exit 1
fi

#TODO: Differentiate file formats and unpack them

fs_filepath='./fs/'"${1}"
file_name="${1}"

mkdir fs
cp "$file_name" "$fs_filepath"

cd fs || exit

if [[ "$file_name" == *.gz ]];then
    gunzip -c "$file_name" | cpio -idmv
else 
    file_type=$(file -b "$file_name")
    if [[ "${file_type}" == *gzip* ]]; then
        mv "$file_name" "$file_name"'.gz'
        file_name="$file_name"'.gz'
        gunzip -c "$file_name" | cpio -idmv
    else
        cpio -idmv < "$file_name"
    fi
fi

rm "$file_name"