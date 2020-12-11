.data
	ask1stnumb: 	.asciiz "Enter 1st number: "
	ask2ndnumb: 	.asciiz "Enter 2nd number: "
	tryagain:	.asciiz "Invalid integer, Try again!!! "
	result:		.asciiz "Result: "
	
	nl: 		.asciiz "\n"
	
.text

main:	
	ask:
	move $s0, $zero
	
	li $v0, 4
	la $a0, ask1stnumb		#Ask 1st number
	syscall
	
	li $v0, 5
	syscall
	
	bne $s0, $zero, try
	
	move $s1, $v0		#if not overflow save number to s1

	li $v0, 4
	la $a0, ask2ndnumb		#Ask 2nd number
	syscall
	
	li $v0, 5
	syscall
	
	bne $s0, $zero, try
	
	move $s2, $v0		#if not overflow save number to s2
	
	add $s3, $s2, $s1
	bne $s0, $zero, try
	
	li $v0, 4
	la $a0, result		#print result
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 10
	syscall
	
try:
	li $v0, 4
	la $a0, tryagain		#try again
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	j ask
	
.ktext 0x80000180
mfc0 $k0, $14
addi $s0, $s0, 1
addi $k0, $k0, 4
addi $s0, $s0, 1
mtc0 $k0, $14
eret
