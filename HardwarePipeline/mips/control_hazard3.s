.data 

.text

jal label1 #Should go straight to label1
addi $1, $0, 1 #This should not execute 


label1:
halt 