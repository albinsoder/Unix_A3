	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
i:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
	movq	$0, %rax
	fact
	movq	$1, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$1, %rdx
	fact
	movq	$1, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$2, %rdx
	fact
	movq	$2, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$3, %rdx
	fact
	movq	$6, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$4, %rdx
	fact
	movq	$24, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$5, %rdx
	fact
	movq	$120, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$6, %rdx
	fact
	movq	$720, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$7, %rdx
	fact
	movq	$5040, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$8, %rdx
	fact
	movq	$40320, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$9, %rdx
	fact
	movq	$362880, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$10, %rdx
	fact
	movq	$3628800, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	movq	$11, %rdx
	fact
	movq	$39916800, %rdx
	subq		movq	%rax, %rdx
	leaq	format(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	ret
