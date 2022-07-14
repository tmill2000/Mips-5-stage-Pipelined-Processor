
.data


.text

addi $1, $0, 1 # $1 = 1
addi $2, $0, 2 # #2 = 2
add $1, $1, $2 # $1 = 3 #Forwarded from WB 
add $2, $1, $1 # $2 = 6 #Forwarded from EX MEM
sub $1,$2,$1   # $1 = 3 #Forwarded from  Ex Mem

addi $2, $0, 1 # $2 = 1
addi $3, $1, 1 # $3 = 4 #same process but for I type instructions
addi $2, $2, 1 #2 = 2
addi $3, $3, 0 # $3 = 4


addi $1, $0, 3 # $1 = 3
addi $2, $1, 1 # $2 = 4
addi $3, $2, 1 # $3 = 5 #more I type tests that forward rs and rt values
addi $4, $3, 1 # $4 = 6
addi $4, $4, 1 # $4 = 7
addi $4, $4, 1 # $4 = 8
add $4, $4, $1 # $4 = 11

# for 4 consecutive adds where the last is dependent on a value in the #first ($4 in this example, will have prev value 11 unless stall)
#This is fixed by our inverted clock signal
add $4, $4, $4 # $4 = 22
add $1, $1, $2 # $1 = 7
add $1, $1, $3 # $1 = 12
add $1, $1, $4 # $1 = 22 + 12 = 34

halt
