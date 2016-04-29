#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="stats"
cd $scripts_path


# HiSeq Dataset - Paired End
##############################

HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M'
#HiSeq_dataset='H.Sapiens.HiSeqPE.Real.10M'
#HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M H.Sapiens.HiSeqPE.Real.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing stats of: $fastaq_file"

	# Mappers CPU
	launch_stats GEM3-GPU gem.stats.sh $fastaq_file
	#launch_stats BWA bwa.mem.stats.sh $fastaq_file
	#launch_stats BOWTIE2 bowtie2.stats.sh $fastaq_file
	#launch_stats HPG hpg.stats.sh $fastaq_file
	#launch_stats SNAP snap.stats.sh $fastaq_file

	# Mappers GPU
	#launch_stats CUSHAW2 cushaw2.stats.sh $fastaq_file
	#launch_stats NVBOWTIE nvbowtie.stats.sh $fastaq_file
	#launch_stats SOAP3DP-GPU soap3dp-gpu.stats.sh $fastaq_file
done

# MiSeq Dataset - Paired End
##############################

MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M'
#MiSeq_dataset='H.Sapiens.MiSeqPE.Real.10M'
#MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M H.Sapiens.MiSeqPE.Real.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing stats of: $fastaq_file"

	# Mappers CPU
	launch_stats GEM3-GPU gem.stats.sh $fastaq_file
	#launch_stats BWA bwa.mem.stats.sh $fastaq_file
	#launch_stats BOWTIE2 bowtie2.stats.sh $fastaq_file
	#launch_stats HPG hpg.stats.sh $fastaq_file
	#launch_stats SNAP snap.stats.sh $fastaq_file

	# Mappers GPU
	#launch_stats CUSHAW2 cushaw2.stats.sh $fastaq_file
	#launch_stats NVBOWTIE nvbowtie.stats.sh $fastaq_file
	#launch_stats SOAP3DP-GPU soap3dp-gpu.stats.sh $fastaq_file
done

