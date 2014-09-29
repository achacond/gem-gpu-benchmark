#!/bin/bash

#SBATCH --job-name="snap-install"
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


# Install SNAP V1.0beta.10
#####################################

echo "Start installing SNAP V1.0beta.10"
rm -f snap-1.0beta.10-linux.tar.gz

echo "Downloading snap-1.0beta.10-linux.tar.gz ..."
wget http://snap.cs.berkeley.edu/downloads/snap-1.0beta.10-linux.tar.gz >> $log_file.out 2>> $log_file.err

echo "Unpaking ..."
tar -xzvf snap-1.0beta.10-linux.tar.gz >> $log_file.out 2>> $log_file.err

echo "Cleaning ..."
rm -f snap-1.0beta.10-linux.tar.gz
echo "Done"
echo ""
