#!/bin/bash

#SBATCH --job-name="BOWTIE-INTERSECTION"
#SBATCH --exclusive
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se

#SBATCH --output=../../logs/BOWTIE2.intersection.summary.log 
#SBATCH --error=../../logs/BOWTIE2.intersection.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="BOWTIE2"

#Changing working directory
original_path=`pwd`
gt_path="../../software/tools/GEMTools.Dev/bin"
cd $gt_path

sorting_path="../../../../data/sorts/$TAG"
datasets_sorted_path="../../../../data/sorts/DATASET"
intersection_path="../../../../data/intersections/$TAG"

echo "> Benchmarks for BOWTIE2 2.2.3: $IN"

mkdir -p $intersection_path

OUT="$TAG.$OUT_PREFIX.very.fast.t12"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Intersection of $SOURCE with $OUT ..."
profile ./gt.mapset -C intersection --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 | awk '{if ($4 != 0) print}' > $intersection_path/$OUT.sam.intersected
echo -e "\tSpecificity: `wc -l $intersection_path/$OUT.sam.intersected`"
echo "Done"


OUT="$TAG.$OUT_PREFIX.default.t12"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Intersection of $SOURCE with $OUT ..."
profile ./gt.mapset -C intersection --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 | awk '{if ($4 != 0) print}' > $intersection_path/$OUT.sam.intersected
echo -e "\tSpecificity: `wc -l $intersection_path/$OUT.sam.intersected`"
echo "Done"


OUT="$TAG.$OUT_PREFIX.very.sensitive.t12"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Intersection of $SOURCE with $OUT ..."
profile ./gt.mapset -C intersection --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 | awk '{if ($4 != 0) print}' > $intersection_path/$OUT.sam.intersected
echo -e "\tSpecificity: `wc -l $intersection_path/$OUT.sam.intersected`"
echo "Done"

#Returning to original path
cd $original_path
