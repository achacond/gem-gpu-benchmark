#!/bin/bash

source node_profiles.sh

#Changing working directory
original_path=`pwd`
mappers_path="../software/mappers/"
cd $mappers_path

scripts_path="../../scripts"
log_file="../../logs/"

echo "Path for log files:"
echo "     $log_file"
echo ""

rm -f "$log_file"installation_mapping_tools.log

#$binary_launcher $scripts_path/mappers/gem-gpu_vgit.sh $log_file
#$binary_launcher $scripts_path/mappers/bwa_v0.7.10.sh $log_file
#$binary_launcher $scripts_path/mappers/bowtie2_v2.2.3.sh $log_file
#$binary_launcher $scripts_path/mappers/cushaw2gpu_v2.1.8-r16.sh $log_file
$binary_launcher $scripts_path/mappers/nvbowtie_v0.9.9.3.sh $log_file
#$binary_launcher $scripts_path/mappers/hpg-aligner_v2.0.0.sh $log_file
#$binary_launcher $scripts_path/mappers/soap3-dp-gpu_v2.3.r177.sh $log_file
#$binary_launcher $scripts_path/mappers/snap_v1.0.beta10.sh $log_file

#Returning to original path
cd $original_path



