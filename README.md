# MyElves : A simple suite of QOL upgrades
A collection of scripts and config files I made that make life easier.   
Scripts are written for the `bash`  terminal.

(Work in progress)
## Contents 
- [Crun](###-Crun)
- [Proj](###-Proj)
- [Foil (Now in its own repo)](https://github.com/Washiki/foil)
- [Templates and Configs](###-template)  

---
### Crun
Simple script that executes a gcc command for compiling C++ scripts. 
Takes inputs from an `input.txt`, and outputs to both the `console` and `output.txt`
By default, this executes `test.cpp`

#### Setup
In your .bashrc file, add : 
```
alias crun="<your-directory>/crun.sh"
```
where `your-directory` is the directory where crun.sh has been downloaded.

Now, to make it runnable as an executable, in your shell, type:
```
chmod +x <your-directory>/crun.sh
```
This gives executable permissions to 	`crun`, and can now be called as a command from wherever in the system.


#### Usage:
```
#Execute default script (test.cpp)
crun 

#Execute Particular Script
crun filename.cpp
```
#### File Structure
In the directory with your c++ file, create and input.txt and output.txt as such:
```
├── input.txt
├── output.txt
└── test.cpp OR filename.cpp
```

---
### Proj
Even simpler command wrapper script that creates a tag and readme file in a "project" directory. 
This was born completely out of my laziness to manage tag files and call ctags and whatnot. 

#### Usage
```
#Create a project called dirname
proj dirname
```

this will create a directory called `dirname` with the following structure
```
├── tags
├──.gitignore
└── README.md
```
and adds the files to the .gitignore file. 
Does NOT initialize git by default, most projects don't make it out , though probably should add that. 

---
## Vim Config 
Its a vim config, with some of my most used Plugins  and a few custom functions. 

Only exists because typing vim is more convenient and faster than dual booting or opening VScode.

### Features 

#### Keybinds and Commands
- Maps `<leader>` to the `,` .
	 It just works. Space as a leader was my earlier one, but it caused conflicts, so i settled on this.

- Full file Auto-Indent: `<leader>f`

- `Newcp` : takes a template file and copies it onto the file. In this instances, takes from a `template.cpp`

- `Copy`: Copies the entire file to the wsl clipboard via `Clip.exe`. The alternative to this was rebuilding vim with the + register.

- `UpdateTags()` : Checks for the existence of a tags files, and if present, uses `universal-ctags`to update them. This is called whenever the file is saved : Can be slow, but we'll cross that bridge when we get there. 


