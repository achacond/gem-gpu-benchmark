#!/bin/bash

#SBATCH --job-name="tools-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

source node_profiles.sh

#Changing working directory
original_path=`pwd`
tools_path="../software/tools/"
cd $tools_path


logfile="../../logs/installation_tools.log"

echo "Path for log files:"
echo "     $logfile"
echo ""

rm -f $logfile

# Install GEMTools
##################################
echo "Start installing GEMTools"
echo "Start installing GEMTools" > $logfile


echo "Compiling ..."
cd GEMTools.Dev
make clean all >> $logfile 2>&1
cd ..

echo "Done"
echo ""

#Returning to original path
cd $original_path

