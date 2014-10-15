#!/bin/bash

#SBATCH --job-name="G.BWA-default"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/BWA.gindex.summary.log
#SBATCH --error=../../logs/BWA.gindex.summary.log

source ../node_profiles.sh

logfile="../../logs/BWA.gindex.err"

### Info
echo "BWA V0.7.10 - Indexing human genome v37 - default parameters" > $logfile

########
mkdir -p ../../data/indexes/HG_index_BWA_default >> $logfile 2>&1

### Run command
\time -v ../../software/mappers/bwa-0.7.10/bwa index ../../data/references/hsapiens_v37.fa >> $logfile 2>&1

mv ../../data/references/hsapiens_v37.fa.* ../../data/indexes/HG_index_BWA_default/ >> $logfile 2>&1
cp ../../data/references/hsapiens_v37.fa ../../data/indexes/HG_index_BWA_default/ >> $logfile 2>&1
