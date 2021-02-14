;******************************************************************************;
;Program name: "rectangePerimeter".  This program reads the length and width of
;a rectangle through the standard input device.  It then calculates the
;perimeter and average side length of said rectangle, and outputs the result to
;the standard output device.  The perimeter is returned.
;Copyright (C) 2021 Sean Javiya.                                                                           *
;                                                                                                                           *
;This file is part of the software rectangePerimeter                                                                   *
;rectangePerimeter is free software: you can redistribute it and/or modify it
;under the terms of the GNU General Public License version 3 as published by the
;Free Software Foundation.                                                                    *
;rectangePerimeter is distributed in the hope that it will be useful, but
;WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;details.  A copy of the GNU General Public License v3 is available here:
;<https:;www.gnu.org/licenses/>.                            *
;******************************************************************************;


;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;Author information
;  Author name: Sean Javiya
;  Author email: seanjaviya@csu.fullerton.edu
;
;Program information
;  Program name: rectangePerimeter
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2021-Feb-1
;  Date of last update: 2021-Feb-13
;  Date of reorganization of comments: 2021-Feb-13
;  Files in this program: rectangle.cpp, perimeter.asm
;  Status: Finished.
;  The program was tested extensively with no errors in Ubuntu 20.04
;
;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble:        nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;

extern printf
extern scanf
global calculatePerimeter

segment .data
input_float db "%lf", 0
perim db "The perimeter is %8.15lf", 10, 0
avg db "The length of the average side is %8.15lf", 10, 0
goodbye db "I hope you enjoyed your rectangle.", 10, "The assembly program will send the perimeter to the main function.", 10, 0
height_prompt db "Enter the height:   ", 0
length_prompt db "Enter the length:   ", 0
segment .bss

segment .text
calculatePerimeter:
;preserve the registers onto the stack
push rbp
mov  rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

;ask for the height
push qword 0
mov rax, 0
mov rdi, height_prompt           ;"Enter the height:   ", 0
call printf
pop rax

;read in the height
push qword 0
push qword 0
mov rax, 0
mov rsi, rsp
mov rdi, input_float             ;"%lf", 0
call scanf
pop rax
pop rax

;move the height value into a preserved register, and compute 2x the height
movsd xmm15, xmm0               ;xmm15 holds the height value
movsd xmm14, xmm15
addsd xmm14, xmm15              ;xmm14 holds 2x height value

;ask for the length
push qword 0
mov rax, 0
mov rdi, length_prompt          ;"Enter the length:   ", 0
call printf
pop rax

;read in the length
push qword 0
push qword 0
mov rax, 0
mov rsi, rsp
mov rdi, input_float            ;"%lf", 0
call scanf
pop rax
pop rax

;move the length value into a preserved register, and compute 2x the length
movsd xmm13, xmm0               ;xmm13 holds the length value
movsd xmm12, xmm13
addsd xmm12, xmm13              ;xmm12 holds 2x the length value

;calculate the perimeter
addsd xmm14, xmm12              ;xmm14 holds the perimeter (2xlength + 2xheight)

;calculate the average
addsd xmm15, xmm13              ;xmm15 holds length + height
mov r15, 2
cvtsi2sd xmm11, r15             ;xmm11 holds "2.0"
divsd xmm15, xmm11              ;xmm15 holds the calculated average

;output the calculated perimeter
push qword 0
push qword 0
mov rax, 1
mov rdi, perim                  ;"The perimeter is %8.15lf", 10, 0
movsd xmm0, xmm14
call printf
pop rax
pop rax

;output the calculated average
push qword 0
push qword 0
mov rax, 1
mov rdi, avg                 ;"The length of the average side is %8.15lf", 10, 0
movsd xmm0, xmm15
call printf
pop rax
pop rax

push qword 0
push qword 0
mov rax, 0
mov rdi, goodbye                ;"I hope you enjoyed your rectangle.", 10,
    ;"The assembly program will send the perimeter to the main function.", 10, 0
call printf
pop rax
pop rax

;prepare the calculated perimeter to be returned.
movsd xmm0, xmm14               ;xmm0 holds the calculated perimeter

;restore the registers from the stack
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

;the calculated perimeter will be returned
ret
