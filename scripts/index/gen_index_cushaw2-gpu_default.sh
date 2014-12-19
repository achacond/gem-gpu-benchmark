#!/bin/bash

#SBATCH --job-name="G.CUSHAW2-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/CUSHAW2.gindex.summary.log
#SBATCH --error=../../logs/CUSHAW2.gindex.summary.log

source ../common.sh
source ../node_profiles.sh

logfile="../../logs/CUSHAW2.gindex.err"

### Info
echo "CUSHA2-GPU V2.1.8-r16  - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_cushaw2-gpu_default >> $logfile 2>&1


### Run command
profile "../../software/mappers/cushaw2-gpu-2.1.8-r16/cushaw2_index/cushaw2_index -a bwtsw ../../data/references/hsapiens_v37.fa >> $logfile 2>&1"
mv ../../data/references/hsapiens_v37.fa.* ../../data/indexes/HG_index_cushaw2-gpu_default/  >> $logfile 2>&1
cp ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_cushaw2-gpu_default/hsapiens_v37.fa 
