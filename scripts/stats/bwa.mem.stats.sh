#!/bin/bash

#SBATCH --job-name="BWA-STATS"
#SBATCH --exclusive
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se

#SBATCH --output=../../logs/BWA.stats.summary.log 
#SBATCH --error=../../logs/BWA.stats.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="BWA"

#Changing working directory
original_path=`pwd`
gt_path="../../software/tools/GEMTools.Dev/bin"
cd $gt_path

sorting_path="../../../../data/sorts/$TAG"
stats_path="../../../../data/stats/$TAG"

echo "> Benchmarks for BWA 0.7.10: $IN"

mkdir -p $stats_path

OUT="$TAG.$OUT_PREFIX.default.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c500.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c1000.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c16000.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c20000.k16.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"


#Returning to original path
cd $original_path
