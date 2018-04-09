#!/usr/bin/env bash

# clear the redundancy files

 currentDir=`pwd`
 pushd $currentDir
 rm -r *.avg
 rm -r *.sca
 rm -r *.fml
 popd