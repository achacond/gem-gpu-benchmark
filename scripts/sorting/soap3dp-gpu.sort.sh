#!/bin/bash

#SBATCH --job-name="SOAP3DP-GPU-SE"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se

#SBATCH --mem=75GB

#SBATCH --output=../../logs/SOAP3DP-GPU.sorting.summary.log 
#SBATCH --error=../../logs/SOAP3DP-GPU.sorting.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="SOAP3DP-GPU"

sorting_path="../../data/sorts/$TAG"
results_path="../../data/results/$TAG"

echo "> Benchmarks for SOAP3DP-GPU 2.3.r177: $IN"

mkdir -p $sorting_path


OUT="$TAG.$OUT_PREFIX.default.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

