## problem statement
  - Question: find a,b,c,d such that
    1. all with distinct digits in base-N.
    2. all have W=floor((N-1)/4) number of digits
    3. a-b=c+d=e=11...1 (W number of 1)
  - for example, for base 17, find a,b,c,d,e,..m,n,o,p such that
      abcd-efgh=ijkl && ijkl+mnop=11111

## idea
  - generate the set S of all possible value of a,b,c,d
    which size should equal to (N-1)*(N-2)*(N-3)...*(N-W) 
    The time complexity is O(B^W)
  - find all possible pairs of c and d 
    since c = 11..1 - d  and c,d are element of S
    we can scan c over S, and check where d in S by binary search.
    This can be done in O(B^W*ln(B^W))
  - finally, we have candidates of a and c, we need to find b.
    This is done by brute force. With a trick that b >= 10..0
    and a - b = c => a-c >= 10..0

## result 
  - run on macbook pro 2014
      take <1 second for base 10
      take ~26 seconds for base 17
      take ~44 seconds for base 18
      take 1 min 25 seconds for base 19
      take 3 min 17 seconds for base 20
      