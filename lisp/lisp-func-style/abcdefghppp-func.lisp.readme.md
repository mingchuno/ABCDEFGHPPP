### xnastudio better version of lisp

Unlike the lisp-9-loop version, this verson from xnastudio is a much better and really lisp like version.  The author of the lisp-9-loop (Dennis who wrote this readme.md) has made some cosmetic change and publish on behalf of xnastudio to avoid some primary 1 student come along and mistaken lisp is nothing but a fortan with a lot of (). :-)

To be honest, as usual for any lisp program, Dennis has a hard time understand how the tree being built.  Luckily for him, there is no MACRO.

In general, lisp has 3 trees to deal with.  The tree of macro code, which generate the tree of program code and then manipuate both these code trees plus a tree of data.  It is called God's programming lanugage for a reason.

Roughly the core of the processing is in the R-Search code list.  The first two sub-list is simply the ending condition of a branch, the next two skip the impossible branches (i.e. no 0 in the first digit and no 1).  The most important code sub-list is the last two branches which generate the answer list (if it met the conditinos) and further branches in two, well, branches.

Todo:

In general, lisp code is good in manipulate sympbols (tress of them).  For optimisation, I think xnastudio has exhausted the possibility.  

The last is not sure workable i.e. to change the data structure such as array with fixed data type.  Unlike C kind of language, lisp assume no data type and no size.  In other words, it has to check these data types and size handle.  This slow it down but also give it flexibility like there is no limit of number.  The Fixnum will change to Bignum automatically.

The strength is its weakness I am afraid.

=== cf with other 9-loop solution ===

   MAir-9loop    W10-i3-func MAir-func

10 18s           not run     0.002s     
16 1145s         <0.1s       0.130s
22 18839s (5+hr) not run     11s
28 :-)           8s          28s
34 :-(           35s         43s


