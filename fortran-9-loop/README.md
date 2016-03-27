This is the brutforce version of ABCDEFGHPPP problem written in Fortran C97.
The program works when compliled by gfortran compiler.

compiler version: GNU Fortran (GCC) 4.8.5 20150623 (Red Hat 4.8.5-4)

Prerequisite
-------------------

Have gfortran compiler installed in your computer.
gfortran compiler should be available at Linux, windows and Mac platform

Please refer to the documentation available.

https://gcc.gnu.org/wiki/GFortran

How do you get gFortran compiler?
Linux(Centos)
sudo yum install gcc-gfortran

Linux(Ubuntu)
https://gcc.gnu.org/wiki/GFortranBinaries#GNU.2BAC8-Linux-1
or
sudo apt-get install gfortran

Windows
https://gcc.gnu.org/wiki/GFortranBinaries#Windows

MacOS
https://gcc.gnu.org/wiki/GFortranBinaries#MacOS

Usage
=========

Comiple the program
-------------------
gfortran ./abcdefghppp.f95 -o abcdefghppp

Run the program
-------------------
./abcdefghppp


Example output
------------------
85-46=39, 39+72=111
86-54=32, 32+79=111
90-27=63, 63+48=111
90-63=27, 27+84=111
95-27=68, 68+43=111
