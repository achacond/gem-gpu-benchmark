#!/bin/bash

source common.sh

#Changing working directory
original_path=`pwd`
dataset_path="../data/datasets/"
cd $dataset_path

# HiSeq Dataset
##############################

HiSeq_dataset='H.Sapiens.HiSeq.Sim.1M.sam 		https://googledrive.com/host/0Bw2Nno1-eC2IV182dzIwb21HdU0
			   H.Sapiens.HiSeq.Sim.1M.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2IbmVnQWh5dFFEY2M
			   H.Sapiens.HiSeq.Real.1M.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2ITzUtMHhVVmZGRWc'

echo "$HiSeq_dataset" | while read file_name url ; do
	check_and_download $file_name $url
done



# MiSeq Dataset
##############################

MiSeq_dataset='H.Sapiens.MiSeq.Real.1M.1.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2INnBzbVFOTDJHbWs
			   H.Sapiens.MiSeq.Real.1M.2.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2Ic2RjeWx6a3JtbFE
			   H.Sapiens.MiSeq.Sim.1M.1.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2IYXZXR3NoeWdIZ2s
			   H.Sapiens.MiSeq.Sim.1M.sam 		https://googledrive.com/host/0Bw2Nno1-eC2IMmtWbWVWM3FmUWc
			   H.Sapiens.MiSeq.Sim.1M.2.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2Id1ZzWGJCbXpNWnM'

echo "$MiSeq_dataset" | while read file_name url ; do
	check_and_download $file_name $url
done



# 454 Dataset
##############################

454_dataset='H.Sapiens.454.Sim.1M.sam 		https://googledrive.com/host/0Bw2Nno1-eC2IdTNnTVR1czM0REk
			 H.Sapiens.454.Sim.1M.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2IbUlFRHNqb3M2SXM
			 H.Sapiens.454.Real.1M.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2IMTFpVVFuSEJ1Y2M'

echo "$454_dataset" | while read file_name url ; do
	check_and_download $file_name $url
done



# PACBIO Dataset
##############################

PACBIO_dataset='H.Sapiens.PACBio.Real.1M.lt1Knt.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2IZW5uTVVZMTJ4VWc
			 	H.Sapiens.PACBio.Sim.1M.gt1Knt.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2ILURLV25USmIyY28
			 	H.Sapiens.PACBio.Sim.1M.lt1Knt.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2ILXhybW9pSVNKX2c
			 	H.Sapiens.PACBio.Real.1M.gt1Knt.fastq	https://googledrive.com/host/0Bw2Nno1-eC2IVXU1VVUwcG5kUXM'

echo "$PACBIO_dataset" | while read file_name url ; do
	check_and_download $file_name $url
done



# ION-TORRENT Dataset
##############################

ION_dataset='H.Sapiens.Ion.Real.1M.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2ITnBHZjNGYktzRVE
			 H.Sapiens.Ion.Sim.1M.fastq 	https://googledrive.com/host/0Bw2Nno1-eC2IUEYzTWw0YnoxQ2M
			 H.Sapiens.Ion.Sim.1M.sam		https://googledrive.com/host/0Bw2Nno1-eC2IelptQjFZOUtteEU'

echo "$ION_dataset" | while read file_name url ; do
	check_and_download $file_name $url
done

#Returning to original path
cd $original_path




