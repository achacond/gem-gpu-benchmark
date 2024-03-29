#!/bin/bash

#SBATCH --job-name="G.GEM3-GPU-FR.S4"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/GEM.gindex.summary.log
#SBATCH --error=../../logs/GEM.gindex.summary.log

source ../common.sh
source ../node_profiles.sh

logfile="../../logs/GEM3-GPU.gindex.FR.S4.err"

### Info
echo "GEM3 GPU (Big indexes "profile") - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_GEM-GPU_profile_FR_S4_default >> $logfile 2>&1

### Run command
profile "../../software/mappers/gem-gpu-git/bin/gem-indexer -i ../../data/references/hsapiens_v37.fa -o ../../data/references/hsapiens_v37.FR.s4 >> $logfile 2>&1"

mv ../../data/references/hsapiens_v37.FR.s4* ../../data/indexes/HG_index_GEM-GPU_profile_FR_S4_default >> $logfile 2>&1
