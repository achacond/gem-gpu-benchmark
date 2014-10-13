#!/bin/bash

#SBATCH --job-name="G.NvBowtie-default"
#SBATCH --exclusive
#SBATCH -w huberman
#SBATCH --gres=gpu:2

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/NVBOWTIE.Gen-Index.log
#SBATCH --error=../../logs/NVBOWTIE.Gen-Index.log

source ../node_profiles.sh

logfile="../../logs/Gen-Index-NvBowtie.log"

### Info
echo "NVIDIA Bowtie 0.9.9.3- Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_NvBowtie_default >> $logfile 2>&1

### Run command
time ../../software/mappers/nvbio-0.9.9.3/release/nvBWT/nvBWT ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_NvBowtie_default/ --device 0 >> $logfile 2>&1
