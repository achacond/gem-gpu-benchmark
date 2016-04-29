#!/bin/bash

#SBATCH --job-name="G.HPG-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/HPG.gindex.summary.log
#SBATCH --error=../../logs/HPG.gindex.summary.log

source ../common.sh
source ../node_profiles.sh

logfile="../../logs/HPG.gindex.err"

### Info
echo "HPG-aligner V2.0.0 - Building index with human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_hpg-aligner_default >> $logfile 2>&1

### Run command
profile "../../software/mappers/hpg-aligner-2.0.0/bin/hpg-aligner build-sa-index -g ../../data/references/hsapiens_v37.fa -i ../../data/indexes/HG_index_hpg-aligner_default/ >> $logfile 2>&1"
cp ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_hpg-aligner_default/hsapiens_v37.fa
