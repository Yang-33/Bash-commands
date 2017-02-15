#!/bin/bash

# @(#) This script expresses time comparision setting.

<<FUNC

time_comp

FUNC

<<spec
 checked file -> $1  TM -> $2
 compare file time
 return 0 (time: 1 > 2) , 1 (false)
spec
time_comp()
{
        
    if [ $# -ne 2 ]
    then
        echo "Usage: time_comp file1 file2" 1>&2
        echo "error on time_comp func"
        exit 2
    fi
    
    
    if [ ! -f $1 -o ! -f $2 ]
    then
        exit 3
    fi
    
    
    if [ -n "`find $1 -newer $2 -print`" ]
    then
        return 0
    else
        return 1
    fi
    
}





