#!/bin/bash

#############################################################################################
# This script is to concatenate all alignment outputs of SAM format into one file.          #
#############################################################################################

if [ "$#" -lt 1 ];
then
    echo "For single read alignment:"
    echo "     Usage: $0 [input query file]"
    echo "     For example: $0 query.fa"
    echo "."
    echo "For paired-end read alignment:"
    echo "     Usage: $0 [input query file 1]"
    echo "     For example: $0 query_1.fa"
    echo "."
    echo "The script will read the corresponding alignment files like [input query file].gout.1"
    echo "and combine them into an alignment result file."
    exit 1
fi

input_query=$1
		
if [ ! -f $input_query.gout.1 ];
then
	 echo "The corresponding file $input_query.gout.1 cannot be found"
else
	 #prefix_input_query=`echo $input_query | cut -d'.' --complement -f2-`
	 #mv $input_query.dpout.1 $prefix_input_query.dpout
	 cp $input_query.gout.1 $input_query
	 
	 for i in 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
	 do
		  if [ -f $input_query.gout.$i ];
		  then
				egrep "^@" -v $input_query.gout.$i >> $input_query
		  fi
	 done
		  if [ -f $input_query.dpout.1 ];
		  then
	 			egrep "^@" -v $input_query.dpout.1 >> $input_query
		  fi
	 rm -f $input_query.*
	 echo "------------------------------------------------------"
	 echo "Alignment file - $input_query has been created"
	 echo "------------------------------------------------------"
fi
