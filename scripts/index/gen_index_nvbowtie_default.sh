#!/bin/bash

#SBATCH --job-name="GenIndexNvBowtie-default"
#SBATCH --exclusive
#SBATCH -w huberman
#SBATCH --gres=gpu:2

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load CUDA/6.5.14
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load cuda/6.5
	module load gcc/4.9.1
fi

logfile="../../logs/Gen-Index-NvBowtie.log"

### Info
echo "NVIDIA Bowtie 0.9.9.3- Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_NvBowtie_default

### Run command
time ../../software/mappers/nvbio-0.9.9.3/release/nvBWT/nvBWT ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_NvBowtie_default/ --device 0 >> $logfile 2>&1
