#!/bin/bash

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.8.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.8.1
fi

log_file=$1

# Install BWA V0.7.10
##################################
echo "Start installing BWA V0.7.10"
rm -Rf bwa-0.7.10
rm -f bwa-0.7.10.tar.bz2

echo "Downloading bwa-0.7.10.tar.bz2 ..."
wget http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.10.tar.bz2 >> $log_file.out 2>> $log_file.err

echo "Unpaking ..."
tar -xjvf bwa-0.7.10.tar.bz2 >> $log_file.out 2>> $log_file.err

echo "Compiling ..."
cd bwa-0.7.10
make clean all >> ../$log_file.out 2>> ../$log_file.err

echo "Cleaning ..."
cd ..
rm -f bwa-0.7.10.tar.bz2
echo "Done"
echo ""
