#!/bin/bash
#  . ./filetimecomp.sh


# if one file is newer than timefile then 
#   echo flename  else do nothing
#

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

copyfile(){


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

while  getopts  ab:ar:ao:tdpc:  OPT
do 
    case  ${OPT}  in  #2nd char is available
        b )   Purpose_directory="atcoder/ABC/"
               file_directory="atcoder/ABC_solve/ABC_solve/"
               echo "DIRECTORY is ABC" ;;
        r )   Purpose_directory="atcoder/ARC/"
               file_directory="atcoder/ARC_solve/ARC_solve/"
               echo "DIRECTORY is ARC" ;;
        o )   Purpose_directory="AOJ_DPL/"
               file_directory="AOJ_solved/AOJ_solved/"
               echo "DIRECTORY is AOJ" ;;
        d )   Purpose_directory="atcoder/TDPC/"
               file_directory="atcoder/solve_TDPC_file/solve_TDPC_file/"  
               echo "DIRECTORY is TDPC"  ;;
        * )   echo "there is not such a option."
               echo "Usege: cdup [ - dir option ] [filename]"
               exit 2  ;;

    esac
done


#shift `expr $OPTIND - 1`  

# copy

cd /mnt/c/home

cp ${BASE}${file_directory}$2 ${BASE}${Purpose_directory}

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



main(){

STIME=`\find . -name *.TM `

echo $STIME
EXP="*.sh"

## where?
OPTION=xxx

for File in `\find . -maxdepth 1 -type f -name "${EXP}" `; do
    time_comp $File $STIME 
    STATUS=$?

    if [ "$STATUS" -eq 0 ]; then
        
        echo $File
        echo "Yeah!"
    fi

done


}



main $@

##

#
