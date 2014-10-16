#!/bin/bash

#Changing working directory
original_path=`pwd`
scripts_path="index"
cd $scripts_path

source ../node_profiles.sh

# Building indexes
####################

echo "Launching GEM-GPU indexing job ..."
#$binary_launcher gen_index_GEM-GPU_profile_default.sh

echo "Launching BWA indexing job ..."
#$binary_launcher gen_index_BWA_default.sh

echo "Launching Bowtie2 indexing job ..."
#$binary_launcher gen_index_bowtie2_default.sh

echo "Launching Cushaw2-GPU indexing job ..."
#$binary_launcher gen_index_cushaw2-gpu_default.sh

echo "Launching HPG-Aligner indexing job ..."
$binary_launcher gen_index_hpg-aligner_default.sh

echo "Launching nvBowtie indexing job ..."
#$binary_launcher gen_index_nvbowtie_default.sh

echo "Launching SNAP long-reads indexing job ..."
#$binary_launcher gen_index_SNAP_long_reads.sh

echo "Launching SNAP short-reads indexing job ..."
#$binary_launcher gen_index_SNAP_short_reads.sh

echo "Launching SOAP3DP-GPU indexing job ..."
#$binary_launcher gen_index_soap3-dp_default.sh

#Returning to original path
cd $original_path
