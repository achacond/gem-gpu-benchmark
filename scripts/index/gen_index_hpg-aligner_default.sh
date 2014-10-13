#!/bin/bash

#SBATCH --job-name="G.HPG-aligner-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/HPG.Gen-Index.log
#SBATCH --error=../../logs/HPG.Gen-Index.log

source ../node_profiles.sh

logfile="../../logs/Gen-Index-HPG-aligner.log"

### Info
echo "HPG-aligner V1.0.0 - Building index with human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_hpg-aligner_default >> $logfile 2>&1

### Run command
time ../../software/mappers/hpg-aligner-1.0.0/bin/hpg-aligner build-sa-index -g ../../data/references/hsapiens_v37.fa -i ../../data/indexes/HG_index_hpg-aligner_default/ >> $logfile 2>&1
