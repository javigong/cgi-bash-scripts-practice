#!/bin/bash

# output mime
echo "content-type: text/html"

# empty line to end header and start content
echo

# 1) Error checking:  no argument provided
if [[ -z "$1" ]]; then echo "<h2>You need to provide an actor</h2>"; exit; fi

# Return movie titles id of the actor/actress name provided as an argument

# 2) Create new tsv files with the data needed to increase search performance
# cut -d $'\t' -f 2,6 name.basics.tsv > name.minify.tsv
# grep -P 'tt.*movie\t' title.basics.tsv | grep -v tvEpisode | cut -d $'\t' -f 1,3 > title.minify.tsv
# cut -d $'\t' -f 1,2 name.basics.tsv > actorid.minify.tsv 

DIR=$(pwd)

# 3) Check if there's one actor or more
NUMBER_OF_ACTORS=$(grep -m 2 "$1" $DIR/name.minify.tsv | head -2 | wc -l)

if [[ $NUMBER_OF_ACTORS -ne 1 ]]
then
    	echo "<h2>There are ${NUMBER_OF_ACTORS} with the name ${1}, we expect only one.</h2>"
else
	# filter by actor name, get titles id, build the patterns to search only movies, and use those patterns to find the movie titles
	# add actor's $IMAGE from https://www.imdb.com/name/$ACTOR_ID by filtering image id "name-poster", and selecting its source
	ACTOR_ID=$(grep "$1" $DIR/actorid.minify.tsv | grep -oP 'nm\d*')
	IMAGE=$(curl -s https://www.imdb.com/name/$ACTOR_ID/ | grep name-poster -A 5 | grep -E -o 'https.*jpg')
	
	echo "<div style='margin:auto;max-width=80%;padding=2rem;text-align: center;'>"
	echo "<img src="${IMAGE}" style='width: 300px;height:300px;object-fit:cover;border-radius:10rem;text-align: center;' />"
	echo "<h1 style='color:indigo'>Actor ${1} is known for the following titles:</h1>"
	# 4) Filter movie titles ids by actor, use those ids to filter the movie titles text
	TITLES=$(grep -m 1 "$1" $DIR/name.minify.tsv | head -1 | grep -oP -m 4 'tt\d*' | head -4 | grep -m 4 -f - $DIR/title.minify.tsv | head -4 | awk -F '\t' '{print "<li>"$2"</li>"}')
	echo "<ol style='font-size: 1.4rem;text-align:left;max-width: 500px;margin: 0 auto'>"
	echo "${TITLES}"
	echo "</ol>"
	echo "</div>"
fi
