#!/usr/bin/env bash


# create directory
createDir() {
	local localPath=$1
	if [ ! -d $localPath ]; then
		mkdir $localPath
	fi
}

varInfo=("x" "y" "z")
currentDir=`pwd`

for varItem in ${varInfo[@]};do
	pushd $currentDir
	mgetpar $varItem
	mddpostprocess
	createDir $varItem
	
	cp "ddpostprocess.par" $varItem
	cp "ddpostprocess.out" $varItem

	popd
done
