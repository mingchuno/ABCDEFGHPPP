% for batch mode
% export PATH=/opt/local/bin:/opt/local/sbin:/Applications/MiniZincIDE-2.0.13.app/Contents/Resources:$PATH  
% cd to-your-dir
% time mzn-g12fd -a abcdefghppp-base-w2.mzn abcdefghppp-base-w2-16.dzn
% time minizinc -a abcdefghppp-base-w2.mzn abcdefghppp-base-w2-16.dzn

% note to run this: under Configuration, you have to select user-defined option under minizinc IDE to enable more than one solutions but for commands use -a is ok

% allow 0 but not in the first position i.e. a, e, i, m (and p) cannot be 0
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
var lo..hi: i;
var lo..hi: j;
var lo..hi: k;
var lo..hi: l;
var lo..hi: m;
var lo..hi: n;
var lo..hi: o;
var lo..hi: p;
var lo..hi: q;


include "alldifferent.mzn";
constraint all_different([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q]);
constraint a  != 0 ; 
constraint e  != 0;
constraint i   != 0;
constraint m != 0;
constraint (a*base*base*base + b*base*base + c*base +d) 
              - (e*base*base*base + f*base*base + g*base +h)
              = (i*base*base*base + j*base*base + k*base +l);
constraint (i*base*base*base + j*base*base + k*base +l)
             + (m*base*base*base + n*base*base + o*base +p)
             = q*(base*base*base*base+base*base*base + base*base + base + 1);

solve :: int_search([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q], input_order, indomain, complete)
                  satisfy;

output [show(a),"~", 
            show(b),"~", 
            show(c),"~", 
            show(d), 
            " - ",      
            show(e), "~",
            show(f), "~",
            show(g), "~",
            show(h), 
            " = ",     
            show(i), "~",
            show(j), "~",
            show(k), "~",
            show(l),
            " + ", 
            show(m), "~",
            show(n), "~",
            show(o), "~",
            show(p), 
            "= ", 
            show(q),"~",show(q),"~",show(q),"~",show(q),"~",show(q)]

