## Simple Divide & Conquer

I will explain the methodology in Width = 3
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

````
  def leadingDigitPossibleSolution(possibleToTry: Vector[Int], result:Int, lastLending:Int) = {
    possiblePermuatationN(possibleToTry,3)
      .filter {
        case xs@Vector(a,c,g) =>
          val na = a - lastLending
          val e = result - g
          na > 1 && na > c && c > 1 && g > 1 && na - c + g == result && e != 1 &&  !xs.contains(e)
      }
      .map{
        case xs@Vector(a,c,g) =>
          Vector(a, c, result - g, g)
      }.toStream.par
  }

  def innerDigitPossibleSolution(possibleToTry: Vector[Int], result:Int, lending:Int, lastLending:Int) = {
    possiblePermuatationN(possibleToTry,3)
      .filter {
        case xs@Vector(b,d,h) =>
          val f = result - h
          f != 1 && f >= 0  && f < BASE && (b + lending * BASE) - lastLending - d + h == result && f < BASE && !xs.contains(f)
      }
      .map{
        case xs@Vector(b,d,h) =>
          Vector(b, d, result - h, h)
      }.toStream.par
  }


```

Then we intersect the possible solutions. We will get the finally solution

i.e. one of the solution

`D - H + P = 11`  intersect `C - G + O = 10`  intersect `B - F + N = 10` intersect `A - E + M = 10`

```
      val leadingDigitPossibleSolutions = leadingDigitPossibleSolutionMap(branchState,lastLending)

      if(pos > 1) leadingDigitPossibleSolutions.flatMap {
        case ps => possibleSolutions.filter(xs => !xs.contains(ps(0)) && !xs.contains(ps(1)) && !xs.contains(ps(2)) && !xs.contains(ps(3)) ).map(ps ++ _)
      } else possibleSolutions

```

Choose the possible branches from two possible starting point and run recursively

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
    ) ++ func(
      possibleToTry = possibleToTry,
      branchState = State_11,
      lending = 0
    )
  }

```

## Performance 
Used machine : Google cloud custom (22 vCPUs, 130 GB memory) - Intel Haswell
JAVA_OPTS="-server -Xms120G -Xmx120G -XX:SurvivorRatio=8 -XX:ParallelGCThreads=17 -XX:+UseParallelGC"

#### Width 2
Base 10 ~ 0.08s
Base 16 ~ 0.16s
Base 22 ~ 0.21s
Base 28 ~ 0.3s
Base 34 ~ 0.4s

#### Width 4
Base 17 ~ 0.4s
Base 18 ~ 0.6s
Base 19 ~ 1s
Base 20 ~ 2s
Base 21 ~ 4.6s
Base 25 ~ 48s  (use ~ 30GB RAM)
base 26 ~ 121s (use ~ 60GB RAM)
Base 27 ~ 225s (use ~ 120GB RAM)

Base 28 ~ 450s (expected but not enough memory to calculate)
Base 29 ~ 900s (expected but notenough memory to calculate)

#### Width 5
Base 21 ~ 21s
Base 22 ~ 46s
Base 23 ~ 162s

#### Width 6
Base 21 ~ 4678s

## Why the memory consumption very high?
Each recursion need to hold their possible solutions reference at particular level of branching. 


## Room of improvements
* Reduce Memeory consumption
* Use akka-stream for distributed calculation
