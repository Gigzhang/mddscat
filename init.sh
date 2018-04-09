#!/usr/bin/env bash

exeFiles=("ddpostprocess" "ddscat" "calltarget" "vtrconvert" "getpar", "ddp.sh")
currentDir=`pwd`

for exeFile in ${exeFiles[@]};do
    sudo ln -s $currentDir"/"$exeFile "/usr/bin/m"$exeFile
done