#!/bin/bash

#SBATCH --job-name="soap3gpu-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --gres=gpu:2

#SBATCH --output=../../logs/SOAP3DP-GPU.installation_mapping_tools.log
#SBATCH --error=../../logs/SOAP3DP-GPU.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"SOAP3DP-GPU.installation_mapping_tools.err


# Install Soap3-dp-GPU V2.3.r177
#####################################
# Makefile modified with: CUDAFLAG = -cuda -arch=sm_35 --ptxas-options=-v
#####################################

echo "Start installing Soap3-dp-GPU V2.3.r177"
echo "Start installing Soap3-dp-GPU V2.3.r177" > $logfile 2>&1

rm -Rf soap3-dp-2.3.r177 >> $logfile 2>&1
rm -f soap3-dp-src.tgz >> $logfile 2>&1

echo "Downloading soap3-dp-src.tgz ..."
wget http://downloads.sourceforge.net/project/soap3dp/r177-src/soap3-dp-src.tgz >> $logfile 2>&1

echo "Unpacking ..."
tar -xvzf soap3-dp-src.tgz >> $logfile 2>&1
mv release soap3-dp-2.3.r177 >> $logfile 2>&1

echo "Patching with custom settings ..."
cd soap3-dp-2.3.r177
patch Makefile < ../patches/soap3-pd/soap3-dp.patch >> ../$logfile 2>&1
patch soap3-dp.ini < ../patches/soap3-pd/soap3-dp.ini.patch  >> ../$logfile 2>&1

echo "Compiling ..."
make clean all >> ../$logfile 2>&1

echo "Cleaning ..."
cd ..
rm -f soap3-dp-src.tgz >> $logfile 2>&1
echo "Done"
echo ""


