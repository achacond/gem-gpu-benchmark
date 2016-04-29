#!/bin/bash

#SBATCH --job-name="Cushaw2-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --gres=gpu:2

#SBATCH --output=../../logs/CUSHAW2-GPU.installation_mapping_tools.log
#SBATCH --error=../../logs/CUSHAW2-GPU.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"CUSHAW2-GPU.installation_mapping_tools.err

# Install Cushaw2-GPU V2.1.8-r16
####################################
# By default "have_ssse3 = 1"
# Makefile modified with GPU_ARCH = sm_35
####################################

echo "Start installing Cushaw2-GPU V2.1.8-r16"
echo "Start installing Cushaw2-GPU V2.1.8-r16" > $logfile 2>&1
rm -Rf cushaw2-gpu-2.1.8-r16
rm -f cushaw2-gpu-2.1.8-r16.tar.gz

echo "Downloading cushaw2-gpu-2.1.8-r16.tar.gz ..."
wget http://downloads.sourceforge.net/project/cushaw2/CUSHAW2-GPU/cushaw2-gpu-2.1.8-r16.tar.gz >> $logfile 2>&1

echo "Unpaking ..."
tar -xvzf cushaw2-gpu-2.1.8-r16.tar.gz >> $logfile 2>&1

echo "Patching with custom settings ..."
cd cushaw2-gpu-2.1.8-r16
patch Makefile < ../patches/cushaw2-gpu/cushaw2-gpu.patch 

echo "Compiling ..."
make clean all >> ../$logfile 2>&1

echo "Downloading cushaw2_index.tar.gz ..."
wget http://downloads.sourceforge.net/project/cushaw2/CUSHAW2%20Indexer/cushaw2_index.tar.gz >> ../$logfile 2>&1

echo "Unpaking ..."
tar -xzvf cushaw2_index.tar.gz >> ../$logfile 2>&1

echo "Compiling ..."
cd cushaw2_index
make clean all >> ../../$logfile 2>&1

echo "Cleaning ..."
cd ..
rm -f cushaw2_index.tar.gz >> ../$logfile 2>&1
cd ..
rm -f cushaw2-gpu-2.1.8-r16.tar.gz >> $logfile 2>&1
echo "Done"
echo ""
