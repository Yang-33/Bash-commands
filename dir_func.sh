#!/bin/bash

# @(#) This script expresses directory setting.

. ./grobal_dir_name.sh

## dir <= grobal

<<FUNC

Set_TFile
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





