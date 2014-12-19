#!/bin/bash

#SBATCH --job-name="G.SNAP-short-queries"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/SNAP.short.gindex.summary.log
#SBATCH --error=../../logs/SNAP.short.gindex.summary.log

source ../common.sh
source ../node_profiles.sh

logfile="../../logs/SNAP.short.gindex.err"

### Info
echo "SNAP 1.0beta.50 [USING SEEDS SIZE 20] - Building human genome index for short queries (100 bases)" > $logfile

mkdir -p ../../data/indexes/HG_index_SNAP_short_reads >> $logfile 2>&1

### Run command
profile "../../software/mappers/snap-1.0beta.50-linux/snap index ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_SNAP_short_reads -s 20 >> $logfile 2>&1 "
