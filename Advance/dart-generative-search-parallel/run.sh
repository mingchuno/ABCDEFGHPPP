#!/usr/bin/env bash

NUM_THREAD=8;

function run {
  FILE="temp_w$2_b$1.txt"
  dart abcdefghppp.dart $1 $2 $NUM_THREAD >> $FILE
}

function overview {
  FILE="output_w$1.txt"

  echo "RUNTIME: $(dart --version 2>&1)" > $FILE
  echo "CPU: $(sysctl -n machdep.cpu.brand_string)" >> $FILE
  echo "NUMBER OF THREAD: $NUM_THREAD" >> $FILE
  echo >> $FILE

  cat temp_w$1* >> $FILE
  rm temp_w$1*
}

echo 'running w2'
run 16 2
run 22 2
run 28 2
run 34 2
overview 2

echo 'running w4'
run 17 4
run 21 4
run 25 4
run 29 4
overview 4

echo 'running w5'
run 21 5
run 25 5
overview 5

echo 'running w6'
run 25 6
overview 6

echo 'done'