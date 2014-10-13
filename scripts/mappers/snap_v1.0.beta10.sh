#!/bin/bash

#SBATCH --job-name="snap-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/SNAP.installation_mapping_tools.log
#SBATCH --error=../../logs/SNAP.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"SNAP.installation_mapping_tools.err


# Install SNAP V1.0beta.50
#####################################

echo "Start installing SNAP V1.0beta.50"
echo "Start installing SNAP V1.0beta.50" > $logfile 2>&1

rm -f dev.zip >> $logfile 2>&1
#rm -f snap-1.0beta.10-linux.tar.gz >> $logfile 2>&1

echo "Downloading snap-1.0beta.50.zip ..."
wget https://github.com/amplab/snap/archive/dev.zip >> $logfile 2>&1
#wget http://snap.cs.berkeley.edu/downloads/snap-1.0beta.10-linux.tar.gz >> $logfile 2>&1

echo "Unpaking ..."
unzip dev.zip >> $logfile 2>&1
mv snap-dev snap-1.0beta.50-linux
# snap-1.0beta.10-linux.tar.gz >> $logfile 2>&1

echo "Installing ..."
cd snap-1.0beta.50-linux
make clean >> ../$logfile 2>&1
make >> ../$logfile 2>&1

echo "Cleaning ..."
cd ..
rm -f dev.zip >> $logfile 2>&1
echo "Done"
echo ""
