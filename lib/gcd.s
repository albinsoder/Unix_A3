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
	pushq	$732
	popq	a
	pushq	$2684
	popq	b
L000:
	pushq	a
	pushq	b
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	je	L001
	pushq	a
	pushq	b
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	jle	L002
	pushq	a
	pushq	b
	popq	%r10
	popq	%r11
	subq	%r10,%r11
	pushq	%r11
	popq	a
	jmp	L003
L002:
	pushq	b
	pushq	a
	popq	%r10
	popq	%r11
	subq	%r10,%r11
	pushq	%r11
	popq	b
L003:
	jmp	L000
L001:
	pushq	a
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
	pushq	a
	pushq	b
	popq	%rax
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
    popq    $ 0
    exit
