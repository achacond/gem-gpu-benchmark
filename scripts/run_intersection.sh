#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="intersections"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing intersections: $fastaq_file"

	# Mappers CPU
	#launch_intersection GEM3-GPU gem.intersections.sh $fastaq_file
	#launch_intersection BWA bwa.mem.intersections.sh $fastaq_file
	#launch_intersection BOWTIE2 bowtie2.intersections.sh $fastaq_file
	#launch_intersection HPG hpg.intersections.sh $fastaq_file
	#launch_intersection SNAP snap.intersections.sh $fastaq_file

	# Mappers GPU
	#launch_intersection CUSHAW2 cushaw2.intersections.sh $fastaq_file
	#launch_intersection NVBOWTIE nvbowtie.intersections.sh $fastaq_file
	#launch_intersection SOAP3DP-GPU soap3dp-gpu.intersections.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing intersections: $fastaq_file"

	# Mappers CPU
	#launch_intersection GEM3-GPU gem.intersections.sh $fastaq_file
	#launch_intersection BWA bwa.mem.intersections.sh $fastaq_file
	#launch_intersection BOWTIE2 bowtie2.intersections.sh $fastaq_file
	#launch_intersection HPG hpg.intersections.sh $fastaq_file
	#launch_intersection SNAP snap.intersections.sh $fastaq_file

	# Mappers GPU
	#launch_intersection CUSHAW2 cushaw2.intersections.sh $fastaq_file
	#launch_intersection NVBOWTIE nvbowtie.intersections.sh $fastaq_file
	#launch_intersection SOAP3DP-GPU soap3dp-gpu.intersections.sh $fastaq_file
done

# Illumina l500 Dataset - Single End
##############################

Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500'

for fastaq_file in $Illumina_l500_dataset
do
	echo "Processing intersections: $fastaq_file"

	# Mappers CPU
	#launch_intersection GEM3-GPU gem.intersections.sh $fastaq_file
	#launch_intersection BWA bwa.mem.intersections.sh $fastaq_file
	#launch_intersection BOWTIE2 bowtie2.intersections.sh $fastaq_file
	#launch_intersection HPG hpg.intersections.sh $fastaq_file
	#launch_intersection SNAP snap.intersections.sh $fastaq_file

	# Mappers GPU
	#launch_intersection CUSHAW2 cushaw2.intersections.sh $fastaq_file
	#launch_intersection NVBOWTIE nvbowtie.intersections.sh $fastaq_file
	#launch_intersection SOAP3DP-GPU soap3dp-gpu.intersections.sh $fastaq_file
done

# Illumina l1000 Dataset - Single End
##############################

Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000'

for fastaq_file in $Illumina_l1000_dataset
do
	echo "Processing intersections: $fastaq_file"

	# Mappers CPU
	launch_intersection GEM3-GPU gem.intersections.sh $fastaq_file
	launch_intersection BWA bwa.mem.intersections.sh $fastaq_file
	launch_intersection BOWTIE2 bowtie2.intersections.sh $fastaq_file
	launch_intersection HPG hpg.intersections.sh $fastaq_file
	launch_intersection SNAP snap.intersections.sh $fastaq_file

	# Mappers GPU
	#launch_intersection CUSHAW2 cushaw2.intersections.sh $fastaq_file
	#launch_intersection NVBOWTIE nvbowtie.intersections.sh $fastaq_file
	#launch_intersection SOAP3DP-GPU soap3dp-gpu.intersections.sh $fastaq_file
done

#Returning to original path
cd $original_path



