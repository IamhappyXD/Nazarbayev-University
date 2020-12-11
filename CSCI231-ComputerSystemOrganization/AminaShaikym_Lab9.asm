
.data
array: .space 1024
arraysize : .word 250
upd : .word 16843009
...
.text
#Number of blocks: 8
#Cache block size: 128
#YOUR METRIC SCORE: 33.03
#The reasons for my optimization
#In Assembly code:
#In the configurations of cache parameters:
main:
	la $s0, array	#array arr[]
	move $s1, $zero	# s1 arraysize		
	addi $s1, $s1, 125
	move $t1, $zero	# i = 0
	li $s3, 16843009
	jal initialize
	move $t1, $zero	# i = 0
	la $s0, array	#array arr[]
	jal update

	li $v0, 10
	syscall 
initialize:
	beq $s1, $t1, endinit
	addi $s0, $s0, 1
	sb $zero, 0($s0) 
	addi $t1, $t1,1 
	j initialize
endinit :
	jr $ra
	
update:
	beq $s1, $t1, endupdate
	addi $s0, $s0, 1
	lb $t2, 0($s0)
	move $t2, $s3
	sb $t2, 0($s0) 
	addi $t1, $t1,1 
	j update
endupdate :
	jr $ra
