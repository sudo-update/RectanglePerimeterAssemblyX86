#!/bin/bash

#Program: Floating IO
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -g -F dwarf -l perimeter.lis -o perimeter.o perimeter.asm

echo "Compile rectangle.cpp using the gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp #-std=c17

echo "Link the object files using the gcc linker standard 2017"
gcc -m64 -no-pie -o average-sides.out rectangle.o perimeter.o -std=c17

echo "Run the program calculatePerimeter:"
./average-sides.out

echo "The script file will terminate"
