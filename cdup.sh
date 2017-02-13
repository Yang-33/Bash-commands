#!/bin/sh
#For easily chenge deirectory up

if [ $# -ne 2 ]; then
    echo "Usege: [ The abbreviation fot a file ] [filename]"
    exit 1
fi


BASE="competitive-programming/"
Purpose_directory=""
file_directory=""

str=$1

case "$str" in
    ab )   Purpose_directory="atcoder/ABC/"
           file_directory="atcoder/ABC_solve/ABC_solve/"  ;;
    ar )   Purpose_directory="atcoder/ARC/"
           file_directory="atcoder/ARC_solve/ARC_solve/"  ;;
    ao )   Purpose_directory="AOJ_DPL/"
           file_directory="AOJ_solved/AOJ_solved/"  ;;
    tdpc ) Purpose_directory="atcoder/TDPC/"
           file_directory="atcoder/solve_TDPC_file/solve_TDPC_file/"  ;; 
    
    * )    echo "there is no file such a file \"$1\" " ;;
esac

echo $Purpose_directory

cd /mnt/c/home

cp ${BASE}${file_directory}$2 ${BASE}${Purpose_directory}


#to do 

# remove bugs about varionus scope ploblems

# just copy file from last update (time comparision)
#    and show copied files (with echo)

# option commands -> directory name

# 
#
#
#


