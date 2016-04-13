#!/bin/sh

function run {
  echo 'COMPILER:' > $1
  gcc -v >> $1 2>&1
  echo >> $1
  echo 'CPU:' >> $1
  sysctl -n machdep.cpu.brand_string >> $1
  echo >> $1
  ./abcdefghppp <<< $2 >> $1 
}

gcc -m64 -Ofast -o abcdefghppp abcdefghppp.c || exit 1

./abcdefghppp <<< "1 10 2";

echo running w2
run "output_w2.txt" "
4
16 2
22 2
28 2
34 2
"

echo running w4
run "output_w4.txt" "
4
17 4
21 4
25 4
29 4
"

echo running w5
run "output_w5.txt" "
3
21 5
22 5
23 5
"

echo running w6
run "output_w6.txt" "
1
25 6
"

echo 'done'
