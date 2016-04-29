#!/bin/bash

#SBATCH --job-name="CUSHAW2-SORT"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mem=75GB

#SBATCH --output=../../logs/CUSHAW2.sorting.summary.log 
#SBATCH --error=../../logs/CUSHAW2.sorting.summary.log 

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="CUSHAW2"

sorting_path="../../data/sorts/$TAG"
results_path="../../data/results/$TAG"

echo "> Benchmarks for CUSHAW2 GPU 2.1.8-r16: $IN"

mkdir -p $sorting_path

OUT="$TAG.$OUT_PREFIX.default.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.sensitive.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"
