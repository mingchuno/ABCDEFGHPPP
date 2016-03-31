#!/bin/bash

#
#$ cd /Users/$USER/Library/Mobile\ Documents/M6HJR9W95L\~com\~textasticapp\~textastic/Documents/icloud-personal/primary1q 
#$ chmod +x abcdefghppp-script.sh 
#$ ./abcdefghppp-qis1.sh 
#

export PATH=/opt/local/bin:/opt/local/sbin:/Applications/MiniZincIDE-2.0.13.app/Contents/Resources:$PATH

#cd /Users/$USER/Library/Mobile\ Documents/M6HJR9W95L\~com\~textasticapp\~textastic/Documents/icloud-personal/primary1q 

# icloud abcdefghppp.sh and can use pwd 

mysub() {

echo
echo "--------------------"
echo "$1 base $2"
# no -p 2 etc. option as one use flatzinc behind the screen which not support this

#time minizinc -a abcdefghppp-$3-$1.mzn abcdefghppp-base-$1-$2.dzn > abcdefghppp-base-$1-$2.output.txt 
time minizinc -a abcdefghppp-$3-$1.mzn -D "base = $2;" > abcdefghppp-base-$1-$2.output.txt 
echo "need to minus 1 divide by 2 for no. of solutions: "
wc -l     abcdefghppp-base-$1-$2.output.txt
echo
echo "    $4 as the predicted no. of lines"
echo "    $5 as the no. of solutions" 
echo
echo "checking first 5 and last 5:"
echo
head -10  abcdefghppp-base-$1-$2.output.txt
echo "..."
tail -11  abcdefghppp-base-$1-$2.output.txt
head -100 abcdefghppp-base-$1-$2.output.txt > abcdefghppp-base-$1-$2-first50.output.txt
tail -100 abcdefghppp-base-$1-$2.output.txt > abcdefghppp-base-$1-$2-last50.output.txt
echo "===================="
} 

echo
echo "---------------------------------------"
echo "|models macbook air 13 inch Early 2014|"
echo "---------------------------------------"
echo

mysub "w2" "10" "base"  "11" "5"

mysub "w2" "16" "base"  "3589" "1,794"
mysub "w2" "22" "base"  "34625" "17,312"
mysub "w2" "28" "base"  "147625" "73,812"
mysub "w2" "34" "base"  "4208067" "214,033"

mysub "w4" "17" "qis1"  "2861" "1,430"
mysub "w4" "21" "qis1"  "3190039" "1,595,019"
mysub "w4" "25" "qis1"  "125622841" "62,811,420"
mysub "w4" "29" "qis1"  "1593449855" "796,724,927"






