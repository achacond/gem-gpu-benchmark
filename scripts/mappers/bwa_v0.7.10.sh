#!/bin/bash

#SBATCH --job-name="BWA-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/BWA.installation_mapping_tools.log
#SBATCH --error=../../logs/BWA.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"BWA.installation_mapping_tools.err

# Install BWA V0.7.10
##################################
echo "Start installing BWA V0.7.10"
echo "Start installing BWA V0.7.10" > $logfile 2>&1
rm -Rf bwa-0.7.10
rm -f bwa-0.7.10.tar.bz2

echo "Downloading bwa-0.7.10.tar.bz2 ..."
wget http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.10.tar.bz2 >> $logfile 2>&1

echo "Unpaking ..."
tar -xjvf bwa-0.7.10.tar.bz2 >> $logfile 2>&1

echo "Compiling ..."
cd bwa-0.7.10
make clean all >> ../$logfile 2>&1

echo "Cleaning ..."
cd ..
rm -f bwa-0.7.10.tar.bz2 >> $logfile 2>&1
echo "Done"
echo ""
