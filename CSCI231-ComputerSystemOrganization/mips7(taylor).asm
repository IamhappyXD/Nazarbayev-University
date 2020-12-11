.data 
askpower: .asciiz "Enter power : "
askbase : .asciiz "Enter base: "
nl      : .asciiz "\n"
.text

move $a1, $zero
addi $a1, $a1, 1

move $s0, $zero

move $s1, $zero
addi $s1, $s1, 7	#ending point

move $s2, $zero
addi $s2, $s2, 1	#starting point

move $s3, $zero
addi $s3, $s3, 2	#even or odd
jal taylor

li $v0, 1
move $a0, $v1	 #printing
syscall

li $v0, 10
syscall

taylor:
beq $s2, $s1, endtaylor
addi $s0, $s0, 2
div $s2, $s3
mfhi $t0	# iretation % 2 
addi $s2, $s2, 1
beq $t0, $zero, tayloradd 	#if iter % 2 == 0 -> addition else sub
sub $a1, $a1, $s0  # (1 - x2/2!) 
j taylor
tayloradd:
add $a1, $a1, $s0  # (1 - x2/2!) + x^4/ 
j taylor

endtaylor:
move $v1, $a1
jr $ra

