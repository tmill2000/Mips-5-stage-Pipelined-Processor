.data
.text
.globl main
main:
    # Start Test
	repl.qb $1, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $2, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $3, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $4, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $5, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $6, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $7, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $8, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $9, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $10, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $11, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $12, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $13, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $14, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $15, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $16, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $17, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $18, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $19, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $20, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $21, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $22, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $23, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $24, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $25, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $26, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $27, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $28, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $29, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $30, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	repl.qb $31, 16 #check that it can replicate 1000 0000 without any errors from it being negative (overflow, carrys), rd should be 0x80808080
	# End Test

    # Exit 
	halt
    li $v0, 10
    syscall
