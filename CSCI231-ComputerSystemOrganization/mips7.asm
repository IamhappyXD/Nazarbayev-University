.data 
askpower: .asciiz "Enter power : "
askbase : .asciiz "Enter base: "
nl      : .asciiz "\n"
.text
	li $v0, 4
	la $a0, askbase	#scan ask numb
	syscall

	li $v0, 5
	syscall
	
	move $s0, $v0		#s1=base
	
	li $v0, 4
	la $a0, nl
	syscall
	
	li $v0, 4
	la $a0, askpower	#scan ask numb
	syscall

	li $v0, 5
	syscall
	
	move $s1, $v0		#s1=power
	
	move $a0,$s0
	move $a1, $s1	
	jal pow
	move $s2, $v0
	li $v0,1
	move $a0, $s2
	syscall
	jal Exit
pow:
	addi $sp, $sp,-12
	sw   $ra, 0($sp)
    	sw   $s0, 4($sp)
    	sw   $s1, 8($sp)
    	add $s0,$a0,$zero
    	add $s1,$a1,$zero
    	
	bne $s1,$zero, return1
	addi $v0, $zero,1
	j finish

return1:
	addi $a1, $a1,-1
	jal pow
	multu $s0, $v0
	mflo $v0
finish:
       lw   $ra, 0($sp)        
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        addi $sp, $sp, 12      
        jr $ra
	
Exit:
	li $v0, 10
	syscall
	
