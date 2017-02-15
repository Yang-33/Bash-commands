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
 return TMFile name (re_tm_name)
spec
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
        "-$Optname_abc"   )  dir_name="ABC" ;;
        "-$Optname_arc"   )  dir_name="ARC" ;;
        "-$Optname_aoj"   )  dir_name="AOJ" ;;
        "-$Optname_tdpc"  )  dir_name="TDPC" ;;
        * ) echo "Error on Set_TFile. "
            exit 1 ;;
    esac
    
    
    re_tm_name=`\find . -name "${dir_name}.TM" `
    local fullpass=`pwd`/"$re_tm_name"
    
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
        
        "-$Optname_abc"  )  if [ "$flag" = "TRUE" ] 
            then
            _purpose=${Pass_abc_u}
            else
            _purpose=${Pass_abc_v}
            fi ;;
        "-$Optname_arc"  )  if [ "$flag" = "TRUE" ]
            then 
            _purpose=${Pass_arc_u}
            else 
            _purpose=${Pass_arc_v}
            fi ;;
        "-$Optname_aoj"  )  if [ "$flag" = "TRUE" ]
            then
            _purpose=${Pass_aoj_u}
            else
            _purpose=${Pass_aoj_v}
            fi ;;
        "-$Optname_tdpc" )  if [ "$flag" = "TRUE" ]
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
    
    
    cd ${Home}
    cd ${Base}
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
    
#    Base="competitive-programming/"
    local purpose_directory=""
    local file_directory=""
    
    local OPT=
    
    # --option
    
    while  getopts  brod  OPT
    do 
        case  ${OPT}  in  #2nd char is available
            "$Optname_abc" )   purpose_directory=${Pass_abc_u}
                file_directory=${Pass_abc_v}
                ;;
#                echo "DIRECTORY is ABC" ;;
            "$Optname_arc" )   purpose_directory=${Pass_arc_u}
                file_directory=${Pass_arc_v}
                ;;
#               echo "DIRECTORY is ARC" ;;
            "$Optname_aoj" )   purpose_directory=${Pass_aoj_u}
                file_directory=${Pass_aoj_v}
                ;;
#                echo "DIRECTORY is AOJ" ;;
            "$Optname_tdpc" )   purpose_directory=${Pass_tdpc_u}
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
    
    cd ${Home}
    
    cp ${Base}${file_directory}$2 ${Base}${purpose_directory}
    
    
    cd ${Home}
    cd ${Base}${purpose_directory}
    
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
  
    
    local re_opt=
    
    case  $1  in
        *ABC*  )  re_opt="-$Optname_abc"  ;;
        *ARC*  )  re_opt="-$Optname_arc"  ;;
        *AOJ*  )  re_opt="-$Optname_aoj"  ;;
        *TDPC* )  re_opt="-$Optname_tdpc" ;;
        * )   echo "This directory is not for competitiveprogramming."
            echo "Usege: (on matched dir) command [-option]"
            echo "Error on which dir func."
            exit 2  ;;
        
    esac

    echo ${re_opt}
    
}


<<spec
 opt -> $1
 check inputed option presence
 return dir option (Re_opt)
spec
opt_check()
{
    
    local re_opt=

    case  $1  in
        "-$Optname_abc"  )  re_opt="-$Optname_abc"  ;;
        "-$Optname_arc"  )  re_opt="-$Optname_arc"  ;;
        "-$Optname_aoj"  )  re_opt="-$Optname_aoj"  ;;
        "-$Optname_tdpc" )  re_opt="-$Optname_tdpc" ;;
        * )   echo "There is no presence such a option " $1
            echo "Usege: (on matched dir) command [-option]"
            echo "Error on opt_check func."
            exit 2  ;;
        
    esac
    
    echo ${re_opt}
    
}



<<spec
 _option -> $1
 out dir name
 no return
spec
f_message()
{

    case  $1  in
        "-$Optname_abc"  )  echo "Purpose Directory is ABC."   ;;
        "-$Optname_arc"  )  echo "Purpose Directory is ARC."   ;;
        "-$Optname_aoj"  )  echo "Purpose Directory is AOJ."   ;;
        "-$Optname_tdpc" )  echo "Purpose Directory is TDPC."  ;;
         *  )  echo "Erorr on f_message func. "     
            exit 2 ;;       
    esac
    
}





