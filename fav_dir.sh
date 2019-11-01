#!/bin/bash
#
# Created By: ellacarmon
# Github: github.com/ellacarmon
# License: MIT
# CopyWrite: 2019
#
set -e
echo "############## Welcome ################"
echo ""

function show_favorites {
    favorites=(${DIR1} ${DIR2} ${DIR3} ${DIR4} ${DIR5})
    echo "Here are your TOP5 direcotries"
    for i in "${!favorites[@]}"; do
      let index=${i}+1
      printf '[%s] %s\n' ${index} "${favorites[i]}"
    done
}

function choose_favorite {
    echo "Please choose your desired directory"
    read chosen_dir
    echo cd ${favorites[$chosen_dir-1]}
    cd ${favorites[$chosen_dir-1]}
    }
function config_file {
    CONF=config.conf
    if [[  -f ${CONF} ]];
    then
        echo "Sourcing config file"
        source ${CONF}
        echo "sourced ${CONF}"
        echo " "
    else
        echo "No config file was found"
        echo "Please provide your top 5 directories"
        read dir1 dir2 dir3 dir4 dir5 dir6
        echo "DIR1=${dir1} DIR2=${dir2} DIR3=${dir3} DIR4=${dir4} DIR5=${dir5}" | tr " " "\n" > ${CONF}
        source ${CONF}
    fi
}
if [[ -z "$1" ]]
  then
     config_file
     show_favorites
     choose_favorite
fi
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo " "
      echo "options:"
      echo "-h,   --help                     show brief help"
      echo "-nc,  --new_config               change all 5 favorites folders"
      echo "-cf,  --change_favorite          change a specific folder"
      exit 0
      ;;
    -nc | --new_config)
      echo "######## entering config mode #########"
      echo "Please provide your top 5 directories"
      read dir1 dir2 dir3 dir4 dir5
      echo "DIR1=${dir1} DIR2=${dir2} DIR3=${dir3} DIR4=${dir4} DIR5=${dir5}" | tr " " "\n" > config.conf
      echo "done"
      shift
      ;;
    -cf | --change_favorite)
      config_file
      echo "######## entering config mode #########"
      favorites=(${DIR1} ${DIR2} ${DIR3} ${DIR4} ${DIR5})
      show_favorites
      echo "which directory you would like to replace?"
      read dir_index
      echo "please enter your new favorite directory path"
      read new_dir
      export DIR${dir_index}=${new_dir}
      echo "DIR1=${DIR1} DIR2=${DIR2} DIR3=${DIR3} DIR4=${DIR4} DIR5=${DIR5}"  | tr " " "\n" > config.conf
      echo ""
      show_favorites
      shift
      ;;
     *)
     echo "unexpected argument $1"
     break
     ;;
  esac
done
