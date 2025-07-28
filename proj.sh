#! /bin/bash

#format: proj <projectname>

#handling no input 
if [ -z "$1" ]; then #-z flag compares with zero or null. 
	echo "Enter a filename after proj; i.e proj <project_name>"
	exit 1
fi #marks the end of an if block? cool idea though 


NAME=$1 #this is how arguements are handled 
mkdir -p "$NAME"
cd "$NAME" || { echo "command failed"; exit 1; }  #failure case
#you can just {...;} for stringing together multiple commands in a single line 

#making the actual files 
echo "# $NAME" > README.md 
echo "tags" > .gitignore 

#create tag file
ctags -R

echo "Project '$NAME' is ready uwu" 
