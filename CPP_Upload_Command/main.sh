#!/bin/bash

# @(#) This script expresses main function setting.

. ./grobal_exp.sh

<<INCLUDE
Exp
INCLUDE

<<FUNC

main

FUNC

main()
{
    
    local cur_dir=`pwd`
    local _option=
    local status=
    local count=0    


    # opt check and decision
    if [ $# -eq 0 ]
    then 
        _option=`which_dir $cur_dir `
        
    elif [ $# -eq 1 ]
    then #opt check
        _option=`opt_check $1 `
    else
        echo "Usege: $Command_name [-option]"
        exit 1
    fi

    
    f_message $_option
    
    
    local tm_file=`Set_TFile $_option`

    echo "tm_file is " $tm_file
    

    cd_to_upload_dir -v $_option


    for File in `\find . -maxdepth 1 -type f -name "${Exp}" `
    do
        time_comp $File $tm_file 
        status=$?
        
        if [ "$status" -eq 0 ]
        then
            (  copyfile $_option $File   ) 
            count=$((count+1))
        fi
        
        
    done


    if [ $count -eq 0 ]
    then 
        echo "No file is newer from the last upload."
    elif [ $count -eq 1 ]
    then
        echo $count "file has uploaded."
    else
        echo $count "files have uploaded."   
    fi


    write_time $tm_file $count


    cd_to_upload_dir -u $_option
    
}

