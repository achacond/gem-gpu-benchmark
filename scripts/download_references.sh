#!/bin/bash

source common.sh

#Changing working directory
original_path=`pwd`
reference_path="../data/references/"
cd $reference_path

# Human Reference v37
##############################

Human_reference='hsapiens_v37.fa 		https://googledrive.com/host/0Bw2Nno1-eC2IVk14X3E2Njh3TmM'

echo "$Human_reference" | while read file_name url ; do
	check_and_download $file_name $url
done

#Returning to original path
cd $original_path




