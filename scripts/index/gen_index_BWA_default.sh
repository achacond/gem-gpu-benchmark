#!/bin/bash

#SBATCH --job-name="GenIndexBWA-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.9.1
fi

logfile="../../logs/Gen-Index-BWA.log"

### Info
echo "BWA V0.7.10 - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_BWA_default

### Run command
time ../../software/mappers/bwa-0.7.10/bwa index ../../data/references/hsapiens_v37.fa >> $logfile 2>&1

mv ../../data/references/hsapiens_v37.fa.* ../../data/indexes/HG_index_BWA_default/ >> $logfile 2>&1
cp ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_BWA_default/ >> $logfile 2>&1
