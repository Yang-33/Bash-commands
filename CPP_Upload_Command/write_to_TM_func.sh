#!/bin/bash

# @(#) This script expresses write time and some info to TM file setting.

<<FUNC
write_time
FUNC

<<spec
 sth.TM -> $1 ,upfiles count -> $2
 write time and info
 no return
spec
write_time()
{

    local ptime=`date`
    local mes="=>  $ptime"
    
    sed -i "/=>/c $mes" $1
    
    local sum=`sed -n -e "s/upload sumation is //p" $1`
    local part=$2
    local now=$((sum+part))
    local mes2="upload sumation is $now"
    sed -i "/upload sumation/c $mes2" $1

    local dtime=`date '+%Y/%m/%d'`
    echo $dtime " " $part " problems solved." >> $1
}



