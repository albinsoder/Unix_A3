    .data
    a:      .quad 0
    b:      .quad 0
    c:      .quad 0
    d:      .quad 0
    e:      .quad 0
    f:      .quad 0
    g:      .quad 0
    h:      .quad 0
    i:      .quad 0
    j:      .quad 0
    k:      .quad 0
    l:      .quad 0
    m:      .quad 0
    n:      .quad 0
    o:      .quad 0
    p:      .quad 0
    q:      .quad 0
    r:      .quad 0
    s:      .quad 0
    t:      .quad 0
    u:      .quad 0
    v:      .quad 0
    w:      .quad 0
    x:      .quad 0
    y:      .quad 0
    z:      .quad 0

result: .ascii "%d\n"  
	.text
	.global	main
main:
    pushq   %rbx
	pushq	$0
	popq	a
	pushq	$4
	popq	s
	pushq	$2
	popq	d
	pushq	a
	pushq	$0
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	jne	L000
	pushq	a
	pushq	$2
	popq	%r10
	popq	%r11
	addq	%r10,%r11
	pushq	%r11
	pushq	$1
	popq	%r10
	popq	%r11
	subq	%r10,%r11
	pushq	%r11
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
L000:
	pushq	a
	pushq	$0
	popq	%r10
	popq	%r11
	cmpq	%r10, %r11
	je	L001
	pushq	$0
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
	jmp	L002
L001:
	pushq	a
	pushq	$2
	popq	%r10
	popq	%r11
	addq	%r10,%r11
	pushq	%r11
	pushq	$2
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
L002:
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
	pushq	a
	popq	%rdx
	pushq	%rbp
	leaq	result(%rip), %rdi
	movq	%rdx, %rsi
	xorq	%rax,  %rax
	call	printf
	popq	%rbp
    popq    $ 0
    exit
