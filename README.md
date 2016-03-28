## Problem to solve
`AB - CD = EF, EF + GH = PPP` where ABCDEFGHP are distinct and in Range(0,1,2,...,9) 

## Backgroud

(AB - CD = EF) + GH = PPP problem, inspired by golden post:

考起碩士生的小一數學題(ppp)解法 - 香港高登
http://m2.hkgolden.com/view.aspx?message=6307521&type=SW&page=1

Credit to golden son

#### Contribution

1. Fork me
2. Impl your language/algo under dir `<language>-<algo>` format, e.g. `python-bruteforce`
3. Add comment/script for others to build & run
4. Add example output in comment / create a output.txt
5. Make sure your pull request commits are meaningful!
6. Submit Pull Request
 
#### Create README.md (Optional)
We strongly recommend you to add a README.md in your folder, here are some of the questions that developers wonder to know :)
* How efficient is your solution?
* Is there any room of improvements?
* What are the Time Complexity & Space Complexity of your algos?

#### Recommended Folder Structure
```
├── java-bruteforce/
|     ├── abcdefghppp.java
|     ├── output.txt
|     ├── README.md (Optional)
|     ├── run.sh (Optional)
|     |
├── haskell-permutation/
|     ├── abcdefghppp.hs
|     ├── output.txt
|     ├── README.md (Optional)
|     ├── Makefile (Optional)
...
```
## Advance Challenges 
PCs in this age have very powerful computation power. Thus, Base 10 `AB - CD = EF, EF - GH = PPP` is too easy to compute the result. That's why someone even said that brute-force is also be accepted. 

Let's try more complicated scenario, all alphabats repersent a single value (in base) & distinct. It will be easier to see the significant performance difference of each approach.

#### Advance 
Base 16 `AB - CD = EF, EF - GH = PPP` (Width = 2)

Base 22 `AB - CD = EF, EF - GH = PPP` (Width = 2)

Base 28 `AB - CD = EF, EF - GH = PPP` (Width = 2)

Base 34 `AB - CD = EF, EF - GH = PPP` (Width = 2)

Base 17 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ` (Width = 4)

Base 21 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ` (Width = 4)

Base 25 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ` (Width = 4)

Base 29 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ` (Width = 4)

...

** You must solve at least 2 of them **

All suggestions are welcome. Just modify this file and PR


#### output.txt rules
All output.txt in Advance MUST include the following information

* Machine used (Must be the first line)
* Total number of solutions 
* First 50 solutions
* Time used for calculation
* include all Base result


#### Recommended Folder Structure
```
├── Advance/
|     ├── scala-optimized-permutation-parallel/ 
|     |     ├── abcdefghppp-w2.scala (Only handle width = 2)  
|     |     ├── output_w2.txt        (w2 = width 2)
|     |     ├── README.md            (Optional)
|     |     ├── run.sh               (Optional)
|     ├── javascript-bruteforce/ 
|     |     ├── abcdefghppp-generic.js (Handle all width)
|     |     ├── output_w2.txt          (w2 = width 2)
|     |     ├── output_w4.txt          (w4 = width 4)
|     |     ├── README.md              (Optional)
|     |     ├── run.sh                 (Optional)
...
```

## TODO
- add more languages
- travis CI?
