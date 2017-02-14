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

main(){

STIME=`\find . -name *.TM `

echo $STIME

for File in `\find . -maxdepth 1 -type f`; do
time_comp $File $STIME 
STATUS=$?
if [ "$STATUS" -eq 0 ]; then
echo $File
echo "Yeah!"
fi
#then echo "Yeah!"
 #fi

done


}



main $@

##

#
