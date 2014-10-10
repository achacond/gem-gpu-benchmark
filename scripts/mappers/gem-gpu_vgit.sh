#!/bin/bash

#SBATCH --job-name="GEM3GPU-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 


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


# Install gem-gpu (git repository)
#####################################
# Makefile modified with: CUDAFLAG = -cuda -arch=sm_35 --ptxas-options=-v
#####################################

echo "Start installing gem-gpu from git repository"
rm -Rf gem-gpu

echo "Downloading gem-gpu ..."
git clone git@github.com:achacond/gem-gpu.git >> $log_file.out 2>> $log_file.err

echo "Compiling ..."
cd gem-gpu
./configure >> ../$log_file.out 2>> ../$log_file.err
make clean all >> ../$log_file.out 2>> ../$log_file.err

cd ..
echo "Done"
echo ""
