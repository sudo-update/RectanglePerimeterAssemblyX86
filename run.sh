#!/bin/bash

#Program: Floating IO
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "Compile rectangle.cpp using the gcc compiler"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp #-std=c17

echo "Link the object files(rectangle and perimeter) using the gcc linker"
gcc -m64 -no-pie -o rectanglePerimeter.out rectangle.o perimeter.o -std=c17

echo "Run the program rectanglePerimeter:"
./rectanglePerimeter.out

echo "The script file will terminate"
