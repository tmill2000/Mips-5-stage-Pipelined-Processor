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
nop
nop
addi $t0, $t0, 1 #inc
nop
nop
nop
slt $1, $5, $8
nop
nop
nop
bne $1, $0, Exit
nop
nop
add $t3, $a1, $0
Loop:
nop
nop
nop
slt $1, $8, $11
nop
nop
nop
beq $1, $0, Cond
nop
nop
nop
addi $t3, $t3, -1
nop
nop
nop
sll $t4, $t3, 2
nop
nop
nop
addi $t2, $t4, -4
add $t4, $t4, $a0
nop
nop
add $t2, $t2, $a0
nop
nop
nop
lw $t5, 0($t4)
lw $t6, 0($t2)
nop
nop
nop

#swaps
slt $1, $14, $13
nop
nop
nop
bne $1, $0, Loop
nop
nop
sw $t5, 0($t2)
sw $t6, 0($t4)
j Loop
Exit:
nop
nop
halt

