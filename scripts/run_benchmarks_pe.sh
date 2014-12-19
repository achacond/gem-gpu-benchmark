#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="benchmarks"
cd $scripts_path


# HiSeq Dataset - Paired End
##############################

#HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M'
#HiSeq_dataset='H.Sapiens.HiSeqPE.Real.10M'
HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M H.Sapiens.HiSeqPE.Real.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing: $fastaq_file"
	#launch_benchmark GEM3-GPU gem.mapPE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapPE.sh $fastaq_file
	launch_benchmark BOWTIE2 bowtie2.mapPE.sh $fastaq_file
	#launch_benchmark CUSHAW2 cushaw2.mapPE.sh $fastaq_file
	#launch_benchmark HPG hpg.mapPE.sh $fastaq_file
	#launch_benchmark NVBOWTIE nvbowtie.mapPE.sh $fastaq_file
	#launch_benchmark SNAP snap.mapPE.sh $fastaq_file
	#launch_benchmark SOAP3DP-GPU soap3dp-gpu.mapPE.sh $fastaq_file
done

# MiSeq Dataset - Paired End
##############################

#MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M'
#MiSeq_dataset='H.Sapiens.MiSeqPE.Real.10M'
MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M H.Sapiens.MiSeqPE.Real.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing: $fastaq_file"
	#launch_benchmark GEM3-GPU gem.mapPE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapPE.sh $fastaq_file
	launch_benchmark BOWTIE2 bowtie2.mapPE.sh $fastaq_file
	#launch_benchmark CUSHAW2 cushaw2.mapPE.sh $fastaq_file
	#launch_benchmark HPG hpg.mapPE.sh $fastaq_file
	#launch_benchmark NVBOWTIE nvbowtie.mapPE.sh $fastaq_file
	#launch_benchmark SNAP snap.mapPE.sh $fastaq_file
	#launch_benchmark SOAP3DP-GPU soap3dp-gpu.mapPE.sh $fastaq_file
done

#Returning to original path
cd $original_path



