#!/bin/bash

#SBATCH --job-name="GEM3-GPU-STATS"
#SBATCH --exclusive
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/GEM.stats.summary.log 
#SBATCH --error=../../logs/GEM.stats.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="GEM3-GPU"

#Changing working directory
original_path=`pwd`
gt_path="../../software/tools/GEMTools.Dev/bin"
cd $gt_path

sorting_path="../../../../data/sorts/$TAG"
stats_path="../../../../data/stats/$TAG"

echo "> Benchmarks for $TAG (git): $IN"

mkdir -p $stats_path

OUT="$TAG.$OUT_PREFIX.fast.t32"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.t32"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.t32.K20"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.t32.K20.emu"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

#Returning to original path
cd $original_path
