## Advance Challenges 

This R code is designed to solve `AB - CD = EF` and `EF - GH = PPP` with base from 10 to 36 (can be extended to base 37 or hight therotically, if a larger set of character code is provided)


#### How to use:

Just run all the functions the file `abcdefghppp_w2.R`.

If you want to solve the equation when base = b, you can just type

```
solve_w2(base = b)
```


#### General idea:

1. Find all possibilites of digit of ones of `x` + `y` and `x` - `y` and the value that will carry to digit of tens under a specified base.

2. Find all possiblities of `e` and `g`, such that `e + g` is greater than base (carry 1 or more to the digit of tens) and set the carried digits to `p`. Exclude cases that `e`, `g` and `p` are not distinct.

3. Find all possibilities of `f` and `h` such that the digit of ones of `f + h` equals to the values of `p` found in previous step. Exclude cases that `f`, `h` and `p` are not distinct.

4. Merge the possiblities sets in step 2 and 3 by `p`. Include cases that `ef + gh = ppp` and `e`, `f`, `g`, `h` and `p` are distinct.

5. Find all possiblities of `a` and `c` such that `a - c` equals to the values of `e` found in previous step.  Exclude cases that `a`, `c` and `e` are not distinct and `a` < `c`.

6. Find all possiblities of `b` and `d` such that `b - d` equals to the values of `f` found in step 4.  Exclude cases that `b`, `d` and `f` are not distinct.

7. Merge the sets obtained in step 4, 5 and 6 by `e` and `f`. Include cases that `ab - cd = ef` and `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h` and `p` are distinct. Then, the solutions of `ab - cd = ef` and `ef + gh = ppp` are found.


#### Possible improvement in the future

* Make use of the properties that `ef + gh = gh + ef`



