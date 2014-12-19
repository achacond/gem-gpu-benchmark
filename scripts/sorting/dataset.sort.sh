#!/bin/bash

#SBATCH --job-name="DATASET-SORT"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mem=75GB

#SBATCH --output=../../logs/DATASET.sorting.summary.log 
#SBATCH --error=../../logs/DATASET.sorting.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="DATASET"

sorting_path="../../data/sorts/$TAG"
datasets_path="../../data/datasets"

echo "> Sorting for $TAG : $IN"

mkdir -p $sorting_path

OUT="$TAG.$OUT_PREFIX"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $datasets_path/$IN.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"
