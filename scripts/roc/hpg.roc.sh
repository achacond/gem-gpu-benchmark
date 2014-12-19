#!/bin/bash

#SBATCH --job-name="HPG-ROC"
#SBATCH --exclusive
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/HPG.roc.summary.log 
#SBATCH --error=../../logs/HPG.roc.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="HPG"

#Changing working directory
original_path=`pwd`
gt_path="../../software/tools/GEMTools.Dev.ROC/bin"
cd $gt_path

sorting_path="../../../../data/sorts/$TAG"
datasets_sorted_path="../../../../data/sorts/DATASET"
roc_path="../../../../data/roc/$TAG"

echo "> ROC Curves of $TAG 2.0.0: $IN"

mkdir -p $roc_path

OUT="$TAG.$OUT_PREFIX.fast.t12"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> ROC Curves of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --eq-th 0.20 --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted 2> $roc_path/$OUT.sam.roc
echo "Done"


OUT="$TAG.$OUT_PREFIX.default.t12"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> ROC Curves of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --eq-th 0.20 --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted 2> $roc_path/$OUT.sam.roc
echo "Done"


OUT="$TAG.$OUT_PREFIX.sensitive.t12"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> ROC Curves of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --eq-th 0.20 --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted 2> $roc_path/$OUT.sam.roc
echo "Done"



#Returning to original path
cd $original_path
