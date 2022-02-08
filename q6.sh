#!/bin/bash

# Output mime
echo "content-type: text/plain"

# Empty line to end header and start content
echo

# 1) Error checking:  no argument provided
if [[ -z "$1" ]]; then echo "You need to provide an actor"; exit; fi

# Return movie titles id of the actor/actress name provided as an argument

# 2) Create new tsv files with the data needed to increase search performance
# cut -d $'\t' -f 2,6 name.basics.tsv > name.minify.tsv
# grep -P 'tt.*movie\t' title.basics.tsv | grep -v tvEpisode | cut -d $'\t' -f 1,3 > title.minify.tsv

DIR=$(pwd)

# 3) Check if there's one actor or more
NUMBER_OF_ACTORS=$(grep -m 2 "$1" $DIR/name.minify.tsv | head -2 | wc -l)

if [[ $NUMBER_OF_ACTORS -ne 1 ]]
then
    	echo "There are ${NUMBER_OF_ACTORS} with the name ${1}, we expect only one."
else
# 4) Filter movie titles ids by actor, use those ids to filter the movie titles text 
    	echo "Actor ${1} is known for the following titles:"
	TITLES=$(grep -m 1 "$1" $DIR/name.minify.tsv | head -1 | grep -oP -m 4 'tt\d*' | head -4 | grep -m 4 -f - $DIR/title.minify.tsv | head -4 | cut -d $'\t' -f 2)
	echo "${TITLES}"
fi
