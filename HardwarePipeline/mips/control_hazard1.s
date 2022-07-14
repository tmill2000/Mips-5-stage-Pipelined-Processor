.data

.text

j label1 #the jump instruction should execute and go straight to label1
addi $1, $0, 1 #this instruction should not execute 

label1:
halt 
