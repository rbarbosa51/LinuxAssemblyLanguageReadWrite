section .data
WelMsg: db "Welcome to the app.", 10, "Write something to File.", 10
WelLen equ $-WelMsg
FileName: db "Testing.txt", 0
ErrOpen: db "Error Opening", 10 ;14
NL: db 10
section .bss
Input resb 100
InputLen resq 1
FileDesc resq 1
section .text
global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, WelMsg
    mov rdx, WelLen
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, Input
    mov rdx, 100
    syscall
    mov rax, -1
loop:
    inc rax
    cmp byte [Input + rax], 10
    jne loop
    mov [InputLen], rax
    ;Open File
    mov rax, 2
    mov rdi, FileName
    mov rsi, 1 ; 65 ->Create + Write    1-> Just Write
    mov rdx, 0644o
    syscall
    mov [FileDesc], rax
    ;Check if opened
    cmp rax, 0
    jl Exit
    jmp Resume    
Exit:
    mov rax, 1
    mov rdi, 1
    mov rsi, ErrOpen
    mov rdx, 14
    syscall
    mov rax, 60
    mov rdi, -1
    syscall
Resume:
    ;Write
    mov rax, 1
    mov rdi, [FileDesc]
    mov rsi, Input
    mov rdx, [InputLen]
    syscall
    mov rax, 1
    mov rdi, [FileDesc]
    mov rsi, NL
    mov rdx, 1
    syscall
    ;Read from the open File
    mov rbx, [InputLen]
    inc rbx
    mov rax, 0
    mov rdi, [FileDesc]
    mov rsi, Input
    mov rdx, rbx
    syscall
    ;Write to screen what was read from file
    mov rax, 1
    mov rdi, 1
    mov rsi, Input
    mov rdx, rbx
    syscall
    ;Close File
    mov rax, 3
    mov rdi, [FileDesc]
    syscall
    mov rax, 60
    mov rdi, 0
    syscall
