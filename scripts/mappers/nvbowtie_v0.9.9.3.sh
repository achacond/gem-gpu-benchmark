#!/bin/bash

cmake_bin=cmake
if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load CUDA/6.5.14
	module load GCC/4.8.1
	cmake_bin=cmake
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load cuda/6.5
	module load gcc/4.8.1
	cmake_bin=cmake28
fi

log_file=$1


# Install nvBowtie (nvBio) V0.9.9.3
####################################

echo "Start installing nvBowtie (nvBio) V0.9.9.3"
rm -Rf nvbio-0.9.9.3
rm -f v0.9.9.3.tar.gz

echo "Downloading v0.9.9.3.tar.gz ..."
wget https://github.com/NVlabs/nvbio/archive/v0.9.9.3.tar.gz  >> $log_file.out 2>> $log_file.err

echo "Unpaking ..."
tar -xzvf v0.9.9.3.tar.gz  >> $log_file.out 2>> $log_file.err

echo "Compiling ..."
cd nvbio-0.9.9.3
mkdir release
cd release 
$cmake_bin ../  >> ../../$log_file.out 2>> ../../$log_file.err
make clean all >> ../../$log_file.out 2>> ../../$log_file.err

echo "Cleaning ..."
cd ../..
rm -f v0.9.9.3.tar.gz
echo "Done"
echo ""
