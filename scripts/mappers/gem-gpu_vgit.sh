#!/bin/bash

#SBATCH --job-name="GEM3GPU-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/GEM.installation_mapping_tools.log
#SBATCH --error=../../logs/GEM.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"GEM.installation_mapping_tools.err


# Install gem-gpu (git repository)
#####################################
# Makefile modified with: CUDAFLAG = -cuda -arch=sm_35 --ptxas-options=-v
#####################################

echo "Start installing gem-gpu from git repository"
echo "Start installing gem-gpu from git repository" > $logfile 2>&1

rm -Rf gem-gpu >> $logfile 2>&1

echo "Downloading gem-gpu ..."
git clone git@github.com:achacond/gem-gpu.git >> $logfile 2>&1

echo "Compiling ..."
cd gem-gpu
./configure >> ../$logfile 2>&1
make clean all >> ../$logfile 2>&1

cd ..
echo "Done"
echo ""
