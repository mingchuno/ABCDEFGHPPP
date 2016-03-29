## minizinc accept the challenge but not performing very well …

## Issues

Too slow e..g Node.js version macbook pro by Jack Tang and Gap Lo for w4-21 is 8s vs mine is around 480s or around 60 times slower.
May need to turn on something and do optimisation.

May need to check if solution require to use base number to be expressed in digit and alphabet. 

## Presentations in decimal only!!!!

Instead of using 0…9 a…z (36 digits max), I use a convention of ~ and decimal to represent whatever number in whatever base.  This, at least to me, eases the checking of the result.  For example, instead of 

	Case base=17
	5eg0-3a7b=2486, 2486+fd9c=11111

I use

	w4 base 17
	16~15~13~4 - 2~6~0~10 = 14~9~12~11 + 3~8~5~7= 1~1~1~1~1

I can mentally calculate and checked the calculation without thinking g+7 equal to.  When the base go to 34 what is x + d …  Also, this convention can allow the base to go beyond 36 … In fact, cannot finish even w4-25 after generation nearly 2GB output!

Well not that my minizinc+mac-air can handle it though ;-p

## Results

Test on macbook air Early 2014 (NJ is the nodejs time under the Advance dir.)

	wd-base        time   (NodeJs) [lines]   solutions (same as NJ one if avail)

	w2-10 		    <1s   (<1s)       [11]           5
	w2-16 		    <1s   (<1s)     [3589]		 1,794
	w2-22 		     2s   (<1s)    [34625]	    17,312
	w2-28 		     8s   (<1s)   [147625]	    73,812
	w2-34 		    22s	  (<1s)   [428067]	   214,033

	w4-17 		    21s	  (<1s)     [2861]		 1,430
	w4-21        7m 40s   ( 8s)  [3190039]   1,595,019	
	w4-25  	est 12 hour             [N.A.]        N.A. (should be 62,811,420)
	w4-29 	est 60 hour   (60s)	    [N.A.]        N.A. (should be 796, 724,927)

## File-structure

The main overall files are:

	abcdefghppp-base-readme.md          This readme.md file
	abcdefghppp-script.sh               The shell script to run this
	abcdefghppp-base-result.output.txt  The terminal script

The two models files are: 

   abcdefghppp-base-w2.mzn    The model file for 2 digits' case
   abcdefghppp-base-w4.mzn    The model file for 4 digits' case

and each run require a parm file format as:

   abcdefghppp-base-w?-??.dzn                 The parm file (i.e. the base no)

Run output are on the same directory level but has been moved to scenario-run-output in this github for ease of reading; only the first50.output.text has been sent to github:
   
   abcdefghppp-base-w?-??.first50.output.txt  The first 50 solutions as required
   abcdefghppp-base-w?-??.last50.output.txt   (for my further easy checking)
   abcdefghppp-base-w?-??.output.txt          The full output (all cases)

The w4-25, w4-29 cannot be completed in reasoable time (estimated 12 hours and 2 day 12 hours :-)) and hence only get the parm file.  There is no output.


	

