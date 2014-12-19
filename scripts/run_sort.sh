#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="sorting"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M'
#HiSeq_dataset='H.Sapiens.HiSeqSE.Real.10M'
#HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M H.Sapiens.HiSeqSE.Real.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Sorting: $fastaq_file"

	# Original SAM output
	#launch_sort DATASET dataset.sort.sh $fastaq_file

	# Mappers CPU
	#launch_sort GEM3-GPU gem.sort.sh $fastaq_file
	#launch_sort BWA bwa.mem.sort.sh $fastaq_file
	#launch_sort BOWTIE2 bowtie2.sort.sh $fastaq_file
	#launch_sort HPG hpg.sort.sh $fastaq_file
	#launch_sort SNAP snap.sort.sh $fastaq_file

	# Mappers GPU
	#launch_sort CUSHAW2 cushaw2.sort.sh $fastaq_file
	#launch_sort NVBOWTIE nvbowtie.sort.sh $fastaq_file
	#launch_sort SOAP3DP-GPU soap3dp-gpu.sort.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M'
#MiSeq_dataset='H.Sapiens.MiSeqSE.Real.10M'
#MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M H.Sapiens.MiSeqSE.Real.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Sorting: $fastaq_file"

	# Original SAM output
	#launch_sort DATASET dataset.sort.sh $fastaq_file

	# Mappers CPU
	#launch_sort GEM3-GPU gem.sort.sh $fastaq_file
	#launch_sort BWA bwa.mem.sort.sh $fastaq_file
	#launch_sort BOWTIE2 bowtie2.sort.sh $fastaq_file
	#launch_sort HPG hpg.sort.sh $fastaq_file
	#launch_sort SNAP snap.sort.sh $fastaq_file

	# Mappers GPU
	#launch_sort CUSHAW2 cushaw2.sort.sh $fastaq_file
	#launch_sort NVBOWTIE nvbowtie.sort.sh $fastaq_file
	#launch_sort SOAP3DP-GPU soap3dp-gpu.sort.sh $fastaq_file
done

# Illumina l500 Dataset - Single End
##############################

Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500'
#Illumina_l500_dataset='H.Sapiens.IonTorrentSE.Real.10M'
#Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500 H.Sapiens.IonTorrentSE.Real.10M'

for fastaq_file in $Illumina_l500_dataset
do
	echo "Sorting: $fastaq_file"

	# Original SAM output
	#launch_sort DATASET dataset.sort.sh $fastaq_file

	# Mappers CPU
	#launch_sort GEM3-GPU gem.sort.sh $fastaq_file
	#launch_sort BWA bwa.mem.sort.sh $fastaq_file
	#launch_sort BOWTIE2 bowtie2.sort.sh $fastaq_file
	#launch_sort HPG hpg.sort.sh $fastaq_file
	#launch_sort SNAP snap.sort.sh $fastaq_file

	# Mappers GPU
	#launch_sort CUSHAW2 cushaw2.sort.sh $fastaq_file
	#launch_sort NVBOWTIE nvbowtie.sort.sh $fastaq_file
	#launch_sort SOAP3DP-GPU soap3dp-gpu.sort.sh $fastaq_file
done

# Illumina l1000 Dataset - Single End
##############################

Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000'
#Illumina_l1000_dataset='H.Sapiens.MoleculoSE.Real.1M'
#Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000 H.Sapiens.MoleculoSE.Real.1M'

for fastaq_file in $Illumina_l1000_dataset
do
	echo "Sorting: $fastaq_file"

	# Original SAM output
	launch_sort DATASET dataset.sort.sh $fastaq_file

	# Mappers CPU
	#launch_sort GEM3-GPU gem.sort.sh $fastaq_file
	#launch_sort BWA bwa.mem.sort.sh $fastaq_file
	#launch_sort BOWTIE2 bowtie2.sort.sh $fastaq_file
	#launch_sort HPG hpg.sort.sh $fastaq_file
	#launch_sort SNAP snap.sort.sh $fastaq_file

	# Mappers GPU
	#launch_sort CUSHAW2 cushaw2.sort.sh $fastaq_file
	#launch_sort NVBOWTIE nvbowtie.sort.sh $fastaq_file
	#launch_sort SOAP3DP-GPU soap3dp-gpu.sort.sh $fastaq_file
done

#Returning to original path
cd $original_path



