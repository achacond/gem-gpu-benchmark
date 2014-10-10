#!/bin/bash

#Changing working directory
original_path=`pwd`
scripts_path="scripts"
cd $scripts_path

date_var=`date`
echo "     ==>   Run experiments $date_var  <=="
./run_benchmarks.sh

#Returning to original path
cd $original_path


