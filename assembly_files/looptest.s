	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
i:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
	movq	$100, %rax
	movq	%rax, i
L000:
	movq	i, %rax
	movq	$0, %rdx
	cmpq	%rax, %rdx
	je	L001
	movq	i, %rdx
	movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	i, %rax
	movq	$1, %rdx
	subq	%rdx, %rax
	movq	%rax, i
	jmp	L000
L001:
    leave
	ret
