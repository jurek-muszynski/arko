	.data
prompt: .asciz "Enter string:\n"
buf:	.space 100
text:	.space 100

	.text
	.globl main
main:
	li a7, 4
	la a0, prompt
	ecall

	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	li t0, '1'	
	li t1, '9'	
	la t2, buf		# first pointer	i
	
	la t3, buf		# second pointer i+1
	lb t4, (t3)
	la t5, text		# result pointer
	beqz t4, end
	sb t4, (t5)
	addi t5, t5, 1
	addi t3, t3, 1
	lb t4, (t2)	
	
loop:
	blt t4, t0, not_digit	
	bgt t4, t1, not_digit
		
digit:				# incrementing pointers t2, t3 without t5
	addi t3, t3, 1
	addi t2, t2, 1
	lb t4, (t2)
	bnez t4, loop
	b end
		
not_digit:			# incrementing all pointers and storing the next char into the result buf
	lb t4, (t3)
	sb t4, (t5)
	addi t5, t5, 1
	addi t2, t2, 1
	addi t3, t3, 1
	lb t4, (t2)
	bnez t4, loop

end:
	li a7, 4
	la a0, text
	ecall
	
	li a7, 10
	ecall
