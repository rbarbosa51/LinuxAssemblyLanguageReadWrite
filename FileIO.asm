%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, NL
    mov rdx, 1
    syscall
%endmacro
section .data
Welcome: db "Enter a text: "
WelcomeLen equ $-Welcome
NL: db 10
FileName: db "Testing.txt", 0  ;12
section .bss
Buffer resb 100
InputSize resq 1
FileDesc resq 1
section .text
global _start
_start:
    push rbp
    sub rsp, 8
    mov rbp, rsp
    print Welcome, WelcomeLen
    mov rax, 0
    mov rdi, 0
    mov rsi, Buffer
    mov rdx, 100
    syscall
    dec rax
    mov [InputSize], rax
    ;Open
    mov rax, 2
    mov rdi, FileName
    mov rsi, 1 ; Write + Create
    mov rdx, 0664o
    syscall
    mov [FileDesc], rax
    ;Write
    mov rax, 1
    mov rdi, [FileDesc]
    mov rsi, Buffer
    mov rdx, [InputSize]
    syscall
    mov rax, 1
    mov rdi, [FileDesc]
    mov rsi, NL
    mov rdx, 1
    syscall
    ;Close
    mov rax, 3
    mov rdi, [FileDesc]
    syscall

    
    mov rsp, rbp
    add rsp, 8
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall
