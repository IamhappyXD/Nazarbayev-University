.data
.text 

li $a0, 0
li $a1, 0
lw $a2, RED
jal set_pixel_color
li $a0, 2
li $a1, 0
lw $a2, RED
jal set_pixel_color
li $a0, 6
li $a1, 0
lw $a2, GREEN
jal set_pixel_color
li $v0, 10
syscall


addi $a0, $a0, 18
jal sqrt
li $v0, 2
  	mov.s $f12, $f0   # Move result  to register $f12
 	syscall		
 	li $v0, 10	#finish and exit
	syscall
sqrt:
	mtc1 $a0, $f4		#f4 = number
	cvt.s.w $f4, $f4	#convert to single
	mtc1 $zero, $f5		#f5 = temp
	cvt.s.w $f5, $f5	#convert to single 
	addi $t0, $t0, 2
	mtc1 $t0, $f7		#f7 = 2
	cvt.s.w $f7, $f7	#convert to single 
	div.s $f6, $f4, $f7	# f6 = sqrt
	sqrtloop:
	#slt $t1, $f6, $f5	#sqrt != temp
	#beq $f6, $f5, return
	c.eq.s $f6, $f5
	bc1t return
	mov.s $f5, $f6 	#temp = sqrt
	div.s $f8, $f4, $f5	#numb/temp
	add.s $f8, $f8, $f5	#numb/temp +temp
	div.s $f6, $f8, $f7	#sqrt = f8/2 
	j sqrtloop
	return:
	mov.s $f0, $f6
	jr $ra
	

