#!/bin/bash

# @(#) upcpp is copy new file to upload directory and write time to it (c++ file)

# if you want to change file expression, then you can set grobal_exp.sh


write_time()
{

    local ptime=`date`
    local mes="=>  $ptime"
    
    sed -i "/=>/c $mes" $1
    
#    cat $1

    local sum=`sed -n -e "s/upload sumation is //p" $1`
    local part=$2
    local now=$((sum+part))
    local mes2="upload sumation is $now"
    sed -i "/upload sumation/c $mes2" $1

    local dtime=`date '+%Y/%m/%d'`
    echo $dtime " " $part " problems solved." >> $1

}


big_char_conversion()
{

    local sname=$(basename "$1")
    local sbase=$(echo "$sname" | sed -e 's/\.[^.]*$//')
    local dbase=$(echo "$sbase" | tr a-z A-Z )
    local ext=${Ext}

    local refile="$dbase"."$ext"

    echo $refile
}

char_code_conversion()
{
    local pfile=$1

    iconv -f SHIFT_JIS -t UTF-8 $1 -o $pfile

    echo $pfile
}


Set_TFile()
{

    local re_tm_name=
    local dir_name=
    local cur_dir=`pwd`

#    BASE="Bash-commands"
#    BASE="competitive-programming"

    cd ${Home}
    cd ${Base}
    
    
    case  $1  in
        "-$Optname_atcoder"   )          dir_name="ATCODER" ;;
        "-$Optname_abc"   )              dir_name="ABC" ;;
        "-$Optname_codeforces"   )       dir_name="CODEFORCES" ;;
        "-$Optname_tdpc"  )              dir_name="TDPC" ;;
        "-$Optname_projecteular"   )     dir_name="PROJECTEULAR" ;;
        "-$Optname_codechef"   )         dir_name="CODECHEF" ;;
        "-$Optname_agc"   )              dir_name="AGC" ;;
        "-$Optname_hackerrank"  )        dir_name="HACKERRANK" ;;
        "-$Optname_joioi"   )            dir_name="JOI_IOI" ;;
        "-$Optname_aoj"   )              dir_name="AOJ" ;;
        "-$Optname_poj"   )              dir_name="POJ" ;;
        "-$Optname_arc"  )               dir_name="ARC" ;;
        "-$Optname_srm"   )              dir_name="SRM" ;;
        "-$Optname_topcoder"   )         dir_name="TOPCODER" ;;
        "-$Optname_uva"   )              dir_name="UVA" ;;
        "-$Optname_yukicoder"  )         dir_name="YUKICODER" ;;
        * ) echo "Error on Set_TFile. "
            exit 1 ;;
    esac
    
    
    re_tm_name=`\find . -name "${dir_name}.TM" `
    local fullpass=`pwd`/"$re_tm_name"
    
#    echo "fullpass is " $filepass

    cd $cur_dir

    echo $fullpass
}



opt_check()
{
    
    local re_opt=

    case  $1  in
        "-$Optname_atcoder" ) re_opt="-$Optname_atcoder" ;;
        "-$Optname_abc"  )  re_opt="-$Optname_abc"  ;;
        "-$Optname_codeforces"  )  re_opt="-$Optname_codeforces"  ;;
        "-$Optname_tdpc"  )  re_opt="-$Optname_tdpc"  ;;
        "-$Optname_projecteular"  )  re_opt="-$Optname_projecteular"  ;;
        "-$Optname_codechef"  )  re_opt="-$Optname_codechef"  ;;
        "-$Optname_agc"  )  re_opt="-$Optname_agc"  ;;
        "-$Optname_hackerrank"  )  re_opt="-$Optname_hackerrank"  ;;
        "-$Optname_joioi"  )  re_opt="-$Optname_joioi"  ;;
        "-$Optname_aoj"  )  re_opt="-$Optname_aoj"  ;;
        "-$Optname_poj"  )  re_opt="-$Optname_poj"  ;;
        "-$Optname_arc"  )  re_opt="-$Optname_arc"  ;;
        "-$Optname_srm"  )  re_opt="-$Optname_srm"  ;;
        "-$Optname_topcoder"  )  re_opt="-$Optname_topcoder"  ;;
        "-$Optname_uva"  )  re_opt="-$Optname_uva"  ;;
        "-$Optname_yukicoder"  )  re_opt="-$Optname_yukicoder"  ;;
        * )   echo "There is no presence such a option " $1
            echo "Usege: (on matched dir) opt_check [-option]"
            echo "Error on opt_check func."
            exit 2  ;;
        
    esac
    
    echo ${re_opt}
    
}

