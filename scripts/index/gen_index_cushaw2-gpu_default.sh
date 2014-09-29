#!/bin/bash

#SBATCH --job-name="GenIndexCuShaw2-GPU-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

logfile="../../logs/Gen-Index-CuShaw2-GPU.log"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load CUDA/6.5.14
	module load GCC/4.9.1
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load cuda/6.5
	module load gcc/4.9.1
fi

### Info
echo "CUSHA2-GPU V2.1.8-r16  - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_cushaw2-gpu_default


### Run command
time ../../software/mappers/cushaw2-gpu-2.1.8-r16/cushaw2_index/cushaw2_index -a bwtsw ../../data/references/hsapiens_v37.fa >> $logfile 2>&1
mv ../../data/references/hsapiens_v37.fa.* ../../data/indexes/HG_index_cushaw2-gpu_default/  >> $logfile 2>&1
