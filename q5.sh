#!/bin/bash

# identify output mime with this HTTP response header
echo "content-type: text/html"

# an empty line to indicate end of header and start of the content
echo

# return google search result of the argument provided
SEARCH=$(curl -s -H 'user-agent: asdf' "https://www.google.ca/search?q=${1}")

if [ -z "$1" ]
then
     	echo "You need to provide a search term"
else
    	echo "${SEARCH}"
fi