f_message()
{

    echo "option is $1"
<<SOME
    case  $1  in
        "-$Optname_abc"  )  echo "Purpose Directory is ABC."   ;;
        "-$Optname_arc"  )  echo "Purpose Directory is ARC."   ;;
        "-$Optname_aoj"  )  echo "Purpose Directory is AOJ."   ;;
        "-$Optname_tdpc" )  echo "Purpose Directory is TDPC."  ;;
         *  )  echo "Erorr on f_message func. "     
            exit 2 ;;       
    esac
SOME
}

cd_to_upload_dir()
{
    
    if [ $# -ne 2 ]
    then
        echo "Usege: cd_to_upload_dir [ - dir option ] [ - dir name ]"
        echo "Erorr on cd_to_upload_dir func."
        exit 1
    fi
    
    
 #   Base="competitive-programming"
    local flag=
    local _OPT=$2
    local _purpose=
    

    if [ "$1" = "-u" ]
    then
        flag="TRUE"
    elif [ "$1" = "-v" ]
    then
        flag="FALSE"
    else
        echo "no option like " $1
        echo "Error on cd_to_upload_dir func."
    fi    


    case  ${_OPT}  in     
        
        "-$Optname_atcoder" )   _purpose=${Pass_atcoder_u}               ;;
        "-$Optname_abc" )   _purpose=${Pass_abc_u}               ;;
        "-$Optname_codeforces" )   _purpose=${Pass_codeforces_u}               ;;
        "-$Optname_tdpc" )   _purpose=${Pass_tdpc_u}               ;;
        "-$Optname_projecteular" )   _purpose=${Pass_projecteular_u}             ;;
        "-$Optname_codechef" )   _purpose=${Pass_codechef_u}               ;;
        "-$Optname_agc" )   _purpose=${Pass_agc_u}               ;;
        "-$Optname_hackerrank" )   _purpose=${Pass_hackerrank_u}               ;;
        "-$Optname_joioi" )   _purpose=${Pass_joioi_u}             ;;
        "-$Optname_aoj" )   _purpose=${Pass_aoj_u}               ;;
        "-$Optname_poj" )   _purpose=${Pass_poj_u}               ;;
        "-$Optname_arc" )   _purpose=${Pass_arc_u}               ;;
        "-$Optname_srm" )   _purpose=${Pass_srm_u}             ;;
        "-$Optname_topcoder" )   _purpose=${Pass_topcoder_u}               ;;
        "-$Optname_uva" )   _purpose=${Pass_uva_u}               ;;
        "-$Optname_yukicoder" )   _purpose=${Pass_yukicoder_u}               ;;
        
        -* )  echo "there is not such a option. on cd_to_dir func error."
            echo "Usege: cd_to_upload_dir [ - dir option ] [ - dir name]"
            exit 2  ;;
        
    esac
    
    if [ "$flag" = "FALSE" ]
    then 
        _purpose=${Origin}    
    fi    
    cd ${Home}
    cd ${Base}
    cd ${_purpose}


    if [ "$flag" = "TRUE" ]
    then    
        exec /bin/bash
    fi
    
}


