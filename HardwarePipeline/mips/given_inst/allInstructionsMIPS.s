.data
.text

addi $1, $0, 100
addi $2, $0, 50
addu $3, $2, $1 
add $4, $2, $1
addiu $5, $1, 12

addi $0, $0, 0 

and $6, $3, $1 

andi $3, $2, 2

lui $7, 0x1001
sw $1, 0($7)

lw $2, 0($7)

nor $6, $2, $3
xor $4, $2, $3
xori $7, $1, 3

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

bne $10, $11, label2

label2: 

j label3

addi $1, $0, 10
label3: 

addi $1, $0, 5
addi $2, $0, 5

beq $1, $2, label4

label5:

jr $31

sll $1, $1,  4
label4:

jal label5

halt


