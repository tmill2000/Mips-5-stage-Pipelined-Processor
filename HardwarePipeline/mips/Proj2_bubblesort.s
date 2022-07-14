.data
.align 2
arr: .word 3, 1, 6, 2, 0, 546, 10
.text

main:
lui $a0, 0x1001
addi $a1, $0, 7

Sort:
andi $t0, 0 #set t0 to 0

Cond:

addi $t0, $t0, 1 #inc
slt $1, $5, $8
bne $1, $0, Exit
add $t3, $a1, $0
Loop:
slt $1, $8, $11
beq $1, $0, Cond
addi $t3, $t3, -1
sll $t4, $t3, 2
addi $t2, $t4, -4
add $t4, $t4, $a0
add $t2, $t2, $a0
lw $t5, 0($t4)
lw $t6, 0($t2)

#swaps
slt $1, $14, $13
bne $1, $0, Loop
sw $t5, 0($t2)
sw $t6, 0($t4)
j Loop
Exit:
halt

