#!/usr/bin/env bash

name=${1:-"test.cpp"}
#variables just directy replace strings in the command 
g++ -std=c++20 -Wall -Wextra -Wconversion -pedantic -Wshadow -O2 "$name" -o test && ./test < input.txt > output.txt

cat output.txt 
#display the output as well 

# DO NOT FORGET TO RUN CHMOD +x crun.sh please 

#hi future me, before you forget, this is how it is all setup: 
#Your goated vimrc, with nerdTree disabled , ALE enabled and Newcp by default. 
#cp
# |-test.cpp <-this is where you code
# |-input.txt 
# |-output.txt
# |-crun.sh . Add alias crun='~/cp/crun.sh' to your bashrc. not making a seperate bashrc for just this. :
