# ​void reverse(char String[], int length){
# int counter = 0;
# int len = length -1 ;
# for( int counter = 0; counter < len; counter++){
# 	String temp = S[counter];
# 	String temp2 = S[len];
# 	S[leng-1] = temp ;
# 	S[counter] = temp2;
#	if (len == counter)
#		break;
#	len--;
# 
#
#}
.data
	S: .asciiz "H ello"
	length: .word 6
	msg1 :	.asciiz "S = "

.text
	la $a0, S
	lw $a1, length
	jal reverse
	
	li $v0, 4
	la $a0, msg1 #print string
	syscall
	li $v0, 4
	la $a0, S #print string
	syscall
		
	li $v0, 10
	syscall
		
	reverse:
    		addiu $sp, $sp, -24      # adjust stack for 6 items
		sw $t5, 20($sp)
		sw $t0, 16($sp) 
		sw $t1, 12($sp)
		sw $t2, 8($sp) 
		sw $t3, 4($sp)
		sw $t4, 0($sp) 
		
		add $t0, $zero, $zero	#t0 counter, start 0
		addi $t1, $a1, -1  #t1 = length of the string -1, 
		Loop:
		beq $t0, $t1, endloop	#if  counter == length  -> end
		add $t4, $t0, $a0 #t4 addr of S
		lbu $t2, 0($t4)	# t2= S[counter]
		add $t5, $t1, $a0
		lbu $t3, 0($t5) # t6 = S[length-1]
		sb $t2, 0($t5)	# S[length-1] = S[counter]
		sb $t3, 0($t4) # S[counter] = t6
		addi $t0, $t0, 1 #counter++
		beq $t0, $t1, endloop # in case of even length
		addi $t1, $t1, -1 #length--
		j Loop
		endloop:
		lw $t4, 0($sp)
		lw $t3, 4($sp)
		lw $t2, 8($sp) 
		lw $t1, 12($sp)
		lw $t0, 16($sp)
		lw $t5, 20($sp)
    		addiu $sp, $sp, 24       # delete 6 items from stack

		jr $ra
		

		
	

