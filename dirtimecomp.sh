#!/bin/bash
. ./dir_func.sh


# sth.TM -> $1
# write time and info
# no return
write_time()
{

    local ptime=`date`
    local mes="=>  $ptime"
    
    sed -i "/=>/c $mes" $1
    
#    cat $1

}



# checked file -> $1  TM -> $2
# compare file time
# return 0 (time: 1 > 2) , 1 (false)
time_comp()
{
        
    if [ $# -ne 2 ]
    then
        echo "Usage: command file1 file2" 1>&2
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
    
    
##| test
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
