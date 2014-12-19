#!/bin/bash

function progress_bar()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%c' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}

function check_and_download()
{
	echo -n "Checking $1 ..."
	md5sum --status -c checksums/$1.md5 2> /dev/null
  
	if [[ $? -eq 0 ]]; then
		echo " OK"
	else
		echo " not found"
		echo "Downloading $1 ..."
		wget --progress=bar:force $2 -O $1 2>&1 | progress_bar
	fi
}

function launch_benchmark()
{
    source ../node_profiles.sh

    prefix_file=$1
    mapper_script=$2
    fastaq_file=$3
    path_logs=../../logs

    if [ $binary_launcher == "bash" ]
    then
        $binary_launcher $mapper_script $fastaq_file > $path_logs/$prefix_file.$fastaq_file.summary.log  2>&1
    else
        $binary_launcher --output=$path_logs/$prefix_file.$fastaq_file.summary.log --error=$path_logs/$prefix_file.$fastaq_file.summary.log $mapper_script $fastaq_file
    fi
}

function launch_sort()
{
    source ../node_profiles.sh

    prefix_file=$1
    sort_script=$2
    fastaq_file=$3
    path_logs="../../logs/$prefix_file"

    mkdir -p $path_logs

    if [ $binary_launcher == "bash" ]
    then
        $binary_launcher $sort_script $fastaq_file > $path_logs/$prefix_file.$fastaq_file.summary.log  2>&1
    else
        $binary_launcher --output=$path_logs/$prefix_file.$fastaq_file.sorting.log --error=$path_logs/$prefix_file.$fastaq_file.sorting.log $sort_script $fastaq_file
    fi
}

function launch_stats()
{
    source ../node_profiles.sh

    prefix_file=$1
    sort_script=$2
    fastaq_file=$3
    path_logs="../../logs/$prefix_file"

    mkdir -p $path_logs

    if [ $binary_launcher == "bash" ]
    then
        $binary_launcher $sort_script $fastaq_file > $path_logs/$prefix_file.$fastaq_file.summary.log  2>&1
    else
        $binary_launcher --output=$path_logs/$prefix_file.$fastaq_file.stats.log --error=$path_logs/$prefix_file.$fastaq_file.stats.log $sort_script $fastaq_file
    fi
}

function launch_intersection()
{
    source ../node_profiles.sh

    prefix_file=$1
    intersection_script=$2
    fastaq_file=$3
    path_logs="../../logs/$prefix_file"

    mkdir -p $path_logs

    if [ $binary_launcher == "bash" ]
    then
        $binary_launcher $sort_script $fastaq_file > $path_logs/$prefix_file.$fastaq_file.summary.log  2>&1
    else
        $binary_launcher --output=$path_logs/$prefix_file.$fastaq_file.intersection.log --error=$path_logs/$prefix_file.$fastaq_file.intersection.log $intersection_script $fastaq_file
    fi
}

function launch_roc()
{
    source ../node_profiles.sh

    prefix_file=$1
    roc_script=$2
    fastaq_file=$3
    path_logs="../../logs/$prefix_file"

    mkdir -p $path_logs

    if [ $binary_launcher == "bash" ]
    then
        $binary_launcher $sort_script $fastaq_file > $path_logs/$prefix_file.$fastaq_file.summary.log  2>&1
    else
        $binary_launcher --output=$path_logs/$prefix_file.$fastaq_file.roc.log --error=$path_logs/$prefix_file.$fastaq_file.roc.log $roc_script $fastaq_file
    fi
}

function profile()
{
	\time -v /bin/sh -c "$*"
}




