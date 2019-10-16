#!/bin/bash

repoName=''

moveParentDirectory(){
	if [[ $(pwd) = $baseDir/$repoName ]]
 	then
		echo "Oops! It looks like you can't go back any further. Return to main menu for repository options."
	else
		cd ..
	fi
	echo ""
	echo "Current Directory: "
	pwd
}

createDirectory(){
	echo "Enter the name of the new directory:"
	read newDirectoryName
					
	if [ -d "${newDirectoryName}" ]
	then
		echo "Oops! It looks like this directory already exists. Moving you there now..."
		cd "${newDirectoryName}"
						
	else
		mkdir "${newDirectoryName}"
		echo ""
		echo "Success! The directory ${newDirectoryName} has been created. Moving you there now..."
		cd "${newDirectoryName}"
	fi
		echo ""
		echo "Current directory:"
		pwd	
}

accessDirectory(){
	echo "Please enter the name of the directory you would like to access."
	echo "Enter directory name:"
	read accessDirectoryName
	if [ ! -d $accessDirectoryName ]
	then
		echo ""
		echo "Oops! This directory doesn't exist. Please select an option below:"
		accessDirectoryOptions=("Create the directory ${accessDirectoryName}" "Go back to the repository menu")
		select opt in "${accessDirectoryOptions[@]}"
		do
			case $opt in
				"Create the directory ${accessDirectoryName}")
					mkdir "${accessDirectoryName}"
					echo ""
					echo "Success! The directory ${accessDirectoryName} has been created. Moving you there now..."
					cd "${accessDirectoryName}"
					break
					;;

				"Go back to the repository menu")
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	else
		echo ""
		echo "Moving you to the ${accessDirectoryName} directory.."
		cd "${accessDirectoryName}"
		
	fi
	echo ""
	echo "Current Directory: "
	pwd
	repoMenu
}

removeDirectory(){
	echo "NOT IMPLEMENTED"
}

createFile(){
	echo "Enter the name of the file you would like to create"
	read fileName
	touch $fileName
	if [ -e $fileName ] #if the file can be opened
	then
		echo "File created successfully"
	else
		echo "Creating a file failed"
	fi
}

accessFile(){
	echo "Access a file to edit"
	echo "Enter the file name you want to edit in this repository"
	read fileName
	if [ -e $fileName ] #if the file can be open
	then
		nano $fileName
	else #file does not exist
		echo "Could not find a file with this name"

		createFileOptions=("Create the file $fileName" "Go back to the repository menu")
		select opt in "${createFileOptions[@]}"
		do
			case $opt in
				"Create the file $fileName")
					touch $fileName
					nano $fileName
					break
					;;

				"Go back to the repository menu")
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	fi
}

removeFile(){
	echo "Remove a file"
	echo "Enter the name of the file you would like to remove"
	read fileToRemove
	if [ -e $fileToRemove ] #if the file exists
	then
		rm $fileToRemove
		echo "File has been removed"
	else #the file doesn't exist
		echo "This file doesn't exist"
	fi
}

listRepoContents(){
	ls
	# 	echo ""
# 	echo "Listing the contents for: "
# 	pwd
# 	echo ""

# 	# Prints a list of directorys in the current directory the user is in
# 	echo "Directories: "
	
# 	# If there are directories, print them
# 	if [ -d / ]
# 	then
# 		ls -d */
# 	# else print an none message
# 	else
# 		echo "None"
# 	fi	
	
# 	echo ""
# # Shows files only. Grep will return lines that don't contain a slash
# 	echo "Files:"

# 	if [ -a ] 
# 	then
		
# 		ls -p | grep -v /
# 	else
# 		echo "empty"
# 	fi
}

repoMenu(){

	while true
	do
	    echo "-------------------------------------------------------------------------"
		echo "                         Repository Menu: $repoName                      "
		echo " Select one of the menu options by entering the relevant number (e.g. 1) "	
		echo "-------------------------------------------------------------------------"
		options=("Move to the parent directory" "Create a new directory" "Access a directory" "Remove a directory" 

		"Create a new file"  "Access a file"  "Remove a file"  "List the repository contents"	"Go back to the main menu")
		select opt in "${options[@]}"
		do
			case $opt in
				"Move to the parent directory")
					moveParentDirectory
					break 
					;;
				"Create a new directory")
					createDirectory
					break
					;;
				"Access a directory")
					accessDirectory
					break
					;;
				"Remove a directory")
					removeDirectory
					break
					;;
				"Create a new file")
					createFile
					break
					;;
				"Access a file")
					accessFile
					break
					;;
				"Remove a file")
					removeFile
					break
					;;
				"List the repository contents")
					listRepoContents
					break
					;;
				"Go back to the main menu")
					cd ..
					mainMenu
					;;
				*)
					echo "Please enter a valid number!"
					;;
			esac
		done
	done
}

mainMenu () {
	
	while true
	do
		echo "-------------------------------------------------------------------------"
		echo "                             Main Menu                                   "
		echo " Select one of the menu options by entering the relevant number (e.g. 1) "	
		echo "-------------------------------------------------------------------------"
		options=("Create a repository" "Access a repository" "Remove a repository" "Exit menu")
		select opt in "${options[@]}"
		do
			case $opt in
				"Create a repository")
					echo "Please enter the name of the repository you would like to create."
					echo "Enter repository name:"
					read repoName
					if [ -d $repoName ] #if the repo does exist
					then
						echo "Oops! It looks like this repository already exists. Moving you there now.."
						cd "${repoName}"
						echo ""
						echo "Current Directory: "
						pwd
					else
						mkdir "${repoName}"
						cd "${repoName}"
						mkdir .tmp
						echo ""
						echo "Success! The repository ${repoName} has been created. Moving you there now..."
						echo ""
						echo "Current Directory: "
						pwd
					fi
					pwd
					repoMenu
					break
					;;
				"Access a repository")
					echo ""
					echo "Please enter the name of the repository you would like to access. If it doesn't exist, you will be given the option to create one."
					echo "Enter repository name:"
					read repoName
					if [ -d $repoName ] #if the repo does exist
					then
						cd $repoName
					else # if the repo doesn't already exist
						echo ""
						echo "Oops! This repository doesn't exist. Select one of the menu options below."
						select action in "Create the repository ${repoName}" "Go back to main menu"
						do
						case $action in
							"Create the repository ${repoName}")
								mkdir $repoName
								cd $repoName
								mkdir .tmp
								echo ""
								echo "Success! The repository ${repoName} has been created. Moving you there now..."
						esac
					done
					fi
					pwd
					repoMenu
					break
					;;
				"Remove a repository")
					echo "Remove a repository"
					break
					;;
				"Exit menu")
					echo "quit"
					exit 
					;;
				*)
					echo "Please enter a valid number!"
					;;
			esac
		done
	done
}

baseDir=$(pwd)
mainMenu