#!/bin/bash
if [ -n "$1" ]; then
    URL=$1
    echo "Parsing $1"
    # key1 for single file
    # key2 for playlist
    file=`curl --silent $URL | grep key[12] | awk -F ";" '{print $6}' | awk -F "\"" '{print $1}' | awk -F "file=" '{print $2}' | head -n 1`
    echo "Finding the URL $file"
    files=`curl --silent $file | grep mp3 | awk -F "\[" '{print $3}' |awk -F "\]" '{print $1}'`  
    echo "Finding $files"
    echo $files | xargs wget 
else 
    echo "Syntax get_links.sh <http://nhaccuatui.com...>"
fi

