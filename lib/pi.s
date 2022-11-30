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
	pushq	$1000001
	popq	n
	pushq	$100000000
	popq	s
	pushq	$0
	popq	a
	pushq	$0
	popq	t
L000:
	pushq	n
	pushq	$0
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	jle	L001
	pushq	t
	pushq	$0
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	jne	L002
	pushq	n
	popq	d
	pushq	$1
	popq	t
	jmp	L003
L002:
	pushq	n
	popq	%rdi
	negq	%rdi
	pushq	%rdi
	popq	d
	pushq	$0
	popq	t
L003:
	pushq	a
	pushq	s
	pushq	d
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
	pushq	$2
	popq	%r10
	popq	%r11
	subq	%r10,%r11
	pushq	%r11
	popq	n
	jmp	L000
L001:
	pushq	a
	pushq	s
	pushq	$100000
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
	pushq	$4
	popq	%r10
	popq	%r11
	imulq	%r10, %r11
	pushq	%r11
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
    popq    $ 0
    exit
