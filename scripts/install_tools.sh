#!/bin/bash

#SBATCH --job-name="tools-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --exclusive
#SBATCH --gres=gpu:2

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.9.1
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

