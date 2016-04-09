### xnastudio is the original writer of a better version of lisp using style

#### Based on the idea of xnastudio (see the lisp under the non-challenge section), this round is try to improve for both 9 loops and move both to w4

#### w4 files

w4-func-try1.lisp                       (source based on w4-func-pretty.lisp and adapt for w4)
w4-func-try1.lisp (up to 21).output.txt (output up to base 21)

w4-opt1-m.lisp                          (9-loop opt1-m adapted for w4)

#### w4 results

The function code is modified to run the w4 version under Macbook Air 14 and result is:

BASE:17 answer:1430    - 503 seconds    (9 mintues)
BASE:21 answer:1595019 - 229785 seconds (2 days 16 hours !!!!) 
BASE:25 ...            - still running  (... :-)))))))))))))))

The 9-loop w4 version never return ... 

#### w2 files

w2-func-pretty.lisp      (same as xnastudio but some minor cosemtic changes)

w2-opt1-m.lispt          (optimised 9 loop which reduce time for 5 hours to 2 seconds)
w2-opt1-m.....output.txt (soe ooutput)

#### w2 version func and the 9-loop result (opt1 is the optimise 9 loop version) ===


|            |MAir-9loop   |L-100S-opt1  |W10-i3-func |MAir-func   |L-100S-func |w10-i5-U6200|Mair        |
|:-----------|:------------|:------------|:-----------|:-----------|:-----------|:-----------|:-----------|
|            |  9-loop     |9-loop-opt1  |  func      |    func    |   func     | 9-loop-opt1|  9lopt1    |
|            |             |[check-]     |            |            |            |            |            |
|            |             | (unique-try)|            |            |            |            |            |
|            |             | all-w-macro |            |            |            |all-w-macro |  allwm     |
|            |             |             |            |            |            |            |            | 
|v           |1.2.x        | 1.3.4       | 1.3.4      |  1.3.4     |  1.3.4     |     1.3.4  |   1.3.4    |
|            |             |             |            |            |            |            |            | 
|10 (5)      |18s          | [0.3s]      | not run    |  0.01s     | too fast   |  0.06s     |    0.012s  |
|            |             |(0.06s)      |            |            |            |            |            | 
|            |             |0.07s        |            |            |            |            |            |
|            |             |             |            |            |            |            |            | 
|16 (1794)   |1145s        |[4.3s]       | <0.1s      |0.094s      |0.257s      | 0.542s     |  0.267s    |
|            |             |(0.75s)      |            |            |            |            |            |
|            |             |0.95s        |            |            |            |            |            |
|            |             |             |            |            |            |            |            | 
|22 (17312)  |18839s (5+hr)|[38s]        | not run    |1.3s        |3.7s        |  1.806s    |  1.969s    |
|            |             |(6s)         |            |            |            |            |            |
|            |             |5s           |            |            |            |            |            |
|            |             |             |            |            |            |            |            | 
|28 (73812)  |:-)          |[192s]       | 8s         |8s          |24s         | 7.49s      |  9.049s    |
|            |             |(25s)        |            |            |            |            |            |
|            |             | 22s         |            |            |            |            |            |
|            |             |             |            |            |            |            |            | 
|34 (214033) |:-(          |[N.A.]       | 35s        |33s         |100s        | 24.62s     |  30.04s    |
|            |             |(87s)        |            |            |            |            |            |
|            |             |71s          |            |            |            |            |            |
|            |             |             |            |            |            |            |            |


#### details (just for my future self)

##### general remarks

Unlike the lisp-9-loop version, the function verson originally come from xnastudio is a much better and really lisp like version.  

The author of the lisp-9-loop (xnastudio), Dennis who wrote this readme.md has just made some cosmetic change and publish on behalf of xnastudio.  To avoid some primary 1 student come along and mistaken lisp is nothing but a fortan/cobol with a lot of () :-), please don't.

***

In general, lisp has 3 trees to deal with.  The tree of macro code, which generate the tree of program code and then manipuate both these code trees in the compile time.  Then the tree of code in run time will maninpuate itself (as code) and a tree of data.  It is hard to program but once you understand what the program try to do, you may find you are writing 1 page instead of many many (Java the new COBOL) pages.  It is called God's programming lanugage for a reason.  

***

