	.data
a:      .quad   0
b:      .quad   0
i:      .quad   0
s:      .quad   0
n:      .quad   0
t:      .quad   0
d:      .quad   0

result: .ascii "%d\n"  
	.text
	.global	main
main:
    pushq   %rbx
	pushq	$1000000
	popq	n
	pushq	$100000000
	popq	s
	pushq	$0
	popq	a
L000:
	pushq	n
	pushq	$0
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	jle	L001
	pushq	a
	pushq	s
	pushq	n
	popq	%rbx
	popq	%rax
	xorq	%rdx, %rdx
	idivq	%rbx
	pushq	%rax
	popq	%r10
	popq	%r11
	addq	%r10,%r11
	pushq	%r11
	popq	a
	pushq	n
	pushq	$1
	popq	%r10
	popq	%r11
	subq	%r10,%r11
	pushq	%r11
	popq	n
	jmp	L000
L001:
	pushq	a
	pushq	s
	pushq	$1000
	popq	%rbx
	popq	%rax
	xorq	%rdx, %rdx
	idivq	%rbx
	pushq	%rax
	popq	%rbx
	popq	%rax
	xorq	%rdx, %rdx
	idivq	%rbx
	pushq	%rax
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
    popq    $ 0
    exit
