;Flags can be combined by adding
; 0 -> Read Only 1 -> Write Only  2-> ReadWrite 64-> Create
; 1024 -> Append  65536 -> Directory  
section .data
msg: db "Welcome, write something to the file", 10
len1 equ $-msg
FileName: db "Test.txt", 0
NL: db 10
section .bss
input resb 100
FileDesc resq 1
InputSize resq 1
section .text
global _start
_start:
    push rbp
    mov rbp, rsp
    xor eax, eax
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len1
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 100
    syscall
    ;Get Size of Input
    mov rax, -1
    mov rcx, -1
loop:
    inc rax
    inc rcx
    cmp byte [input + rax], 10
    jne loop
    mov [InputSize], rcx
    ;Open File
    mov rax, 2
    mov rdi, FileName
    mov rsi, 65  ; 1 - Write / 64 - Create
    ;mov rsi, 1025 ; 1 Write / 1024 Append
    mov rdx, 0664o ; Linux Permissions
    syscall
    mov qword [FileDesc], rax
    ;Write File
    mov rax, 1
    mov rdi, [FileDesc]
    mov rsi, input
    mov rdx, [InputSize]
    syscall
    ;Write NL to File
    mov rax, 1
    mov rdi, [FileDesc]
    mov rsi, NL
    mov rdx, 1
    syscall
    ;Close File
    mov rax, 3
    mov rdi, [FileDesc]
    syscall
    ;Re-open the file
    mov rax, 2
    mov rdi, [FileName]
    mov rsi, 0 ;Readonly
    syscall
    mov qword [FileDesc], rax
    ;Read into Variable
    mov rax, 0
    mov rdi, [FileDesc]
    mov rsi, input
    mov rdx, 100
    syscall
    ;write to STDOUT
    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, [InputSize]
    syscall
    ;close
    mov rax, 3
    mov rdi, [FileDesc]
    syscall
    ;Print NL
    mov rax, 1
    mov rdi, 1
    mov rsi, NL
    mov rdx, 1
    syscall

    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall



