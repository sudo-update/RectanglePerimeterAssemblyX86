// *****************************************************************************
// Program name: "rectangePerimeter".  This program reads the length and width
// of a rectangle through the standard input device.  It then calculates the
// perimeter and average side length of said rectangle, and outputs the result
// to the standard output device.  The perimeter is returned.
// Copyright (C) 2021 Sean Javiya.                                                                           *
//                                                                                                                            *
// This file is part of the software rectangePerimeter                                                                   *
// rectangePerimeter is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License version 3 as published by
// the Free Software Foundation.                                                                    *
// rectangePerimeter is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
// more details.  A copy of the GNU General Public License v3 is available here:
// <https:;www.gnu.org/licenses/>.                            *
// *****************************************************************************
//
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// Author information
//   Author name: Sean Javiya
//   Author email: seanjaviya@csu.fullerton.edu
//
// Program information
//   Program name: rectangePerimeter
//   Programming languages: One modules in C++ and one module in X86
//   Date program began: 2021-Feb-1
//   Date of last update: 2021-Feb-13
//   Date of reorganization of comments: 2021-Feb-13
//   Files in this program: rectangle.cpp, perimeter.asm
//   Status: Finished.
//   The program was tested extensively with no errors in Ubuntu 20.04
//
// This file
//   File name: rectangle.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile:
//   gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp
//   Link:
//   gcc -m64 -no-pie -o rectanglePerimeter.out rectangle.o perimeter.o -std=c17
//
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <stdint.h>

extern "C" double calculatePerimeter();

int main(int argc, char* argv[]) {
  double answer = 0.0;
  printf("Welcome to an assembly program by Sean Javiya.\n");
  answer = calculatePerimeter();
  printf("The main function received this number %lf and has decided to keep it.\n0 will be returned to the operating system.\nHave a nice day.\n",answer);
  return 0;
}
