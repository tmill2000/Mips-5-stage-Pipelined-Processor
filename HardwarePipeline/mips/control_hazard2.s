.data

.text


jal label1
halt

label1:
addi $3, $0, 10

jr $ra #This should execute and go straight to address in $ra
addi $2, $0, 1 #this should not execute 

