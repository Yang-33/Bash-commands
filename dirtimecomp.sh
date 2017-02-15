#!/bin/bash
#  . ./filetimecomp.sh


# if one file is newer than timefile then 
#   echo flename  else do nothing
#

# sth.TM -> $1
# write time and info
# no return
write_time(){

echo $1

}



# checked file -> $1  TM -> $2
# compare file time
# return 0 (time: 1 > 2) , 1 (false)
time_comp(){
    
    
    if [ $# -ne 2 ]; then
        echo "Usage: command file1 file2" 1>&2
    exit 2
    fi
    
    
    if [ ! -f $1 -o ! -f $2 ]; then
        exit 3
    fi
    
    
    if [ -n "`find $1 -newer $2 -print`" ]; then
        return 0
    else
        return 1
    fi
    
}



# OPT -> $1  file -> $2
# copy to purpose dirctory
# no return
copyfile(){ # !!test mode
    
    
    if [ $# -ne 2 ]; then
    echo "Usege: cdup [ - dir option ] [filename]"
    exit 1
    fi
    
    
    #variables
    
    BASE="competitive-programming/"
    Purpose_directory=""
    file_directory=""
    
    OPT=
    
    # --option
    
    while  getopts  brod  OPT
    do 
        case  ${OPT}  in  #2nd char is available
            b )   Purpose_directory="atcoder/ABC/"
                #               file_directory="atcoder/ABC_solve/ABC_solve/"
                file_directory=""
#                echo "DIRECTORY is ABC" ;;
            r )   Purpose_directory="atcoder/ARC/"
                file_directory="atcoder/ARC_solve/ARC_solve/"
#               echo "DIRECTORY is ARC" ;;
            o )   Purpose_directory="AOJ_DPL/"
                file_directory="AOJ_solved/AOJ_solved/"
#                echo "DIRECTORY is AOJ" ;;
            d )   Purpose_directory="atcoder/TDPC/"
                file_directory="atcoder/solve_TDPC_file/solve_TDPC_file/"  
#                echo "DIRECTORY is TDPC"  ;;
            * )   echo "there is not such a option."
                echo "Usege: cdup [ - dir option ] [filename]"
                exit 2  ;;
            
        esac
    done
    
    
    #shift `expr $OPTIND - 1`  
    
    # copy
    
    cd /mnt/c/home
    
    #cp ${BASE}${file_directory}$2 ${BASE}${Purpose_directory}
    AAA="Bash-commands/"
    cp ${AAA}${file_directory}$2 ${BASE}${Purpose_directory}
    
    
    cd /mnt/c/home/${BASE}${Purpose_directory}
    
    # input date to the file
    
    PTIME=`date '+%Y/%m/%d'`
    
    sed -i -e "s|xtimex|$PTIME|g" $2
    
    # message 
    
    if [ -e $2 ]
    then
    echo $2 "has been copied! "
    else echo "Failure. " $2 "has not been copied. " 
        
    fi
    
    
}


# pwd->$1
# check dir name 
# return dir option 
which_dir(){  
    
    _REOPT=
    
    case  $1  in
        *ABC*  )  _REOPT="-b" ;;
        *ARC*  )  _REOPT="-r" ;;
        *AOJ*  )  _REOPT="-o" ;;
        *TDPC* )  _REOPT="-d" ;;
        * )   echo "This directory is not for competitiveprogramming."
            echo "Usege: (on matched dir) command [-option]"
            exit 2  ;;
        
    esac

    echo ${_REOPT}
    
}

# opt -> $1
# check inputed option presence
# return dir option
opt_check(){
    
    _REOPT=
    
    case  $1  in
        -b  )  _REOPT="-b" ;;
        -r  )  _REOPT="-r" ;;
        -o  )  _REOPT="-o" ;;
        -d )  _REOPT="-d" ;;
        * )   echo "There is no presence such a option " $1
            echo "Usege: (on matched dir) command [-option]"
            exit 2  ;;
        
    esac
    
    echo ${_REOPT}
    
    
}


# _option -> $1
# out dir name
# no return
f_message(){

    case  $1  in
        -b  )  echo "Purpose Directory is ABC."   ;;
        -r  )  echo "Purpose Directory is ARC."   ;;
        -o  )  echo "Purpose Directory is AOJ."   ;;
        -d  )  echo "Purpose Directory is TDPC."  ;;
         *  )  echo "? eroor. on f_message "      ;;       
    esac

    
}


main(){
    
    ## cpp .....
    EXP="*.sh"
    
    CUR_DIR=`pwd`

    # opt check and decision
    if [ $# -eq 0 ]
    then 
        _OPTION=`which_dir $CUR_DIR `
        
    elif [ $# -eq 1 ]
    then #opt check
        _OPTION=`opt_check $1 `
    else 
        echo "There is no match such a option " $1
        echo "Usege: command [-option]"
    fi
    
    f_message $_OPTION

    
    STIME=`\find . -name *.TM `
    
    
    for File in `\find . -maxdepth 1 -type f -name "${EXP}" `; do
        time_comp $File $STIME 
        STATUS=$?
        
        if [ "$STATUS" -eq 0 ]; then
            (  copyfile $_OPTION $File   ) 
            
            #        cd ${CUR_DIR}
        fi
        
        
    done
    
    write_time $STIME

    
}



main $@

##

#
