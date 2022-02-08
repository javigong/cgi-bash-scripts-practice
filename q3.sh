#!/bin/bash

# identify output mime with this HTTP responese header
echo "content-type: text/html"

# an empty line to indicate end of header and start of the content
echo

# retrieve all titles from the current reddit home page
TITLES=$(curl -s -H 'user-agent: asdf' https://www.reddit.com/.json | json_reformat | grep '"title": "' | sed -E 's/(.*: ")(.*)",/\2<br>/')
echo "<p>Current titles on the reddit:<p>"
echo $TITLES
