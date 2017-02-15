#!/bin/bash
#  . ./filetimecomp.sh


# if one file is newer than timefile then 
#   echo flename  else do nothing
#


##this is test case about Bash-commands were abc and comp-prog file. 


# _option -> $1
# find TM file matched with option
# return TMFile name (Re_tm_name)
Set_TFile()
{

    local Re_tm_name=
    local dir_name=
    local cur_dir=`pwd`

    BASE="Bash-commands"
# BASE="competitive-programming"
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
    

    cd $cur_dir
    echo $Re_tm_name
}


# sth.TM -> $1
# write time and info
# no return
write_time()
{

    local ptime=`date`
    local mes="=>  $ptime"
    
    sed -i "/=>/c $mes" $1
    
#    cat $1

}



#  _option -> $1
# move to upload directory
# no return
cd_to_upload_dir()
{

    if [ $# -ne 1 ]
    then
        echo "Usege: cdgf [ - dir option ] [ - dir name ] on cd_to_upload_dir func"
        exit 1
    fi
    
    
    BASE="competitive-programming"
   
    local _OPT=$1
    local _purpose=
    
    case  ${_OPT}  in  
        
        #u )   FLAG="TRUE" ;;
        #v )   FLAG="FALSE" ;;
        
        -b )  _purpose="atcoder/ABC"
            ;;
        -r )  _purpose="atcoder/ARC"
            ;;
        -o )  _purpose="AOJ_DPL"
            ;;
        -d )  _purpose="atcoder/TDPC"
            ;;
        * )  echo "there is not such a option. on cd_to_dir func error."
            echo "Usege: cdup [ - dir option ] [ - dir name]"
            exit 2  ;;
        
    esac
    
    
    #shift `expr $OPTIND - 1`  
    
    
    
    cd /mnt/c/home/${BASE}
    cd ${_purpose}
    
    exec /bin/bash
    
}



# checked file -> $1  TM -> $2
# compare file time
# return 0 (time: 1 > 2) , 1 (false)
time_comp()
{
        
    if [ $# -ne 2 ]
    then
        echo "Usage: command file1 file2" 1>&2
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



# OPT -> $1  file -> $2
# copy to purpose dirctory
# no return
copyfile()
{ # !!test mode
    
    
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
            b )   purpose_directory="atcoder/ABC/"
                #               file_directory="atcoder/ABC_solve/ABC_solve/"
                file_directory="" 
                ;;
#                echo "DIRECTORY is ABC" ;;
            r )   purpose_directory="atcoder/ARC/"
                file_directory="atcoder/ARC_solve/ARC_solve/"
                ;;
#               echo "DIRECTORY is ARC" ;;
            o )   purpose_directory="AOJ_DPL/"
                file_directory="AOJ_solved/AOJ_solved/"
                ;;
#                echo "DIRECTORY is AOJ" ;;
            d )   purpose_directory="atcoder/TDPC/"
                file_directory="atcoder/solve_TDPC_file/solve_TDPC_file/"  
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
    
    #cp ${BASE}${file_directory}$2 ${BASE}${Purpose_directory}
    AAA="Bash-commands/"
    cp ${AAA}${file_directory}$2 ${BASE}${purpose_directory}
    
    
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


# pwd->$1
# check dir name 
# return dir option (Re_opt)
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

# opt -> $1
# check inputed option presence
# return dir option (Re_opt)
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


# _option -> $1
# out dir name
# no return
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


main()
{
    
    ## cpp .....
    EXP="*.sh"
    
    local cur_dir=`pwd`
    local _option=
    local status=
    # opt check and decision
    if [ $# -eq 0 ]
    then 
        _option=`which_dir $cur_dir `
        
    elif [ $# -eq 1 ]
    then #opt check
        _option=`opt_check $1 `
    else
        echo "Usege: command [-option]"
        exit 1
    fi
    
    f_message $_option
    
    
##| test
    local tm_file=`Set_TFile $_option`

    echo "tm_file is " $tm_file
    
    for File in `\find . -maxdepth 1 -type f -name "${EXP}" `
    do
        time_comp $File $tm_file 
        status=$?
        
        if [ "$status" -eq 0 ]
        then
            (  copyfile $_option $File   ) 
            
            # this line has not been tested yet !!!!!!!!!!    
            #        cd ${cur_dir}
        fi
        
        
    done
    
    write_time $tm_file

#for debug this func stop
#    cd_to_upload_dir $_option

}



main $@

##

#
