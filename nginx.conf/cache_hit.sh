#!/bin/bash
# author: Jeremy Wei <shuimuqingshu@gmail.com>
# proxy_cache hit rate

if [ $1x != x ] then
    if [ -e $1 ] then
        HIT=`cat $1 | grep HIT | wc -l`
        ALL=`cat $1 | wc -l`
        Hit_rate=`echo "scale=2;($HIT/$ALL)*100" | bc`
        echo "Hit rate=$Hit_rate%"
    else
        echo "$1 not exsist!"
    fi
else
    echo "usage: ./hit_rate.sh file_path"
fi
