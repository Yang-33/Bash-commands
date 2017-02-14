#!/bin/sh

# command file1 file2
# if file1 is newer then file2 => 0(true) else 1(false)

function time_comp(){


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

