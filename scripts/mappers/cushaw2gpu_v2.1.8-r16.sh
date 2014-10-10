#!/bin/bash

#SBATCH --job-name="Cushaw2-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --gres=gpu:2

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load CUDA/6.5.14
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load cuda/6.5
	module load gcc/4.9.1
fi

log_file=$1

# Install Cushaw2-GPU V2.1.8-r16
####################################
# By default "have_ssse3 = 1"
# Makefile modified with GPU_ARCH = sm_35
####################################

echo "Start installing Cushaw2-GPU V2.1.8-r16"
rm -Rf cushaw2-gpu-2.1.8-r16
rm -f cushaw2-gpu-2.1.8-r16.tar.gz

echo "Downloading cushaw2-gpu-2.1.8-r16.tar.gz ..."
wget http://downloads.sourceforge.net/project/cushaw2/CUSHAW2-GPU/cushaw2-gpu-2.1.8-r16.tar.gz >> $log_file.out 2>> $log_file.err

echo "Unpaking ..."
tar -xvzf cushaw2-gpu-2.1.8-r16.tar.gz >> $log_file.out 2>> $log_file.err

echo "Patching with custom settings ..."
cd cushaw2-gpu-2.1.8-r16
patch Makefile < ../patches/cushaw2-gpu/cushaw2-gpu.patch 

echo "Compiling ..."
make clean all >> ../$log_file.out 2>> ../$log_file.err

echo "Downloading cushaw2_index.tar.gz ..."
wget http://downloads.sourceforge.net/project/cushaw2/CUSHAW2%20Indexer/cushaw2_index.tar.gz >> ../$log_file.out 2>> ../$log_file.err

echo "Unpaking ..."
tar -xzvf cushaw2_index.tar.gz >> ../$log_file.out 2>> ../$log_file.err

echo "Compiling ..."
cd cushaw2_index
make clean all >> ../../$log_file.out 2>> ../../$log_file.err

echo "Cleaning ..."
cd ..
rm -f cushaw2_index.tar.gz
cd ..
rm -f cushaw2-gpu-2.1.8-r16.tar.gz
echo "Done"
echo ""
