#!/bin/bash
printf "Start.\n"
aws_exec="/usr/local/aws/bin/aws"

if [ ! -x ${aws_exec} ]; then
    printf "Failed. No executable file \"%s\"\n" "${aws_exec}"
    exit 1
else
    printf "Passed.\n"
    exit 0
fi
exit 2
