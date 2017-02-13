#!/bin/sh

#For easily chenge deirectory up

if [ $# -ne 2 ]; then
    echo "Usege: cdup [ - dir option ] [filename]"
    exit 1
fi


BASE="competitive-programming/"
Purpose_directory=""
file_directory=""

OPT=

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

cd /mnt/c/home

cp ${BASE}${file_directory}$2 ${BASE}${Purpose_directory}

cd /mnt/c/home/${BASE}${Purpose_directory}

PTIME=`date '+%Y/%m/%d'`

sed -i -e "s|xtimex|$PTIME|g" $2

if [ -e $2 ]
then
    echo $2 "has been copied! "
else echo "Failure. " $2 "has not been copied. " 
    
fi

#to do 

# just copy file from last update (time comparision)
#    and show copied files (with echo)

#
#
#


