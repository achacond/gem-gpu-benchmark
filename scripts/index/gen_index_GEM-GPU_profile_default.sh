#!/bin/bash

#SBATCH --job-name="GenIndexGEM-GPU-profile"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

logfile="../../logs/Gen-Index-GEM-GPU-Profile-FR-S4.log"

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
echo "GEM GPU (Big indexes "profile") - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_GEM-GPU_profile_FR_S4_default

### Run command
time ../../software/mappers/gem-gpu/bin/gem-indexer -i ../../data/references/hsapiens_v37.fa -o ../../data/references/hsapiens_v37.FR.s4 --index-complement=yes -s 4 -v -t 32 >> $logfile 2>&1

mv ../../data/references/hsapiens_v37.FR.s4* ../../data/indexes/HG_index_GEM-GPU_profile_FR_S4_default >> $logfile 2>&1
