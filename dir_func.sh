#!/bin/bash

# @(#) This script expresses directory setting.

. ./grobal_dir_name.sh

## dir <= grobal

<<FUNC

Set_TFile
cd_to_upload_dir
copyfile
which_dir
opt_check
f_message()

FUNC


<<spec
 _option -> $1
 find TM file matched with option
 return TMFile name (Re_tm_name)
spec
Set_TFile()
{

    local Re_tm_name=
    local dir_name=
    local cur_dir=`pwd`

#    BASE="Bash-commands"
    BASE="competitive-programming"

    cd /mnt/c/home/${BASE}
    
    
    case  $1  in
        -b  )  dir_name="ABC" ;;
        -r  )  dir_name="ARC" ;;
        -o  )  dir_name="AOJ" ;;
        -d  )  dir_name="TDPC" ;;
        * ) echo "Error on Set_TFile. "
            exit 1 ;;
    esac
    
    
    Re_tm_name=`\find . -name "${dir_name}.TM" `
    local fullpass=`pwd`/"$Re_tm_name"
    
#    echo "fullpass is " $filepass

    cd $cur_dir

    echo $fullpass
}


<<spec
upload or visual => $1  _option -> $2
 move to upload directory
 no return
spec
cd_to_upload_dir()
{
    
    if [ $# -ne 2 ]
    then
        echo "Usege: cdgf [ - dir option ] [ - dir name ] on cd_to_upload_dir func"
        exit 1
    fi
    
    
    BASE="competitive-programming"
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
        
        -b )  if [ "$flag" = "TRUE" ] 
            then
            _purpose=${Pass_abc_u}
            else
            _purpose=${Pass_abc_v}
            fi ;;
        -r )  if [ "$flag" = "TRUE" ]
            then 
            _purpose=${Pass_arc_u}
            else 
            _purpose=${Pass_arc_v}
            fi ;;
        -o )  if [ "$flag" = "TRUE" ]
            then
            _purpose=${Pass_aoj_u}
            else
            _purpose=${Pass_aoj_v}
            fi ;;
        -d )  if [ "$flag" = "TRUE" ]
            then
            _purpose=${Pass_tdpc_u}
            else
            _puepose=${Pass_tdpc_v}
            fi ;;
        -* )  echo "there is not such a option. on cd_to_dir func error."
            echo "Usege: cdup [ - dir option ] [ - dir name]"
            exit 2  ;;
        
    esac
    
    
    #shift `expr $OPTIND - 1`  
    
    
    
    cd /mnt/c/home/${BASE}
    cd ${_purpose}


    if [ "$flag" = "TRUE" ]
    then    
        exec /bin/bash
    fi
    
}


<<spec
 OPT -> $1  file -> $2
 copy to purpose dirctory
 no return
spec
copyfile()
{
    
    
    if [ $# -ne 2 ]
    then
        echo "Usege: cdup [ - dir option ] [filename]"
        exit 1
    fi
    
    
    #variables
    
    BASE="competitive-programming/"
    local purpose_directory=""
    local file_directory=""
    
    local OPT=
    
    # --option
    
    while  getopts  brod  OPT
    do 
        case  ${OPT}  in  #2nd char is available
            b )   purpose_directory=${Pass_abc_u}
                file_directory=${Pass_abc_v}
                ;;
#                echo "DIRECTORY is ABC" ;;
            r )   purpose_directory=${Pass_arc_u}
                file_directory=${Pass_arc_v}
                ;;
#               echo "DIRECTORY is ARC" ;;
            o )   purpose_directory=${Pass_aoj_u}
                file_directory=${Pass_aoj_v}
                ;;
#                echo "DIRECTORY is AOJ" ;;
            d )   purpose_directory=${Pass_tdpc_u}
                file_directory=${Pass_tdpc_v}
                ;;
#                echo "DIRECTORY is TDPC"  ;;
            * )   echo "there is not such a option."
                echo "Usege: cdup [ - dir option ] [filename]"
                echo "Erorr on copyfile func."
                exit 2  ;;
            
        esac
    done
    
    
    #shift `expr $OPTIND - 1`  
    
    # copy
    
    cd /mnt/c/home
    
    cp ${BASE}${file_directory}$2 ${BASE}${purpose_directory}
#    AAA="Bash-commands/"
#    cp ${AAA}${file_directory}$2 ${BASE}${purpose_directory}
    
    
    cd /mnt/c/home/${BASE}${purpose_directory}
    
    # input date to the file
    
    local ptime=`date '+%Y/%m/%d'`
    
    sed -i -e "s|xtimex|$ptime|g" $2
    
    # message 
    
    if [ -e $2 ]
    then
        echo $2 "has been copied! "
    else 
        echo "Failure. " $2 "has not been copied. " 
    fi
    
    
}



<<spec
 pwd->$1
 check dir name 
 return dir option (Re_opt)
spec
which_dir(){
  
    
    local Re_opt=
    
    case  $1  in
        *ABC*  )  Re_opt="-b" ;;
        *ARC*  )  Re_opt="-r" ;;
        *AOJ*  )  Re_opt="-o" ;;
        *TDPC* )  Re_opt="-d" ;;
        * )   echo "This directory is not for competitiveprogramming."
            echo "Usege: (on matched dir) command [-option]"
            echo "Error on which dir func."
            exit 2  ;;
        
    esac

    echo ${Re_opt}
    
}


<<spec
 opt -> $1
 check inputed option presence
 return dir option (Re_opt)
spec
opt_check()
{
    
    local Re_opt=
    
    case  $1  in
        -b  )  Re_opt="-b" ;;
        -r  )  Re_opt="-r" ;;
        -o  )  Re_opt="-o" ;;
        -d  )  Re_opt="-d" ;;
        * )   echo "There is no presence such a option " $1
            echo "Usege: (on matched dir) command [-option]"
            echo "Error on opt_check func."
            exit 2  ;;
        
    esac
    
    echo ${Re_opt}
    
}



<<spec
 _option -> $1
 out dir name
 no return
spec
f_message()
{

    case  $1  in
        -b  )  echo "Purpose Directory is ABC."   ;;
        -r  )  echo "Purpose Directory is ARC."   ;;
        -o  )  echo "Purpose Directory is AOJ."   ;;
        -d  )  echo "Purpose Directory is TDPC."  ;;
         *  )  echo "Erorr on f_message func. "     
            exit 2 ;;       
    esac
    
}





