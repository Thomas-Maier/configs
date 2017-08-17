#!/bin/bash

kw=$(date +"KW%U")
suffix="Speiseplan-IPP.pdf"
file_name=$kw'_'$suffix
targetdir=/tmp/$USER/ipp_essen
mkdir -p $targetdir
targetfile=$targetdir'/'$file_name

if [ ! -f $targetfile ]; then
    cd $targetdir
    wget --spider -r 'http://konradhof-catering.de/ipp/' &>tmp.txt
    address=$(cat tmp.txt | grep https | grep $kw | grep $suffix | cut -d ' ' -f 4)
    wget $address
    tmp_file_name=$(echo $address | rev | cut -d '/' -f 1 | rev)
    mv $tmp_file_name $file_name
    rm tmp.txt
    cd -
fi

evince $targetfile &
