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





