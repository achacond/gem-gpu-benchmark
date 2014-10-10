#!/bin/bash

#SBATCH --job-name="Bowtie-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.9.1
fi

log_file=$1

# Install Bowtie2 V2.2.3
###################################
echo "Start installing Bowtie2 V2.2.3"
rm -Rf bowtie2-2.2.3
rm -f bowtie2-2.2.3-source.zip

echo "Downloading bowtie2-2.2.3-source.zip ..."
wget http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.3/bowtie2-2.2.3-source.zip >> $log_file.out 2>> $log_file.err

echo "Unpaking ..."
unzip bowtie2-2.2.3-source.zip >> $log_file.out 2>> $log_file.err

echo "Compiling ..."
cd bowtie2-2.2.3
make clean all >> ../$log_file.out 2>> ../$log_file.err

echo "Cleaning ..."
cd ..
rm -f bowtie2-2.2.3-source.zip
echo "Done"
echo ""
