## Simple Divide & Conquer
**Note: It is not a efficient alogrithm but it is better than permutation and easier to implement.**

I will explain the methodology in Width = 4
```

   A B C D
 - E F G H
 ----------
   I J K L
 + M N O P
 ----------
  1 1 1 1 1

```

First pre-generate all possible solutions for inner digit & leading digit

Then we cross & filter the possible solutions => finally solution

i.e.

`D - H + P = 11` cross `C - G + O = 10`  cross `B - F + N = 10` cross `A - E + M = 10`


Recursively repeat the procedures. Choose the possible branches from two possible starting point (right most)

```
             
	                ______________________D - H + P = 11___________________
	               /                                                       \
	        C - G + O = 10                                        (C + base) - G + O = 10
	         /          \                                         /                    \
	B - F + N = 10    (B + base) - F + N = 10           (B - 1) - F + N = 10      (B - 1 + base) - F + N = 10
	    /                    \                                  /                        \
	A - E + M = 10      (A - 1) - E + M = 10           A - E + M = 10           (A - 1) - E + M = 10



	                _________________(D + base) - H + P = 11_______________
	               /                                                       \
	         ???????													???????
```

Start the recursion

```
  def mainRecur() = {
    func(
      possibleToTry = possibleToTry,
      branchState = State_11,
      lending = 1
    )
    func(
      possibleToTry = possibleToTry,
      branchState = State_11,
      lending = 0
    )
  }

```

## Performance 
Used machine : Google cloud custom (24 vCPUs, 156 GB memory) - Intel Haswell

JAVA_OPTS="-server -Xms150G -Xmx150G -XX:SurvivorRatio=8 -XX:ParallelGCThreads=17 -XX:+UseParallelGC"

#### Width 2
* Base 10 ~ 0.08s
* Base 16 ~ 0.11s
* Base 22 ~ 0.21s
* Base 28 ~ 0.3s
* Base 34 ~ 0.4s

* Base 50 ~ 1.2s
* Base 70 ~ 3.2s
* Base 100 ~ 9.3s

#### Width 4
* Base 17 ~ 0.4s
* Base 21 ~ 1.4s
* Base 25 ~ 17.8s(use ~ 30GB RAM)
* Base 26 ~ 121s (use ~ 60GB RAM)
* Base 27 ~ 187s (use ~ 120GB RAM)

* Base 28 ~ 360s (expected but not enough memory to calculate)
* Base 29 ~ 720s (expected but notenough memory to calculate)

#### Width 5
* Base 21 ~ 5s
* Base 22 ~ 12s
* Base 23 ~ 55s

#### Width 6
* Base 25 ~ 4678s

## Why is it so slow on large width?
As the only operation is "Cross and filter" on the possible solutions. When the set of possible solution is too large, the operation on a huge set will become super slow. 

Time complexity for List Operation(Cross and filter) = `O(n^2)`

For the worst case, the possible solution set double after crossing, total time complexity = `O(n^(2W))`


## Why the memory consumption very high?
Each recursion need to hold their possible solutions reference at particular level of branching. 


## Room of improvements
* Use akka-stream for distributed calculation
