.data 
torad:	.float 0.01744444444
one:	.float 1.0
.text

addi $s0, $zero, 32

mtc1 $s0, $f12		#f12 = x
cvt.s.w $f12, $f12	#convert to single 
l.s $f13, torad
mul.s $f12, $f12, $f13

jal costaylor	#calculate cosx by taylor func taylor(x)
	#here
	li $v0, 2
  	mov.s $f12, $f20   # Move result  to register $f12
 	syscall		#print

	li $v0, 10	#finish and exit
	syscall
	
costaylor:
	mov.s $f7, $f12		#f7 = x
	l.s $f20, one 	#f20 = 1, f20 = cos(x) result

	addi $s7, $zero, 7	#ending point
	addi $s6, $zero, 1	#starting point s6
	addi $s5, $zero, 2	#even or odd s3
	move $a0, $zero		#for n
	addi $a0, $a0, 1
	jal taylorloop
	jr $ra #finish the costaylor

taylorloop:
	beq $s6, $s7, endtaylorloop	#if starting point == end point -> end loop

	addi $a0, $a0, 2	#for power	-> increment by 2, so n = 2,4,6,8,10,12
	beq $a0, 14, endtaylorloop
	move $a3, $a0		#a3 = n
	jal pow		#return base^power  recursively a1 = base a0 power

	mov.s $f6, $f3

	move $a3, $a0
	jal fact 	 #n!, (n =2,4,6...12) 

	mtc1 $v1, $f5	#move resutl of n! to $f5
	cvt.s.w $f5, $f5


	div.s $f7, $f6, $f5 # f7 = s6 / s5  x^n/n!

	div $t3, $s6, $s5
	mfhi $t0	# t0 = iretation % 2 
	addi $s6, $s6, 1	#iteration++
	beq $t0, $zero, tayloradd 	#if iter % 2 == 0 -> addition else sub
	sub.s $f20, $f20, $f7  # (1 - x2/2!) 
	j taylorloop
	tayloradd:
	add.s  $f20, $f20, $f7  # (1 - x2/2!) + x^4/ 
	j taylorloop
 	
endtaylorloop:
	li $v0, 2
  	mov.s $f12, $f20   # Move result  to register $f12
 	syscall		#print
 	
	la $a0,nl	#print nl
	li $v0, 4
	syscall
	j ask
		
pow:
	bne $a3, $zero, powrecursion	#if not 0, recursion 
	l.s $f3, one			#else return 0
	jr $ra
	powrecursion:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $a3, $a3, -1		#power--
	jal pow
	mul.s $f3, $f12, $f3		#pow(n-1)*pow(n)
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
        		
fact:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a3, 0($sp)
	slti $t0, $a3, 1
	beq $t0, $zero, factelse
	addi $v1, $zero, 1
	addi $sp, $sp, 8
	jr $ra
	factelse: 
	addi $a3, $a3, -1
	jal fact
	lw $a3, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp,8
	mul $v1, $a3, $v1
	jr $ra
