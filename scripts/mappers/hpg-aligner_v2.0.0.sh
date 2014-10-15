#!/bin/bash

#SBATCH --job-name="HPG-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/HPG.installation_mapping_tools.log
#SBATCH --error=../../logs/HPG.installation_mapping_tools.log

source ../../scripts/node_profiles.sh

logfile="$1"HPG.installation_mapping_tools.err


# Install HPG-aligner V2.0.0 (Develop branch)
####################################
#  Dependences:
#  the GSL (GNU Scientific Library), http://www.gnu.org/software/gsl/
#  the Check library, http://check.sourceforge.net/
#  scons
#  
#  Dependences from samtools:
#  libncurses5-dev libncursesw5-dev
#  libcurl4-gnutls-dev
####################################

echo "Start installing HPG-aligner V2.0.0"
echo "Start installing HPG-aligner V2.0.0" > $logfile 2>&1
rm -Rf hpg-aligner-1.0.0

echo "Downloading hpg-aligner v2.0.0 ..."
git clone https://github.com/opencb/hpg-aligner.git >> $logfile 2>&1
mv hpg-aligner hpg-aligner-2.0.0
cd hpg-aligner-2.0.0/
git submodule update --init >> ../$logfile 2>&1

cd lib/hpg-libs
git checkout develop
cd ../..
git checkout develop

echo "Compiling ..."
scons -c >> ../$logfile 2>&1
scons >> ../$logfile 2>&1
cd ..
echo "Done"
