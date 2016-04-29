#!/bin/bash

#SBATCH --job-name="GEM3-GPU-SE-MAPSET"
#SBATCH --exclusive
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/GEM.mapset.se.summary.log 
#SBATCH --error=../../logs/GEM.mapset.se.summary.log

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
datasets_sorted_path="../../../../data/sorts/DATASET"
mapsets_data_path="../../../../data/mapsets/$TAG/data"
mapsets_info_path="../../../../data/mapsets/$TAG/info"

echo "> Benchmarks for $TAG (git): $IN"

mkdir -p $mapsets_data_path
mkdir -p $mapsets_info_path

OUT="$TAG.$OUT_PREFIX.fast.t32"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Mapsets of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 -o $mapsets_data_path/$OUT.sam 2> $mapsets_info_path/$OUT.sam.sensitivity
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.t32"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Mapsets of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 -o $mapsets_data_path/$OUT.sam 2> $mapsets_info_path/$OUT.sam.sensitivity
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.t32.K20"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Mapsets of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 -o $mapsets_data_path/$OUT.sam 2> $mapsets_info_path/$OUT.sam.sensitivity
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.t32.K20.emu"
SOURCE="DATASET.$OUT_PREFIX"
echo -n "==> Mapsets of $SOURCE with $OUT ..."
profile ./gt.mapset -C specificity-profile --i1 $datasets_sorted_path/$SOURCE.sam.sorted --i2 $sorting_path/$OUT.sam.sorted --eq-th 0.20 -o $mapsets_data_path/$OUT.sam 2> $mapsets_info_path/$OUT.sam.sensitivity
echo "Done"

#Returning to original path
cd $original_path
