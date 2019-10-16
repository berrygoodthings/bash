#!/bin/bash
echo "Menu"

select action in access list fileLogOut  quit
do
case $action in
	access)
		echo "Access a repository"
		echo "Enter repository name"
		read repoName
		cd $repoName
		pwd
		;;
	list)
		echo "List all files"
		pwd
		ls
		;;
	fileLogOut)
		echo "Log out a file"
		echo "Enter the file you want to log out"
		read fileName
		
		sudo cp $fileName /.tmp
		;;
	quit)
		break
		;;
	*)
		echo "Invalid input"
		;;
esac
done
