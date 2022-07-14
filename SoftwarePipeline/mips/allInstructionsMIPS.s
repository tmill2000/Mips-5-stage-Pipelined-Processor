.data
.text

addi $1, $0, 100
addi $2, $0, 50

nop
nop
nop

addu $3, $2, $1 
add $4, $2, $1
addiu $5, $1, 12

addi $0, $0, 0 

and $6, $3, $1 

andi $3, $2, 2

lui $7, 0x1001

nop
nop
nop

sw $1, 0($7)

nop
nop
nop

lw $2, 0($7)

nop
nop
nop

nor $6, $2, $3
xor $4, $2, $3
xori $7, $1, 3
nop
or $6, $2, $3


ori $4, $2, 1 
slt $3, $1, $2 
slti $5, $1, 4 
lui $9, 0x1001
sll $2, $6, 2 
sra $4, $1, 2

addi $0, $0, 0 
addi $0, $0, 0 

srl $7, $2, 2
sw $3, 0($9)
sub $5, $1, $2 
subu $6, $1, $2

addi $10, $0, 1
nop
nop
nop
bne $10, $11, label2
nop
nop
label2: 
nop
nop
j label3
nop
nop
nop
addi $1, $0, 10
label3: 
nop
nop
addi $1, $0, 5
addi $2, $0, 5
nop
nop
nop
beq $1, $2, label4
nop
nop
nop
label5:
nop
nop
nop
jr $31
nop
nop
sll $1, $1,  4
label4:
nop
nop
nop
jal label5
nop
nop
nop
nop
halt


