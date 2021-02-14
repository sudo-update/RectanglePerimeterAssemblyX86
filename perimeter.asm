;******************************************************************************;
;Program name: "calculatePerimeter".  This program reads the length and width of
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
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;ask for the height
push qword 0
mov rax, 0
mov rdi, height_prompt
call printf
pop rax
;read in the height
push qword 0
push qword 0
mov rax, 0
mov rsi, rsp
mov rdi, input_float
call scanf
pop rax
pop rax

movsd xmm15, xmm0
movsd xmm14, xmm15
;mov r15, 2
;cvtsi2sd xmm13, r15
addsd xmm14, xmm15
;xmm14 holds 2x xmm15
;xmm15 holds the width

;ask for the length
push qword 0
mov rax, 0
mov rdi, length_prompt
call printf
pop rax
;read in the length
push qword 0
push qword 0
mov rax, 0
mov rsi, rsp
mov rdi, input_float
call scanf
pop rax
pop rax

movsd xmm13, xmm0
movsd xmm12, xmm13
mov r15, 2
cvtsi2sd xmm11, r15
addsd xmm12, xmm13
;xmm12 holds 2x xmm13
;xmm13 holds the width

addsd xmm14, xmm12
;xmm14 holds the perimeter (2x length + 2x width)
addsd xmm15, xmm13;15 holds l + w
;xmm11 holds "2.0"
divsd xmm15, xmm11
;xmm15 holds the average

push qword 0
push qword 0
mov rax, 1
mov rdi, perim
movsd xmm0, xmm14
call printf
pop rax
pop rax

push qword 0
push qword 0
mov rax, 1
mov rdi, avg
movsd xmm0, xmm15
call printf
pop rax
pop rax

push qword 0
push qword 0
mov rax, 0
mov rdi, goodbye
call printf
pop rax
pop rax



movsd xmm0, xmm14

;restore the registers from the stack
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp


ret
