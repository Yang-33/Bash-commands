#!/bin/bash

# @(#) This script expresses write time and some info to TM file setting.

<<FUNC
write_time
FUNC

<<spec
 sth.TM -> $1
 write time and info
 no return
spec
write_time()
{

    local ptime=`date`
    local mes="=>  $ptime"
    
    sed -i "/=>/c $mes" $1
    
#    cat $1

}



