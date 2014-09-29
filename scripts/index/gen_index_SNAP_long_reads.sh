#!/bin/bash

#SBATCH --job-name="GenIndexSNAP-long-queries"
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

logfile="../../logs/Gen-Index-SNAP-long.log"

### Info
echo "SNAP 1.0beta.10 [USING SEEDS SIZE 22] - Building Human genome index for long queries (langer than 100 bases)" > $logfile

########
mkdir -p ../../data/indexes/HG_index_SNAP_long_reads

### Run command
time ../../software/mappers/snap-1.0beta.10-linux/snap index ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_SNAP_long_reads -s 22 >> $logfile 2>&1 
