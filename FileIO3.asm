; View codes for writing in /usr/include/asm-gen?/fcntl.h
section .data
msg: db "Welcome", 10, "Write a line for the file", 10
msglen equ $-msg
FileName: db "Test.txt", 0
section .bss
Input resb 100
section .text
global _start
_start:
    ;push rbp
    ;mov rbp, rsp
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msglen
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, Input
    mov rdx, 100
    syscall
    mov r14, rax  ; Input Length
    mov rax, 2
    mov rdi, FileName
    mov rsi, 2
    mov rdx, 0644o
    syscall
    mov r15, rax ; r15 - File Desc
    ;Check of opened
    cmp rax, 0
    jg Cont
    mov rdi, rax
    mov rax, 60
    syscall
Cont:
    mov rax, 1
    mov rdi, r15
    mov rsi, Input
    mov rdx, r14
    syscall
    ;Read Content
    mov rax, 0
    mov rdi, r15
    mov rsi, Input
    mov rdx, r14
    syscall
    ;StdOut from File
    mov rax, 1
    mov rdi, 1
    mov rsi, Input
    mov rdx, r14
    syscall

    mov rax, 3
    mov rsi, r15
    syscall

    ;mov rsp, rbp
    ;pop rbp
    mov rax, 60
    mov rdi, 0
    syscall

