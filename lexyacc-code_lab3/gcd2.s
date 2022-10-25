	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
        pushq   $732
        popq    a
        pushq   $2684
        popq    b
L000:
        movq    a, %rax
        movq    b, %rdx
        cmpq    %rdx, %rax
        je      L001
        movq    a, %rax
        movq    b, %rdx
        cmpq    %rax, %rdx
        jg      L002
        movq    a, %rax
        movq    b, %rdx
        subq    %rdx, %rax
        movq    %rax, a
        movq    %rdx, b
        jmp     L003
L002:
        movq    b, %rax
        movq    a, %rdx
        subq    %rdx, %rax
        movq    %rax, b
        movq    %rdx, a
L003:
        jmp     L000
L001:
        pushq   a
        popq    %rdx
        pushq   %rbp
        leaq    format(%rip), %rdi
        movq    %rdx, %rsi
        xorq    %rax,  %rax
        call    printf
        popq    %rbp
        ret
