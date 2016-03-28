## Advance Challenges 
PCs in this age have very powerful computation power. Thus, Base 10 `AB - CD = EF, EF - GH = PPP` is too easy to compute the result. That's why someone even said that brute-force is also be accepted. 

Let's try more complicated scenario, all alphabats repersent a single value (in base) & distinct. It will be easier to see the significant performance difference of each approach.

#### Advance Formula
Base 17 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ`

Base 21 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ`

Base 25 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ`

Base 29 `ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ`

All suggestions are welcome. Just modify this file and PR

#### Recommended Folder Structure
```
├── Advance-base/
|     ├── java-base16-bruteforce/
|     |     ├── abcdefghppp.java
|     |     ├── output.txt
|     |     ├── README.md (Optional)
|     |     ├── run.sh (Optional)
|     ├── javascript-generic-base-bruteforce/
|     |     ├── abcdefghppp.java
|     |     ├── output.txt
|     |     ├── README.md (Optional)
|     |     ├── run.sh (Optional)
├── Advance-formula/
|     ├── haskell-base17-permutation/
|     |     ├── abcdefghppp.hs
|     |     ├── output.txt
|     |     ├── README.md (Optional)
|     |     ├── run.sh (Optional)
...
```
