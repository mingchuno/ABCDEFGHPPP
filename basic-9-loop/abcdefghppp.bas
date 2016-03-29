' ABCDEFGHPPP problem 9-loop freebasic implementation
' Author: Samuel Ting
' Purpose: just another 9-loop implementaion in
'          other programming language
'
'**************************************
Cls
DIM a AS integer
DIM b AS integer
DIM c AS integer
DIM d AS integer
DIM e AS integer
DIM f AS integer
DIM g AS integer
DIM h AS integer
DIM p AS integer

for a = 1 to 9
for b = 0 to 9
for c = 1 to 9
for d = 0 to 9
for e = 1 to 9
for f = 0 to 9
for g = 1 to 9
for h = 0 to 9
for p = 1 to 9
if (a <> b) and (a <> c) and (a <> d) and (a <> e) and (a <> f) and (a <> g) and (a <> h) and (a <> p) and _
        (b <> c) and (b <> d) and (b <> e) and (b <> f) and (b <> g) and (b <> h) and (b <> p) and  _
        (c <> d) and (c <> e) and (c <> f) and (c <> g) and (c <> h) and (c <> p) and  _
        (d <> e) and (d <> f) and (d <> g) and (d <> h) and (d <> p) and  _
        (e <> f) and (e <> g) and (e <> h) and (e <> p) and  _
        (f <> g) and (f <> h) and (f <> p) and _
        (g <> h) and (g <> p) and _
        (h <> p) and _
        ((a*10+b) - (c*10+d) = (e*10+f)) and ((e+g)*10+f+h = p*111) _
then  
PRINT (str(a*10+b)+"-"+str(c*10+d)+"="+str(e*10+f)+", "+str(e*10+f)+"+"+str(g*10+h)+"="+str(p*111) ) 
end if

next p
next h
next g
next f
next e
next d
next c
next b
next a

End
