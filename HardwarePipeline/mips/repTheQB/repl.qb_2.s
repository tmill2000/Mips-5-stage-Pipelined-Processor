.data
.text
.globl main
main:
    # Start Test
	repl.qb $1, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $2, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $3, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $4, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $5, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $6, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $7, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $8, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $9, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $10, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $11, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $12, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $13, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $14, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $15, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $16, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $17, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $18, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $19, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $20, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $21, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $22, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $23, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $24, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $25, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $26, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $27, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $28, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $29, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $30, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	repl.qb $31, 31 #check replicating all 1s for overflow or issues with all ones, rd should be 0xFFFFFFFF 
	# End Test

    # Exit program
	halt
    li $v0, 10
    syscall
