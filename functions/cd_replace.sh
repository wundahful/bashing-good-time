###############################################################################
#
# cd_replace 
# Matthew Territo
# 2016
#
# Installation: 
# 	Source from your .bash_profile
#
# 	Recommended you copy it this file into a .bash_functions directory in your
# 	homedir then add this to your .bash_profile before the aliases and PATH
#
#		if [ -d ~/.bash_functions ]
#		then
#		  for f in  ~/.bash_functions/* ; do 
#		    source ${f}
#		  done
#		fi
# 
# Usage:
# 	cd_replace <str target>
#
# 	cd_replace searches backwards from your current directory to find <target>
# 	in the path. If the same file structure exists, it will change directories.
#
# Examples:
# 	/src/AppyMcAppFace/img/
# 	cd_replace BoatyMcBoatFace
# 	/src/BoatyMcBoatFace/img/
# 	cd_replace bin
# 	/bin/BoatyMcBoatFace/img/
#
###############################################################################

function cd_replace () {

	target="$1";

	##
	# Display help/usage and return
	if [ "$target" = "" ] || [ "$target" = "-h" ] || [ "$target" = "--help" ]
	then
		echo "
	Usage: cd_replace <str target>

	cd_replace searches backwards from your current directory to find <target>
	in the path. If the same file structure exists, it will change directories.

	Examples:
		/src/AppyMcAppFace/img/
		cd_replace BoatyMcBoatFace
		/src/BoatyMcBoatFace/img/
		cd_replace bin
		/bin/BoatyMcBoatFace/img/
"
	  return
	fi

	##
	# Split the current directory path into an array
	dirArray=(`pwd | sed "s/\// /g"`)

	##
	# Starting at the end, test backwards to find your target
	for (( i=${#dirArray[@]}-1; i >= 0; i--))
	do
		newPath=""

		##
		# Concatenate the path with target in each postion
		for (( j=0 ; j < ${#dirArray[@]}; j++ ))
		do
			newPath+="/"
			if [ $j == $i ]
			then
				newPath+=$target
			else
				newPath+=${dirArray[$j]}
			fi
		done

		##
		# If it exists, cd and end
		if [ -d $newPath ]
		then
			echo $newPath
			cd $newPath
			return
		fi
	done
}