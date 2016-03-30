#!/bin/sh

gcc -O3 -o abcdefghppp abcdefghppp.c 

## for testing 
# ./abcdefghppp <<< "1 10 2"

echo running w2 
./abcdefghppp > output_w2.txt <<-"END"
4
16 2
22 2
28 2
34 2
END

echo running w4
./abcdefghppp > output_w4.txt <<-"END"
4
17 4
21 4
25 4
29 4
END

echo 'done'
