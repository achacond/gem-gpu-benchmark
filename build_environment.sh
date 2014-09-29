#!/bin/bash

#Changing working directory
original_path=`pwd`
scripts_path="scripts"
cd $scripts_path

echo "     ==>   Downloading references   <=="
./download_references.sh

echo "     ==>    Downloading datasets    <=="
./download_datasets.sh

echo "     ==>     Installing mappers     <=="
./install_mappers.sh

echo "     ==>      Installing tools      <=="
./install_tools.sh

echo "     ==>  Building indexes (slurm)  <=="
./build_indexes.sh

#Returning to original path
cd $original_path


