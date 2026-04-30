.global main
.extern sprintf

.section .data
prompt: .ascii "Number: "
result: .ascii "The double is: "
format: .string "%d\n"

.section .bss
.lcomm in, 32
.lcomm out, 64
.section .text
main:
    pushq   %rbp
    movq    %rsp, %rbp

    movq    $1, %rax
    movq    $1, %rdi
    leaq    prompt(%rip), %rsi
    movq    $8, %rdx
    syscall

    movq    $0, %rax
    movq    $0, %rdi
    leaq    in(%rip), %rsi
    movq    $32, %rdx
    syscall

    leaq    in(%rip), %rsi
    movq    $0, %rax
    movq    $0, %rcx

loop:
    movzbq  (%rsi), %rcx
    cmpb    $10, %cl
    je      math_func
    cmpb    $0, %cl
    je      math_func

    subb    $48, %cl
    imulq   $10, %rax
    addq    %rcx, %rax
    incq    %rsi
    jmp     loop

math_func:
    addq    %rax, %rax

    leaq    out(%rip), %rdi
    leaq    format(%rip), %rsi
    movq    %rax, %rdx
    movl    $0, %eax
    call    sprintf

    pushq   %rax
    movq    $1, %rax
    movq    $1, %rdi
    leaq    result(%rip), %rsi
    movq    $15, %rdx
    syscall

    popq    %rdx
    movq    $1, %rax
    movq    $1, %rdi
    leaq    out(%rip), %rsi
    syscall


    movq    $60, %rax
    movq    $0, %rdi
    syscall
