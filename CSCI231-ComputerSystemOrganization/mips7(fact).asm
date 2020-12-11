.data
	asknumb: 	.asciiz "Enter x: "
	cos:		.asciiz "cos ( "
	e:		.asciiz ") = "
	nl: 		.asciiz "\n"
.text
move $a0, $zero
addi $a0, $a0, 3
jal fact
li $v0, 1
move $a0, $v1
syscall
li $v0, 10
syscall

fact:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
slti $t0, $a0, 1
beq $t0, $zero, factelse
addi $v1, $zero, 1
addi $sp, $sp, 8
jr $ra
factelse: addi $a0, $a0, -1
jal fact
lw $a0, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp,8
mul $v1, $a0, $v1
jr $ra
