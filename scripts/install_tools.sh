#!/bin/bash

if [[ -n $(hostname | grep aopccuda) ]]; then
	echo "Aopccuda Node"
	source /etc/profile.d/module.sh
	module load GCC/4.8.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	echo "Huberman Node"
	module load gcc/4.8.1
fi


#Changing working directory
original_path=`pwd`
tools_path="../software/tools/"
cd $tools_path


output_log="../../logs/installation_tools.out"
error_log="../../logs/installation_tools.err"

echo "Path for log files:"
echo "     $output_log"
echo "     $error_log"
echo ""

rm -f $output_log $error_log

# Install GEMTools
##################################
echo "Start installing GEMTools"

echo "Compiling ..."
cd GEMTools.Dev
make clean all >> ../$output_log 2>> ../$error_log
cd ..

echo "Done"
echo ""

#Returning to original path
cd $original_path

