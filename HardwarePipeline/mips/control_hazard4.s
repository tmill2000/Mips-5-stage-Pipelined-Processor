.data 

.text 

addi $1, $0, 1 #load 1 into $1 
bne $1, $0, label1 #$1 should not equal $0, so go to label1 

addi $2, $0, 1 #should not execute 

label1:
halt 