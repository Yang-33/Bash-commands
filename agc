#!/bin/bash

# USAGE !
# $agc 100 => agc_100_{a,b,c,d}.cpp

num=$1
for alpha in {a,b,c,d}
do
    cp mytemplate/agctemplate.cpp ${num}_agc_${alpha}.cpp
    File=${num}_agc_${alpha}.cpp
    sed -i -e "s|_NUM|$num|g" ${File}
    sed -i -e "s|ppp|$alpha|g" ${File}
    big=$(echo "$alpha" | tr a-z A-Z )
    sed -i -e "s|PPP|$big|g" ${File}
    ptime=`date '+%Y/%m/%d'`
    sed -i -e "s|xtimex|$ptime|g" ${File}
done

