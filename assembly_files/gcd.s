	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
i:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
	push	%rbp
	mov		%rsp, %rbp
	sub		$16, %rsp
	movq	$732, %rax
	movq	%rax, a
	movq	$2684, %rdx
	movq	%rdx, b
L000:
	movq	a, %rax
	movq	b, %rdx
	cmpq	%rdx, %rax
	je	L001
	movq	a, %rax
	movq	b, %rdx
	cmpq	%rax, %rdx
	jg	L002
	movq	a, %rax
	movq	b, %rdx
	subq	%rdx, %rax
	movq	%rax, a
	jmp	L003
L002:
	movq	b, %rax
	movq	a, %rdx
	subq	%rdx, %rax
	movq	%rax, b
L003:
	jmp	L000
L001:
	movq	a, %rax
	movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
    leave
	ret
