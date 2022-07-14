
.data


.text

addi $1, $0, 1 #load 1 into register
addi $2, $0, 1 #an extra cycle occurs between the first add and bne so the data is forwarded from the second location
bne $1, $0, exit #forward the data to beq to make the condition true 1 != 0

wrong:
addi $2, $0, 10 #instruction is written if branch fails when forwarding doesn't occur

exit:
halt