copyfile()
{
    
    
    if [ $# -ne 2 ]
    then
        echo "Usege: copyfile [ - dir option ] [filename]"
        exit 1
    fi
    
    
    #variables
    
    local purpose_directory=""
    local file_directory=${Origin}
    
    local OPT=
    
    # --option
    
    while  getopts  brod  OPT
    do 
        case  ${OPT}  in  #2nd char is available
            "$Optname_atcoder" )   purpose_directory=${Pass_atcoder_u}               ;;
            "$Optname_abc" )   purpose_directory=${Pass_abc_u}               ;;
            "$Optname_codeforces" )   purpose_directory=${Pass_codeforces_u}               ;;
            "$Optname_tdpc" )   purpose_directory=${Pass_tdpc_u}               ;;
            "$Optname_projecteular" )   purpose_directory=${Pass_projecteular_u}             ;;
            "$Optname_codechef" )   purpose_directory=${Pass_codechef_u}               ;;
            "$Optname_agc" )   purpose_directory=${Pass_agc_u}               ;;
            "$Optname_hackerrank" )   purpose_directory=${Pass_hackerrank_u}               ;;
            "$Optname_joioi" )   purpose_directory=${Pass_joioi_u}             ;;
            "$Optname_aoj" )   purpose_directory=${Pass_aoj_u}               ;;
            "$Optname_poj" )   purpose_directory=${Pass_poj_u}               ;;
            "$Optname_arc" )   purpose_directory=${Pass_arc_u}               ;;
            "$Optname_srm" )   purpose_directory=${Pass_srm_u}             ;;
            "$Optname_topcoder" )   purpose_directory=${Pass_topcoder_u}               ;;
            "$Optname_uva" )   purpose_directory=${Pass_uva_u}               ;;
            "$Optname_yukicoder" )   purpose_directory=${Pass_yukicoder_u}               ;;
            
            * )   echo "there is not such a option."
                echo "Usege: copyfile [ - dir option ] [filename]"
                echo "Erorr on copyfile func."
                exit 2  ;;
            
        esac
    done
    
    
    #shift `expr $OPTIND - 1`  
    
    # copy
    
    cd ${Home}
    
    local new_name=`big_char_conversion $2`

    cp ${Base}${file_directory}$2 ${Base}${purpose_directory}${new_name}
    
    cd ${Home}
    cd ${Base}${purpose_directory}
    
    # input date to the file

    local new_file=`char_code_conversion $new_name`
    
    local ptime=`date '+%Y/%m/%d'`

    sed -i -e "s|xtimex|$ptime|g" ${new_file}
    
    slackify $new_file upload

    # message 
    
#    if [ -e $2 ]
#    then
#        echo $2 "has been copied! "
#    else 
#        echo "Failure. " $2 "has not been copied. " 
#    fi
    
    
}

time_comp()
{
        
    if [ $# -ne 2 ]
    then
        echo "Usage: time_comp file1 file2" 1>&2
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


tmfile_update()
{

    cd ${Home}${Base}

    for File in `\find . -maxdepth 1 -type f -name "${Tm}"`
    do 
        echo "the file is updated :: $File"
        sed -i -e "s|update|update|g" ${File}
    done

}




main()
{


    Exp="*.cpp"
    Ext="cpp"
    Tm="*.TM"
    Command_name="upcpp"


# for windows 
    Home="/mnt/c/home/"
    # for ubuntu
   # Home="/media/yang33/VERSION/home/"
    Base="competitive-programming/"
    Origin="solve/"
    # pass & option
 ######################################   
    Pass_atcoder_u="atcoder/"
    Optname_atcoder="a"

    Pass_abc_u="atcoder/ABC/"
    Optname_abc="b"

    Pass_codeforces_u="codeforces/"
    Optname_codeforces="c"

    Pass_tdpc_u="atcoder/TDPC/"
    Optname_tdpc="d"

    Pass_projecteular_u="ProjectEular/"
    Optname_projecteular="e"

    Pass_codechef_u="Codechef/"
    Optname_codechef="f"

    Pass_agc_u="atcoder/AGC/"
    Optname_agc="g"

    Pass_hackerrank_u="HackerRank/"
    Optname_hackerrank="h"

    Pass_joioi_u="JOI_IOI/"
    Optname_joioi="j"
    
    Pass_aoj_u="AOJ/"
    Optname_aoj="o"

    Pass_poj_u="POJ/"
    Optname_poj="p"
    
    Pass_arc_u="atcoder/ARC/"
    Optname_arc="r"
    
    Pass_srm_u="topcoder/SRM/"
    Optname_srm="s"

    Pass_topcoder_u="topcoder/"
    Optname_topcoder="t"

    Pass_uva_u="Uva/"
    Optname_uva="u"
    
    Pass_yukicoder_u="Yukicoder/"
    Optname_yukicoder="y"

    
    local cur_dir=`pwd`
    local _option=
    local status=
    local count=0    


    # opt check and decision
    #if [ $# -eq 0 ]
    #then 
    #    _option=`which_dir $cur_dir `
    #    
    #el
    if [ $# -eq 1 ]
    then #opt check
        _option=`opt_check $1 `
    else
        echo "Usege: $Command_name [-option]"
        exit 1
    fi

    
    f_message $_option
    
    
    local tm_file=`Set_TFile $_option`

    echo "tm_file is " $tm_file
    

    cd_to_upload_dir -v $_option


    for File in `\find . -maxdepth 1 -type f -name "${Exp}" `
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


    write_time $tm_file $count

    tmfile_update

    cd_to_upload_dir -u $_option
    
}

main $@

##

#
