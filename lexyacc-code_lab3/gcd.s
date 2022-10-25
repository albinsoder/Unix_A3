	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
    pushq     $732
    popq      a
    pushq     $2684
    popq      b
    movq      a,    %rax 
    movq      b,    %rdx 
L000:
    cmpq     %rdx, %rax  
    je       L001
    cmpq     %rax, %rdx 
    jg       L002
    subq     %rdx, %rax 
    jmp      L003
L002:
    subq     %rax, %rdx
    jmp      L000
L003:
    jmp      L000
L001:
    pushq    %rbp
    leaq     format(%rip), %rdi
    movq     %rdx, %rsi
    xorq     %rax,  %rax
    call     printf
    popq     %rbp
    ret
    