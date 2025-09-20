#!/usr/bin/env bash

name=${1:-"test.cpp"}
#variables just directy replace strings in the command 
g++ -std=c++20 -Wall -Wextra -Wconversion -Wshadow -O2 "$name" -o test && ./test < input.txt > output.txt

cat output.txt 
