#!/bin/bash

# identify output mime with this HTTP responese header
echo "content-type: text/html"

# an empty line to indicate end of header and start of the content
echo

# retrieve all titles from the subreddit provided as an argument
TITLES=$(curl -s -H 'user-agent: asdf' https://www.reddit.com/r/$1.json | json_reformat | grep '"title": "' | sed -E 's/(.*: ")(.*)",/\2<br>/')

if [ -z "$1" ]
then 
	echo "You need to provide a subreddit"
else
	echo "<p>Current titles on subreddit $1:<p>"
	echo $TITLES
fi
