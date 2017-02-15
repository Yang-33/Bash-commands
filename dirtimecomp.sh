#!/bin/bash
. ./dir_func.sh
. ./time_comp_func.sh
. ./write_to_TM_func.sh




main()
{
    
    ## cpp, sh, ....
    EXP="*.cpp"
    
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
        echo "Usege: command [-option]"
        exit 1
    fi
    
    f_message $_option
    
    
    local tm_file=`Set_TFile $_option`

    echo "tm_file is " $tm_file
    
    ## have to cd. (;..;)
    local val="-v"
    cd_to_upload_dir $val $_option

    for File in `\find . -maxdepth 1 -type f -name "${EXP}" `
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

    write_time $tm_file

#for debug this func stop
#    cd_to_upload_dir -u $_option

}



main $@

##

#
