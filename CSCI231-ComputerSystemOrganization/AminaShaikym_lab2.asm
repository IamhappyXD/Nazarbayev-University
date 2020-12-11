.data
x:	.word 20
Arr:	.word 21,20,51,83,20,20
length:	.word 6
y:	.word 5
index:	.word 0
msgl:	.asciiz "Arr = "
space:	.asciiz " "

.text

main:
	lw $s0, x	#s0 = 20, x
	lw $s1, length	#s1 = 6 length
	la $s2, Arr 	#s2, arr
	lw $s3, y
	lw $s4, index	
	#change x to y
	add $t0, $s4, $zero
	loop:
		sll $t1, $t0, 2
		beq $s1, $t0, finish_loop
		add $t1, $t1, $s2
		lw  $t2, 0($t1)
		beq $t2, $s0, change
		addi $t0, $t0, 1
		j loop
	change:
		sw $s3, 0($t1)
		j loop
		
		
	finish_loop:
		li $v0, 4
		la $a0, msgl	#print x =
		syscall
	add $t1, $s4, $zero
	
	print:
		sll $t0, $t1, 2
		add $t0, $t0, $s2
		lw  $t2, 0($t0)
		li $v0, 1
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		addi $t1, $t1, 1
		bne $s1, $t1, print
		
		li $v0, 10
		syscall
		
		
		
		
