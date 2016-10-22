#!/bin/bash

# Web Application Initializer by jyoh written in OCT 23 2016

# Definition of functions
# [1026] make specific folder at certain location
#		 Also make sub-folders automatically(html/css/images/js)  
#		 Default folder will be ~/
# [TOBE] -git option : git integration 

# Usages
# ./wpinitializer -d ${project path} :: executing to certain location
# ./wpinitializer -i :: display meta information
# ./wpinitializer -h :: display usage


USER=${USER}
USER_HOME=${HOME}
VER=0.01 #20161023
V_STATUS='RELEASE'
B_DATE=20161023
WEB_FOLDERS=('html' 'js' 'css' 'resources')

function displayMeta {
	echo 'WebApplicationInitializer '$V_STATUS' ver.'$VER' build.'$B_DATE
}

function displayUsage {
	echo 'Options\n[ -d ] : Making Web directory to certain location\n[ -i ] : Display meta information\n[ -h ] : Display Usage'
}


function buildDirectory {
	if [ -d $1 ]
		then 
			echo '[ '$1' ] is already exist'
			exit 1;
	else 
		mkdir $1
		if [ $? -ne 0 ]
			then
				echo 'Failed to create directory [ '$1' ]'
				exit 1;
		else 
			chown $USER $1
			chmod 777 $1
		fi;
	fi;
}




if [ $# -lt 1 ]
	then 
	echo 'Ineffcient option ERROR :: Refer usage below'
	displayUsage
	exit 1
fi;

# =============== Parameter distinguish
case $1 in
	
	# [PRINT META]
	'-i' )
		displayMeta;
		exit 0;
		;;
	
	# [PRINT USAGE]
	'-h' )
		displayUsage
		exit 0;
		;;

	# [BUILD DIR]		
	'-d' )
		echo "Building Web directories..."
		if [ $# -gt 1 ]
			then
			buildDirectory $2
			if [ $? -eq 0 ]
				# build sub directories
				then 
				(
					cd $2
					for folder in ${WEB_FOLDERS[*]}
						do 
							buildDirectory $folder
							if [ $? -ne 0 ]
								then echo 'Failed to create sub directory [ '$folder' ]'
								exit 1;
							fi;
					done

					if [ $? -eq 0 ]
						then
						echo 'Your WebApplication diretory structure is ready.'
					fi;
				)
			else 
				echo 'Failed to build Root directory'
				exit 1;
			fi;
		else
			echo 'Directory name is required'
			exit 1;
		fi;
		;;

	# [GIT INTEGRATION]
	'-git')
		echo 'Git integration is not prepared yet'
		exit 0;
		;;
	*)
		echo 'Unknow Option provided'
		displayUsage
		exit 1;
		;;
esac


exit 0