#!/bin/bash

echo "############## Welcome ################"
echo ""


CONF=config.conf
if [[  -f ${CONF} ]];
then
    echo "Sourcing config file"
    source ${CONF}
    echo "sourced ${CONF}"
else
    echo "No config file was found"
    echo "Please provide your top 5 directories"
    read dir1 dir2 dir3 dir4 dir5 dir6

    echo "DIR1=${dir1} DIR2=${dir2} DIR3=${dir3} DIR4=${dir4} DIR5=${dir5}" | tr " " "\n" > config.conf
fi

favorites=(${DIR1} ${DIR2} ${DIR3} ${DIR4} ${DIR5})
echo "Here are your TOP5 direcotries"
for i in "${!favorites[@]}"; do
  printf '[%s] %s\n' "$i" "${favorites[i]}"
done

echo "Please choose your desired directory"
read chosen_dir
cd ${favorites[$chosen_dir]}
