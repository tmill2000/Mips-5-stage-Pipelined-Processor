.data

.text 
addi $2, $0, 1
jal label1
addi $1, $1, 1
bne $1, $2, label2


label1: 
addi $1, $0, 1 
jr $ra

label2:
addi $2, $0, 1
beq $1, $2, label3
addi $3, $0, 10

label3:
addi $3, $0, 10
jal exit


exit: 
halt 

