#!/bin/bash -e

nslookup www.google.com > /dev/null
if [[ $? != 0 ]]; then
    printf "Failed. Can't resolve external domain.\n"
    exit 1
fi
