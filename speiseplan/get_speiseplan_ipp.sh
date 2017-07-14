#!/bin/bash

grep_string=$(date +"KW%U_Speiseplan_IPP")
file_name=$grep_string'.pdf'
targetdir=/tmp/$USER/ipp_essen
mkdir -p $targetdir
targetfile=$targetdir'/'$file_name

if [ ! -f $targetfile ]; then
    cd $targetdir
    wget --spider -r --no-parent 'http://betriebsrestaurant-gmbh.de/index.php?id=91' &>tmp.txt
    address=$(cat tmp.txt | grep $grep_string | grep http | cut -d ' ' -f 4)
    wget $address
    tmp_file_name=$(echo $address | rev | cut -d '/' -f 1 | rev)
    mv $tmp_file_name $file_name
    rm tmp.txt
    cd -
fi

evince $targetfile &
