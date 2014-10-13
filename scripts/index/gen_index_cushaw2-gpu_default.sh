#!/bin/bash

#SBATCH --job-name="G.CuShaw2-GPU-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/CUSHAW2-GPU.Gen-Index.log
#SBATCH --error=../../logs/CUSHAW2-GPU.Gen-Index.log

source ../node_profiles.sh

logfile="../../logs/Gen-Index-CuShaw2-GPU.log"

### Info
echo "CUSHA2-GPU V2.1.8-r16  - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_cushaw2-gpu_default >> $logfile 2>&1


### Run command
time ../../software/mappers/cushaw2-gpu-2.1.8-r16/cushaw2_index/cushaw2_index -a bwtsw ../../data/references/hsapiens_v37.fa >> $logfile 2>&1
mv ../../data/references/hsapiens_v37.fa.* ../../data/indexes/HG_index_cushaw2-gpu_default/  >> $logfile 2>&1
