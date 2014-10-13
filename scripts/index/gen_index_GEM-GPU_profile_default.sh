#!/bin/bash

#SBATCH --job-name="G.GEM-GPU-profile"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/GEM.Gen-Index.log
#SBATCH --error=../../logs/GEM.Gen-Index.log

source ../node_profiles.sh

logfile="../../logs/Gen-Index-GEM-GPU-Profile-FR-S4.log"

### Info
echo "GEM GPU (Big indexes "profile") - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_GEM-GPU_profile_FR_S4_default >> $logfile 2>&1

### Run command
time ../../software/mappers/gem-gpu/bin/gem-indexer -i ../../data/references/hsapiens_v37.fa -o ../../data/references/hsapiens_v37.FR.s4 --index-complement=yes -s 4 -v -t 32 >> $logfile 2>&1

mv ../../data/references/hsapiens_v37.FR.s4* ../../data/indexes/HG_index_GEM-GPU_profile_FR_S4_default >> $logfile 2>&1
