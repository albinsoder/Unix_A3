	.data
a:      .quad   0
b:      .quad   0
i:      .quad   0
s:      .quad   0
n:      .quad   0
result: .ascii "%d\n"  
	.text
	.global	main
main:
	movq	$1000000, %rax
	movq	%rax, n
	movq	$100000000, %rdx
	movq	%rdx, s
	movq	$0, %rax
	movq	%rax, a
L000:
	movq	n, %rax
	movq	$0, %rdx
	cmpq	%rax, %rdx
	je	L001
	movq	a, %rax
	movq	s, %rdx
	movq	n, %rax
	addq	%rdx, %rax
	movq	%rax, a
	movq	n, %rdx
	movq	$1, %rax
	subq	%rdx, %rax
	movq	%rax, n
	jmp	L000
L001:
	movq	a, %rax
	movq	s, %rdx
	movq	$1000, %rdx
	movq	%rax, %rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
    exit
