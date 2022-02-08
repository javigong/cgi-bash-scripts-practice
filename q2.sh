#!/bin/bash

# identify output mime type with this HTTP response header
echo "content-type: text/plain"

# an empty line to indicate end of header and start of the content
echo

# tell a random joke
DADJOKE=$(curl -s https://icanhazdadjoke.com)
echo $DADJOKE 
