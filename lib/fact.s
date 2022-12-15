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
	pushq	a
	pushq	$0
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero000
	jmp	fact000
	pushq	$0
fact000:
	cmpq	$0, %r10
	je	print000
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact000
zero000:
	movq	$1, %r11
print000:
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
	pushq	$1
	popq	b
	pushq	b
	pushq	$1
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero001
	jmp	fact001
	pushq	$1
fact001:
	cmpq	$0, %r10
	je	print001
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact001
zero001:
	movq	$1, %r11
print001:
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
	pushq	$2
	popq	c
	pushq	c
	pushq	$2
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero002
	jmp	fact002
	pushq	$2
fact002:
	cmpq	$0, %r10
	je	print002
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact002
zero002:
	movq	$1, %r11
print002:
	pushq	%r11
	pushq	$2
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
	pushq	$3
	popq	d
	pushq	d
	pushq	$3
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero003
	jmp	fact003
	pushq	$3
fact003:
	cmpq	$0, %r10
	je	print003
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact003
zero003:
	movq	$1, %r11
print003:
	pushq	%r11
	pushq	$6
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
	pushq	$4
	popq	e
	pushq	e
	pushq	$4
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero004
	jmp	fact004
	pushq	$4
fact004:
	cmpq	$0, %r10
	je	print004
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact004
zero004:
	movq	$1, %r11
print004:
	pushq	%r11
	pushq	$24
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
	pushq	$5
	popq	f
	pushq	f
	pushq	$5
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero005
	jmp	fact005
	pushq	$5
fact005:
	cmpq	$0, %r10
	je	print005
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact005
zero005:
	movq	$1, %r11
print005:
	pushq	%r11
	pushq	$120
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
	pushq	$6
	popq	g
	pushq	g
	pushq	$6
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero006
	jmp	fact006
	pushq	$6
fact006:
	cmpq	$0, %r10
	je	print006
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact006
zero006:
	movq	$1, %r11
print006:
	pushq	%r11
	pushq	$720
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
	pushq	$7
	popq	h
	pushq	h
	pushq	$7
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero007
	jmp	fact007
	pushq	$7
fact007:
	cmpq	$0, %r10
	je	print007
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact007
zero007:
	movq	$1, %r11
print007:
	pushq	%r11
	pushq	$5040
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
	pushq	$8
	popq	i
	pushq	i
	pushq	$8
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero008
	jmp	fact008
	pushq	$8
fact008:
	cmpq	$0, %r10
	je	print008
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact008
zero008:
	movq	$1, %r11
print008:
	pushq	%r11
	pushq	$40320
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
	pushq	$9
	popq	j
	pushq	j
	pushq	$9
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero009
	jmp	fact009
	pushq	$9
fact009:
	cmpq	$0, %r10
	je	print009
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact009
zero009:
	movq	$1, %r11
print009:
	pushq	%r11
	pushq	$362880
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
	pushq	$10
	popq	k
	pushq	k
	pushq	$10
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero010
	jmp	fact010
	pushq	$10
fact010:
	cmpq	$0, %r10
	je	print010
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact010
zero010:
	movq	$1, %r11
print010:
	pushq	%r11
	pushq	$3628800
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
	pushq	$11
	popq	l
	pushq	l
	pushq	$11
	popq	%r10
	popq	%r11
	subq	$1, %r10
	cmpq	$0, %r10
	jle	zero011
	jmp	fact011
	pushq	$11
fact011:
	cmpq	$0, %r10
	je	print011
	imulq	%r10, %r11
	subq	$1, %r10
	jmp	fact011
zero011:
	movq	$1, %r11
print011:
	pushq	%r11
	pushq	$39916800
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
    popq    $ 0
    exit
