#!/bin/bash

#SBATCH --job-name="GenIndexHPG-aligner-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

logfile="../../logs/Gen-Index-HPG-aligner.log"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load CUDA/6.5.14
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load cuda/6.5
	module load gcc/4.9.1
fi

### Info
echo "HPG-aligner V1.0.0 - Building index with human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_hpg-aligner_default

### Run command
time ../../software/mappers/hpg-aligner-1.0.0/bin/hpg-aligner build-sa-index -g ../../data/references/hsapiens_v37.fa -i ../../data/indexes/HG_index_hpg-aligner_default/ >> $logfile 2>&1
