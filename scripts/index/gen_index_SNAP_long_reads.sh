#!/bin/bash

#SBATCH --job-name="G.SNAP-long-queries"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/SNAP.Gen-Index-Long.log
#SBATCH --error=../../logs/SNAP.Gen-Index-Long.log

source ../node_profiles.sh

logfile="../../logs/Gen-Index-SNAP-long.log"

### Info
echo "SNAP 1.0beta.50 [USING SEEDS SIZE 22] - Building Human genome index for long queries (langer than 100 bases)" > $logfile

########
mkdir -p ../../data/indexes/HG_index_SNAP_long_reads >> $logfile 2>&1

### Run command
time ../../software/mappers/snap-1.0beta.50-linux/snap index ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_SNAP_long_reads -s 22 >> $logfile 2>&1 
