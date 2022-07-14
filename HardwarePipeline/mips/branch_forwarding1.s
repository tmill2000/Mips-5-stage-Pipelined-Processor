
.data


.text

addi $1, $0, 1 #load 1 into register
bne $1, $0, exit #forward the data to beq to make the condition true 1 != 0

wrong:
addi $2, $0, 10 #instruction is written if branch fails when forwarding doesn't occur

exit:
halt
