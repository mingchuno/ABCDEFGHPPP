This is the brutforce version of ABCDEFGHPPP problem written in Ada.
The program works when compliled by gfortran compiler.

compiler version:GNAT 4.8.5 20150623 (Red Hat 4.8.5-4) 

Prerequisite
-------------------

Have GNAT compiler installed in your computer.
gfortran compiler should be available at Linux, windows and Mac platform

Please refer to the documentation available.
https://www.gnu.org/software/gnat/

Centos
You can install via yum.
```
sudo yum install gcc-gnat    
```

Ubuntu(Debian) or other platforms
Please refer to Here
https://en.wikibooks.org/wiki/Ada_Programming/Installing

Usage
=========

Comiple the program
-------------------
```
gnat make ./abcdefghppp.adb
```
Run the program
-------------------
```
./abcdefghppp
```

Example output
------------------
```
85- 46= 39,  39- 72= 111
86- 54= 32,  32- 79= 111
90- 27= 63,  63- 48= 111
90- 63= 27,  27- 84= 111
95- 27= 68,  68- 43= 111
```
