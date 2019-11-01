#!/bin/bash
#
# Created By: ellacarmon
# Github: github.com/ellacarmon
# License: MIT
# CopyWrite: 2019
#
echo "############## Welcome ################"
echo "First argument will be the path to install the script, default is home folder"
echo "Second argument will be the source profile folder, deafult is ~/.zshrc"
echo ""

PATH_TO_INSTALL=$HOME/

if [[ -n $1 ]]
    then
        PATH_TO_INSTALL=$1
fi

echo "The path of the script is ${PATH_TO_INSTALL}"
echo ""
echo "Cloning script to ${PATH_TO_INSTALL}"
cd ${PATH_TO_INSTALL}
git clone https://github.com/ellacarmon/fd.git
cd fd
OLD_CONF='CONF=config.conf'
NEW_CONF="CONF=${PATH_TO_INSTALL}config.conf"
echo ${NEW_CONF}
sed "s~$OLD_CONF~$NEW_CONF~" fav_dir.sh
cp fav_dir.sh ${PATH_TO_INSTALL}
SOURCE_FOLDER=~/.zshrc
if [[ -n $2 ]]
    then
        SOURCE_FOLDER=$2
fi

echo "source folder is ${SOURCE_FOLDER}"
echo "adding fav alias"
ALIAS='alias fav="'${PATH_TO_INSTALL}'fav_dir.sh"'

echo ${ALIAS} >> ${SOURCE_FOLDER}
source ${SOURCE_FOLDER}


echo "DONE!"%