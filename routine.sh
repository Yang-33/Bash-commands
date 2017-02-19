#!/bin/bash



<<spec
 file => $1
 shift-jis file to utf-8 file 
 return re file
spec

big_char_conversion()
{

    local sname=$(basename "$1")
    local sbase=$(echo "$sname" | sed -e 's/\.[^.]*$//')
    local dbase=$(echo "$sbase" | tr a-z A-Z )
    local ext="cpp"

    local refile="$dbase"."$ext"

    echo $refile
}

char_code_conversion()
{
    local pfile=$1

    iconv -f SHIFT_JIS -t UTF-8 $1 -o $pfile

    echo $pfile
}
