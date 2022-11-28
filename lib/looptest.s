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
	movq	$100, %rax
	movq	%rax, i
L000:
	movq	i, %rax
	movq	$0, %rdx
	cmpq	%rax, %rdx
	je	L001
	movq	i, %rax
	movq	%rax, %rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
	movq	i, %rdx
	movq	$1, %rax
	subq	%rdx, %rax
	movq	%rax, i
	jmp	L000
L001:
    exit
