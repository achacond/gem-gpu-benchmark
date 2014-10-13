#!/bin/bash

#SBATCH --job-name="Bowtie-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/BOWTIE2.installation_mapping_tools.log
#SBATCH --error=../../logs/BOWTIE2.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"BOWTIE2.installation_mapping_tools.err

# Install Bowtie2 V2.2.3
###################################
echo "Start installing Bowtie2 V2.2.3" 
echo "Start installing Bowtie2 V2.2.3" > $logfile 2>&1

rm -Rf bowtie2-2.2.3
rm -f bowtie2-2.2.3-source.zip

echo "Downloading bowtie2-2.2.3-source.zip ..."
wget http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.3/bowtie2-2.2.3-source.zip >> $logfile 2>&1

echo "Unpaking ..."
unzip bowtie2-2.2.3-source.zip >> $logfile 2>&1

echo "Compiling ..."
cd bowtie2-2.2.3
make clean all >> ../$logfile 2>&1

echo "Cleaning ..."
cd ..
rm -f bowtie2-2.2.3-source.zip >> $logfile 2>&1
echo "Done"
echo ""
