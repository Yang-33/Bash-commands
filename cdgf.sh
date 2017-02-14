#!/bin/sh

# move to upload directory

# sth -> atcoder/ABC

if [ $# -ne 2 ]; then
    echo "Usege: cdgf [ - dir option ] [ - dir name ]"
    exit 1
fi


BASE="competitive-programming"
PURPOSE="atcoder/ABC"

# -u => for upload
# -v => for source 
# -b,-r,-o,-d => to ABC,ARC,AOJ,TDPC 

OPT=
FLAG=
# --option

while  getopts  uvbrod  OPT
do 
    case  ${OPT}  in  #2nd char is available
        
        u )   FLAG="TRUE" ;;
        v )   FLAG="FALSE" ;;
        
        b ) if [ "$FLAG" = "TRUE" ] 
            then
            PURPOSE="atcoder/ABC"
            else
            PURPOSE="atcoder/ABC_solve/ABC_solve"
            fi ;;
    #    r )   Purpose_directory="atcoder/ARC/"
     #          file_directory="atcoder/ARC_solve/ARC_solve/"
      #         echo "DIRECTORY is ARC" ;;
       # o )   Purpose_directory="AOJ_DPL/"
         #      file_directory="AOJ_solved/AOJ_solved/"
        #      echo "DIRECTORY is AOJ" ;;
       # d )   Purpose_directory="atcoder/TDPC/"
        #       file_directory="atcoder/solve_TDPC_file/solve_TDPC_file/"  
        #      echo "DIRECTORY is TDPC"  ;;
        * )   echo "there is not such a option."
              echo "Usege: cdup [ - dir option ] [filename]"
              exit 2  ;;

    esac
done


#shift `expr $OPTIND - 1`  



cd /mnt/c/home/${BASE}
cd ${PURPOSE}

exec /bin/bash

