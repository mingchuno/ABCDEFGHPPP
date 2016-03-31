#!/bin/bash

#
#$ cd /Users/$USER/Library/Mobile\ Documents/M6HJR9W95L\~com\~textasticapp\~textastic/Documents/icloud-personal/primary1q 
#$ chmod +x abcdefghppp-script.sh 
#$ ./abcdefghppp-script.sh 
#

export PATH=/opt/local/bin:/opt/local/sbin:/Applications/MiniZincIDE-2.0.13.app/Contents/Resources:$PATH

cd /Users/$USER/Library/Mobile\ Documents/M6HJR9W95L\~com\~textasticapp\~textastic/Documents/icloud-personal/primary1q 

# icloud abcdefghppp.sh 

mysub() {

echo
echo "--------------------"
echo "$1 base $2"
# no -p 2 etc. option as one use flatzinc behind the screen which not support this
time minizinc -a abcdefghppp-base-$1.mzn abcdefghppp-base-$1-$2.dzn > abcdefghppp-base-$1-$2.output.txt 
echo "need to minus 1 divide by 2 for no. of solutions: "
wc -l     abcdefghppp-base-$1-$2.output.txt
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

mysub "w2" "10"
mysub "w2" "16"
mysub "w2" "22"
mysub "w2" "28"
mysub "w2" "34"
mysub "w4" "17"
mysub "w4" "21"
mysub "w4" "25"
mysub "w4" "29"





