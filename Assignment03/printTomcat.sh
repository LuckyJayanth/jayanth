#!/bin/bash

# check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

number=$1

# Check if the input is a positive integer
if ! [[ $number =~ ^[1-9][0-9]*$ ]]; then
    echo "Number must be a positive integer."
    exit 1
fi

# Check divisibility and print output
if ((number % 15 == 0)); then
    echo "tomcat"
elif ((number % 3 == 0)); then
    echo "tom"
elif ((number % 5 == 0)); then
    echo "cat"
else
    echo "Number is not divisible by 3, 5, or 15."
fi
