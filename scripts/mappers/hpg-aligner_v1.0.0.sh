#!/bin/bash

#SBATCH --job-name="HPG-alg-install"
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 
#SBATCH --exclusive
#SBATCH --gres=gpu:2

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.9.1
fi

log_file=$1


# Install HPG-aligner V1.0.0 (Stable branch)
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

echo "Start installing HPG-aligner V1.0.0"
rm -Rf hpg-aligner-1.0.0

echo "Downloading v0.9.9.3.tar.gz ..."
git clone https://github.com/opencb/hpg-aligner.git >> $log_file.out 2>> $log_file.err
mv hpg-aligner hpg-aligner-1.0.0
cd hpg-aligner-1.0.0/
git submodule update --init >> ../$log_file.out 2>> ../$log_file.err

echo "Compiling ..."
scons -c >> ../$log_file.out 2>> ../$log_file.err
scons >> ../$log_file.out 2>> ../$log_file.err
cd ..
echo "Done"
