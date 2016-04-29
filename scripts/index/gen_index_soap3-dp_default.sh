#!/bin/bash

#SBATCH --job-name="G.SOAP3DP-GPU-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/SOAP3DP-GPU.gindex.summary.log
#SBATCH --error=../../logs/SOAP3DP-GPU.gindex.summary.log

source ../common.sh
source ../node_profiles.sh

logfile="../../logs/SOAP3DP-GPU.gindex.err"

### Info
echo "SOAP3DP-GPU V2.3.r177 - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_soap3-dp_default >> $logfile 2>&1

### Run command
profile "../../software/mappers/soap3-dp-2.3.r177/soap3-dp-builder ../../data/references/hsapiens_v37.fa >> $logfile 2>&1"  
profile "../../software/mappers/soap3-dp-2.3.r177/BGS-Build ../../data/references/hsapiens_v37.fa.index >> $logfile 2>&1"

mv ../../data/references/hsapiens_v37.fa.index.* ../../data/indexes/HG_index_soap3-dp_default/ >> $logfile 2>&1
