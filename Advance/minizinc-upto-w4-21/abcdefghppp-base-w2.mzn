% for batch mode
% export PATH=/opt/local/bin:/opt/local/sbin:/Applications/MiniZincIDE-2.0.13.app/Contents/Resources:$PATH  
% cd to-your-dir
% time mzn-g12fd -a abcdefghppp-base-w2.mzn abcdefghppp-base-w2-16.dzn
% time minizinc -a abcdefghppp-base-w2.mzn abcdefghppp-base-w2-16.dzn

% note to run this: under Configuration, you have to select user-defined option under minizinc IDE to enable more than one solutions

% allow 0 but not in the first position i.e. a, c, e, g (and p) cannot be 0
% I think 0 should be allowed anywhere if it is a paper game moving around digits
% but all other solutions assume that

int: base;  % from the data file

int: lo = 0;
int: hi = base -1;

var lo..hi: a;
var lo..hi: b;
var lo..hi: c;
var lo..hi: d;
var lo..hi: e;
var lo..hi: f;
var lo..hi: g;
var lo..hi: h;
var lo..hi: p;

include "alldifferent.mzn";
constraint all_different([a, b, c, d, e, f, g, h, p]);
constraint a != 0;
constraint c != 0;
constraint e != 0;
constraint g != 0;
constraint (a*base + b) - (c*base + d) = (e*base+f);
constraint (e*base + f)  + (g*base + h) = (p*base*base + p*base + p);

solve :: int_search([a, b, c, d, e, f, g, h, p], input_order, indomain, complete)
                  satisfy;

output [show(a),"~", 
            show(b), 
            " - ",      
            show(c), "~",
            show(d), 
            " = ",     
            show(e), "~",
            show(f),
            " + ", 
            show(g), "~",
            show(h), 
            "= ", 
            show(p),"~",show(p),"~",show(p)]