The 9-loop is just loop in the first version.  (It becomes more complicated once optimisation is done to it as it is in here.  Copied from the function style, the loop is reverse and some cutting of loop is done)


For the function one, the approach here is just use function and recursive (which is similar to the adaptive c program).  The higher function on function way of program is not used.  And the macro use is very limited here.  

The core of the processing is in the R-Search code list.  The first two sub-list is simply the ending condition of a branch, the next two skip the impossible branches (i.e. no 0 in the first digit and no 1).  The most important code sub-list is the last two branches which generate the answer list (if it met the conditinos) and further branches in two, well, branches.

***

In general, lisp code is good in manipulate sympbols (tress of them).  The challenge is a bit unfair to lisp.  May be we can have a challenge like any number (unique or not - here 0-9 and duplicate 1 plus no 0 in the first digit), any operation (+, - , * , / and =) and get ...

The strength is its weakness I am afraid.


##### Todo:

Still challenge for optimisation is valid, I think xnastudio has exhausted most of the possibility; the general approach:

- check the user requirement (done)
- check the rep. (DSL, data-driven, ... etc.)
- check the algo ... (seems ok but has to learn from others; 
  no minimax, Alpha-Beta, neural network, ... etc. herustic)
- deal with some particular op e.g. 
  = symmetry (c+d = d+e = p); not understand so far but it cut significantly ?????
  = use p=1 (done)

- macro (not exhaustive but helping)
- tail call (used)
- rule engine (?)
- memorisation (not sure exhaust in particular no use of closure)
- high order function(may be slower)
- lazy computing (not relevant?)
- use different data structure (vector instead of lisp; to be tested?)
- use shift and bit comparion to deal with uniqueness comparsion (saw it in generative c; to be tested)
- use iteration instead of recursive (but generative c use recursive as well; not sure)

- check hardware and software version (hardware affect but not 3 order of magnitude cf generative c)
- check compiler version (sbcl v 1.3.4 is faster)
- check screen refresh issue (screen not just terminal; not much output and would not be an issue)
- compile to lisp code (not helping)
- compile to c code (not sure we have that option; scheme has)

Key is the cut the loop, replicate data generation etc.

#### The optimised version of 9-loop is sort of working for abcd-efgh version.

- 9 loop major saving via rearrange the loop try to cut the number of loop
  a) check ef - gh = ppp first (as the ab-cd = ef involve 6 symbols)
     <-- most saving and runnable but not 34 case
  b) try to eliminate some uniqueness issues (close to point info is availablefunc)
  c) use generative uniqueness and not use checking (done and faster)
  c) ?? still not use the c + d = d + c symmtery optimisation as not sure
  d) use macro to avoid function call (can try later space 0?)
     slower in the small no case due to overhead but faster in the large no. case (87 vs 77s)
  e) avoid one repeat calcution of *ef* but store it into local/global variable (77s to 72s)
  f) one way to eliminate more loop by doing exhaustive generation macro is not helping (down to 111s)!
 

##### Running remark:

###### Mac 

use Mac port for sbcl (for batch mode)
use clozure for testing 

###### Windows 

need to restart to avoid the core not found and a batch file sample is as follows (note under interactive mode (load ... require /\ but in the "dos command" mode just use normal filename and the system will generate \\ for you))

rem @ECHO OFF
rem need to reboot to get the environment for core
set PATH=C:\Program Files\Steel Bank Common Lisp\1.3.4;%PATH%
if [%1] == [] "C:\Program Files\Steel Bank Common Lisp\1.3.4\sbcl.exe" --script D:\...\abcdefghppp-dolist-p=1-tryoptim1.lisp

in "dos command" mode ....bat 1

##### compile runing remarks

Amend to use compile then run under sbcl as follows 

(defun main () 

  (print "hello")
  (time (print_met_cond_at_base_dolist_p=1 10)) 
  (time (print_met_cond_at_base_dolist_p=1 16)) 
  (time (print_met_cond_at_base_dolist_p=1 22)) ; 5 hours old ver
  (time (print_met_cond_at_base_dolist_p=1 28)) ; never finish after 1 day
  (time (print_met_cond_at_base_dolist_p=1 34)) ; not going to try

)

(sb-ext:save-lisp-and-die "opt1-main2c" :toplevel #'main :executable t)

But result is the same
