.data
Arr :   .word 21 20 51 83 20 20
length: .word 6
x:      .word 20
y:      .word 5
nl:     .asciiz "\n"
space:  .asciiz " "

.text
lw $s0,x
lw $s1,y
lw $a1, length
la $a2, Arr
jal print #print before changing
jal change #change
li $v0, 4
la $a0, nl
syscall
jal print #print after changing

li $v0, 10 #end
syscall
	change:
	lw $s0, x	#s0 = 20, x
	lw $s1, y
	add $t0, $zero, $zero	
	changeloop:
		sll $t1, $t0, 2
		beq $a1, $t0, finish_change
		add $t1, $t1, $a2
		lw  $t2, 0($t1)
		beq $t2, $s0, replace
		addi $t0, $t0, 1
		j changeloop
	replace:
		sw $s1, 0($t1)
		j changeloop
	finish_change:
		jr $ra

	
	print:
		add $t1, $zero, $zero # t1 index
		move $s0, $a2 
	printloop:
		sll $t0, $t1, 2
		add $t0, $t0, $s0
		lw  $t2, 0($t0)
		
		li $v0, 1
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		addi $t1, $t1, 1
		bne $a1, $t1, printloop #if index != length -> contonue
		jr $ra #else end
		
		