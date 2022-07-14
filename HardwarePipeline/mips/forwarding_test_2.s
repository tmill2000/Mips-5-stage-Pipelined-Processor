
.data


.text

addi $1, $0, 1 #load 1 into register
add $2, $1, $1 #data is forwarded from Ex Mem stage and used to put into $2
add $3, $1, $1 #data is forwarded from WB stage


halt
