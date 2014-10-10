#!/bin/bash

#SBATCH --job-name="soap3gpu-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --gres=gpu:2

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"


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


# Install Soap3-dp-GPU V2.3.r177
#####################################
# Makefile modified with: CUDAFLAG = -cuda -arch=sm_35 --ptxas-options=-v
#####################################

echo "Start installing Soap3-dp-GPU V2.3.r177"
rm -Rf soap3-dp-2.3.r177
rm -f soap3-dp-src.tgz

echo "Downloading soap3-dp-src.tgz ..."
wget http://downloads.sourceforge.net/project/soap3dp/r177-src/soap3-dp-src.tgz >> $log_file.out 2>> $log_file.err

echo "Unpaking ..."
tar -xvzf soap3-dp-src.tgz >> $log_file.out 2>> $log_file.err
mv release soap3-dp-2.3.r177

echo "Patching with custom settings ..."
cd soap3-dp-2.3.r177
patch Makefile < ../patches/soap3-pd/soap3-dp.patch >> ../$log_file.out 2>> ../$log_file.err
patch soap3-dp.ini < ../patches/soap3-pd/soap3-dp.ini.patch  >> ../$log_file.out 2>> ../$log_file.err

echo "Compiling ..."
make clean all >> ../$log_file.out 2>> ../$log_file.err

echo "Cleaning ..."
cd ..
rm -f soap3-dp-src.tgz
echo "Done"
echo ""


