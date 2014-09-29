#!/bin/bash

#SBATCH --job-name="GenIndexBowtie2-default"
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

logfile="../../logs/Gen-Index-Bowtie2.log"

### Info
echo "Bowtie2 V2.2.3 - Building index with human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_bowtie2_default

### Run command
time ../../software/mappers/bowtie2-2.2.3/bowtie2-build ../../data/references/hsapiens_v37.fa ../../data/references/hsapiens >> $logfile 2>&1

mv ../../data/references/hsapiens.* ../../data/indexes/HG_index_bowtie2_default >> $logfile 2>&1
