#!/bin/bash

#SBATCH --job-name="nvBio-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --gres=gpu:2

#SBATCH --output=../../logs/NVBOWTIE.installation_mapping_tools.log
#SBATCH --error=../../logs/NVBOWTIE.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"NVBOWTIE.installation_mapping_tools.err


# Install nvBowtie (nvBio) V0.9.9.3
####################################

echo "Start installing nvBowtie (nvBio) V0.9.9.3"
echo "Start installing nvBowtie (nvBio) V0.9.9.3" > $logfile 2>&1

rm -Rf nvbio-0.9.9.3
rm -f master.zip

echo "Downloading v0.9.9.tar.gz ..."
wget https://github.com/NVlabs/nvbio/archive/master.zip  >> $logfile 2>&1

echo "Unpaking ..."
unzip master.zip  >> $logfile 2>&1
mv nvbio-master nvbio-0.9.9.3

echo "Compiling ..."
cd nvbio-0.9.9.3
mkdir -p release  >> ../$logfile 2>&1
cd release 
$cmake_bin ../  >> ../../$logfile 2>&1
make clean all >> ../../$logfile 2>&1

echo "Cleaning ..."
cd ../..
rm -f v0.9.9.3.tar.gz  >> $logfile 2>&1
echo "Done"
echo ""
