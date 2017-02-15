#!/bin/bash

# @(#) This script expresses directory function and pass setting.

. ./grobal_dir_name.sh


<<FUNC

cd_to_upload_dir
copyfile

FUNC



<<spec
upload or visual => $1  _option -> $2
 move to upload directory
 no return
spec
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
            echo "Usege: cd_to_upload_dir [ - dir option ] [ - dir name]"
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
        echo "Usege: copyfile [ - dir option ] [filename]"
        exit 1
    fi
    
    
    #variables
    
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
                echo "Usege: copyfile [ - dir option ] [filename]"
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



