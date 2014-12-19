#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="roc"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing ROC curves: $fastaq_file"

	# Mappers CPU
	launch_roc GEM3-GPU gem.roc.sh $fastaq_file
	launch_roc BWA bwa.mem.roc.sh $fastaq_file
	launch_roc BOWTIE2 bowtie2.roc.sh $fastaq_file
	launch_roc HPG hpg.roc.sh $fastaq_file
	launch_roc SNAP snap.roc.sh $fastaq_file

	# Mappers GPU
	#launch_roc CUSHAW2 cushaw2.roc.sh $fastaq_file
	#launch_roc NVBOWTIE nvbowtie.roc.sh $fastaq_file
	#launch_roc SOAP3DP-GPU soap3dp-gpu.roc.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing ROC curves: $fastaq_file"

	# Mappers CPU
	launch_roc GEM3-GPU gem.roc.sh $fastaq_file
	launch_roc BWA bwa.mem.roc.sh $fastaq_file
	launch_roc BOWTIE2 bowtie2.roc.sh $fastaq_file
	launch_roc HPG hpg.roc.sh $fastaq_file
	launch_roc SNAP snap.roc.sh $fastaq_file

	# Mappers GPU
	#launch_roc CUSHAW2 cushaw2.roc.sh $fastaq_file
	#launch_roc NVBOWTIE nvbowtie.roc.sh $fastaq_file
	#launch_roc SOAP3DP-GPU soap3dp-gpu.roc.sh $fastaq_file
done

# Illumina l500 Dataset - Single End
##############################

Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500'

for fastaq_file in $Illumina_l500_dataset
do
	echo "Processing ROC curves: $fastaq_file"

	# Mappers CPU
	launch_roc GEM3-GPU gem.roc.sh $fastaq_file
	launch_roc BWA bwa.mem.roc.sh $fastaq_file
	launch_roc BOWTIE2 bowtie2.roc.sh $fastaq_file
	launch_roc HPG hpg.roc.sh $fastaq_file
	launch_roc SNAP snap.roc.sh $fastaq_file

	# Mappers GPU
	#launch_roc CUSHAW2 cushaw2.roc.sh $fastaq_file
	#launch_roc NVBOWTIE nvbowtie.roc.sh $fastaq_file
	#launch_roc SOAP3DP-GPU soap3dp-gpu.roc.sh $fastaq_file
done

# Illumina l1000 Dataset - Single End
##############################

Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000'

for fastaq_file in $Illumina_l1000_dataset
do
	echo "Processing ROC curves: $fastaq_file"

	# Mappers CPU
	launch_roc GEM3-GPU gem.roc.sh $fastaq_file
	launch_roc BWA bwa.mem.roc.sh $fastaq_file
	launch_roc BOWTIE2 bowtie2.roc.sh $fastaq_file
	launch_roc HPG hpg.roc.sh $fastaq_file
	launch_roc SNAP snap.roc.sh $fastaq_file

	# Mappers GPU
	#launch_roc CUSHAW2 cushaw2.roc.sh $fastaq_file
	#launch_roc NVBOWTIE nvbowtie.roc.sh $fastaq_file
	#launch_roc SOAP3DP-GPU soap3dp-gpu.roc.sh $fastaq_file
done

#Returning to original path
cd $original_path



