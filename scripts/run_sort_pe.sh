#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="sorting"
cd $scripts_path


# HiSeq Dataset - Paired End
##############################

HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M'
#HiSeq_dataset='H.Sapiens.HiSeqPE.Real.10M'
#HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M H.Sapiens.HiSeqPE.Real.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Sorting: $fastaq_file"

	# Original SAM output
	#launch_sort DATASET dataset.sort.sh $fastaq_file

	# Mappers CPU
	launch_sort GEM3-GPU gem.sort.sh $fastaq_file
	#launch_sort BWA bwa.mem.sort.sh $fastaq_file
	#launch_sort BOWTIE2 bowtie2.sort.sh $fastaq_file
	#launch_sort HPG hpg.sort.sh $fastaq_file
	#launch_sort SNAP snap.sort.sh $fastaq_file

	# Mappers GPU
	#launch_sort CUSHAW2 cushaw2.sort.sh $fastaq_file
	#launch_sort NVBOWTIE nvbowtie.sort.sh $fastaq_file
	#launch_sort SOAP3DP-GPU soap3dp-gpu.sort.sh $fastaq_file
done

# MiSeq Dataset - Paired End
##############################

MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M'
#MiSeq_dataset='H.Sapiens.MiSeqPE.Real.10M'
#MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M H.Sapiens.MiSeqPE.Real.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Sorting: $fastaq_file"

	# Original SAM output
	#launch_sort DATASET dataset.sort.sh $fastaq_file

	# Mappers CPU
	launch_sort GEM3-GPU gem.sort.sh $fastaq_file
	#launch_sort BWA bwa.mem.sort.sh $fastaq_file
	#launch_sort BOWTIE2 bowtie2.sort.sh $fastaq_file
	#launch_sort HPG hpg.sort.sh $fastaq_file
	#launch_sort SNAP snap.sort.sh $fastaq_file

	# Mappers GPU
	#launch_sort CUSHAW2 cushaw2.sort.sh $fastaq_file
	#launch_sort NVBOWTIE nvbowtie.sort.sh $fastaq_file
	#launch_sort SOAP3DP-GPU soap3dp-gpu.sort.sh $fastaq_file
done

