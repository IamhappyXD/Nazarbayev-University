.data
Fib: .word 0, 1

.text

la $s0, Fib
# Fib[2]

addi $t0,$zero,1
sw $t0,8($s0)

# Fib[3]
lw $t1, 4($s0)
add $t0, $t1, $t0
sw $t0, 12($s0)
 
 # Fib[4]
lw $t1, 8($s0)
add $t0, $t1, $t0
sw $t0, 16($s0)

# Fib[5]
lw $t1, 12($s0)
add $t0, $t1, $t0
sw $t0, 20($s0)

# Fib[6]
lw $t1, 16($s0)
add $t0, $t1, $t0
sw $t0, 24($s0)