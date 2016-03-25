#!/bin/bash

# Question:
# https://www.facebook.com/FrontlineTechWorkersConcernGroup/posts/1123488327690899
#
# This script is just for fun. "bash" is not the right tool to solve this 
# problem.
#

check()
{
# AB=$1, CD=$2, EF=$3, GH=$4 

#uncomment below line, if you don't want leading zero case
#	[[ $((10#$1)) -lt 10 || $((10#$2)) -lt 10 || $((10#$3)) -lt 10 || $((10#$4)) -lt 10 ]] && return

#check if matching the formula AB-CD=EF and EF+GH=111
	if [[ $((10#$1 - 10#$2)) -eq $((10#$3)) && $((10#$3 + 10#$4)) -eq 111 ]]
	then
		echo "  $1"
		echo "- $2"
		echo "-----"
		echo "  $3"
		echo "+ $4"
		echo "-----"
		echo " 111"
		echo "====="
	fi
}

#Gen the permutations using recursion and call check() for each permutation
perm() {
	local items="$1"
	local out="$2"
	[[ "$items" == "" ]] && check ${out:0:2} ${out:2:2} ${out:4:2} ${out:6:2} && return
	local i=0
	for (( i; i<${#items}; i++ )) 
	do
		perm "${items:0:i}${items:i+1}" "$out${items:i:1}"
	done
}

perm "023456789"
