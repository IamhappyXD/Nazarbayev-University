.data 
DISPLAY: .space 0x00100
DISPLAYWIDTH: .word 8
DISPLAYHEIGHT: .word 8
RED: .word 0x00ff0000
GREEN: .word 0x0000ff00

.text

main:

#a0 = x
#a1 =y
#color $a2
#f12 a
#f14 b
addi $t0, $t0, 30
addi $t1, $t1, 50
mtc1 $t0, $f12			#f12 = a 
cvt.s.w $f12,$f12
mtc1 $t1, $f14			#f14 = b
cvt.s.w $f14,$f14

jal drawellipse
#y=sqrt((1-x^2/a^2)*b^2
drawellipse:

cvt.w.s $f12, $f12		#f12 = x = a
mfc1 $s0,$f12 			#s0 = x = a
cvt.s.w $f12,$f12
sub $s1 , $zero, $s0		#s1 = -a
mul.s $f20, $f12, $f12		#f20 = a^2
mul.s $f21, $f14, $f14		#f21 = b^2
addi $t0, $zero, 1
mtc1 $t0, $f22			#f22 = 1
cvt.s.w $f22,$f22	  	#convert to single

	ellipseloop:
	beq $s0, $s1, finishloop #finish if x = -a
	mul $t0, $s0, $s0	#t0 -> x^2
	mtc1 $t0, $f4		#f4 = x^2
	cvt.s.w $f4, $f4	#convert to single
	div.s $f5, $f4, $f20	#f5 = x^2/a^2
	sub.s $f5, $f22, $f5	#f5 = (1-x^2/a^2)
	mul.s $f5, $f5, $f21	#f5 = (1-x^2/a^2)*b^2
	mov.s $f14, $f5		# f14 = (1-x^2/a^2)*b^2
	jal sqrt		#get sqrt
	cvt.w.s $f0, $f0
	mfc1 $s2,$f0		#s2 = y 
	
	move $a0, $s0
	move $a1, $s2  #s2 = y	
	lw $a2, RED
	jal set_pixel_color	#draw (x,y)
	addi $s0, $s0, -1	#x--
	j ellipseloop

finishloop:
	jr $ra
	li $v0, 10	#finish and exit
	syscall
sqrt:
	mov.s $f4, $f14
	mtc1 $zero, $f5		#f5 = temp
	cvt.s.w $f5, $f5	#convert to single 
	addi $t0, $t0, 2
	mtc1 $t0, $f7		#f7 = 2
	cvt.s.w $f7, $f7	#convert to single 
	div.s $f6, $f4, $f7	# f6 = sqrt
	sqrtloop:
	#slt $t1, $f6, $f5	#sqrt != temp
	#beq $f6, $f5, return
	c.le.s $f6, $f5
	bc1t return
	mov.s $f5, $f6 	#temp = sqrt
	div.s $f8, $f4, $f5	#numb/temp
	add.s $f8, $f8, $f5	#numb/temp +temp
	div.s $f6, $f8, $f7	#sqrt = f8/2 
	j sqrtloop
	return:
	mov.s $f0, $f6
	jr $ra
	

set_pixel_color:
lw $t0, DISPLAYWIDTH
mul $t0, $t0, $a1
add $t0, $t0, $a0
sll $t0, $t0, 2
la $t1, DISPLAY
add $t1, $t1, $t0
sw $a2, ($t1)
jr $ra
