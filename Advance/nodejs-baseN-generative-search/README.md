## Problem statement
  - Question: find a,b,c,d such that
    1. all with distinct digits in base-N.
    2. all have W=floor((N-1)/4) number of digits
    3. a-b=c+d=e=11...1 (W number of 1)
  - for example, 
      for base 17, find a,b,c,d,e,..m,n,o,p,r such that
        abcd-efgh=ijkl && ijkl+mnop=rrrrr
      for base 21, find a,b,c,d,e...s,t,u such that
        abcde-fghij=klmno && klmno+pqrst=uuuuuu

## Idea
  - generate possible value of c one by one at most B^W time. 
  - for each value of c, try to find the corresponding d.
    if not found, try next c; if found, try next step
  - build a set of digits for a and b. Then build a table for 
    the difference of digits. Construct values of a and b starting 
    from least significant digit, this allow pruning a lot 
    of useless permutation.

## Tricks
  - Due to symmetry of c and d (c + d = d + c = e),
    we can just scan for c < d and then swap c and d each 
    time and do the same things twice. This allows reuse of 
    used-table and skip ~45% top-level iteration. 
    
## Time complexity  
  - the time spent on diffSearch() is a bit hard to analysis
    the worst case is O(2^B), but usually should be much 
    faster than that.
  - Let the time complexity of diffSearch() be T.
    The overall complexity is O( B^(W+1)*T )
    
## Space complexity
  - current version use ans[] to store solutions in order 
    not to do IO. Except that only use two array 

## Result 
Test on macbook pro 2014 

```
      take   <1 seconds for base 10 width 2 (        5 solutions)
      take   <1 seconds for base 16 width 2 (     1794 solutions)
      take   <1 seconds for base 22 width 2 (    17312 solutions)
      take   <1 seconds for base 28 width 2 (    73812 solutions)
      take   <1 seconds for base 34 width 2 (   214033 solutions)
      
      take   <1 seconds for base 17 width 4 (     1430 solutions)
      take   ~8 seconds for base 21 width 4 (  1595019 solutions)
      take  ~12 seconds for base 25 width 4 ( 62811420 solutions)
      take ~1.5 minutes for base 29 width 4 (796724927 solutions)
      
      take   <4 seconds for base 21 width 5 (    96220 solutions)
      take  ~15 seconds for base 22 width 5 (  1076604 solutions)
      take  ~40 seconds for base 23 width 5 (  9686936 solutions) 
      
      take  ~10 minutes for base 25 width 6 (  9310592 solutions) 
  ```
