.data

.text

addi $1, $0, 1 
addi $2, $0, 1 

beq $1, $2, label1 #
add $3, $1, $2 #$3 should not be 2 at the end of this program 


label1:
halt 