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
	
	li t0, 'A'	
	li t1, 'Z'	
	li t2, 0		# sequence flag 
	
	la t3, buf
	lb t4, (t3)
	la t5, text
	beqz t4, end
loop:
	blt t4, t0, not_upper	
	bgt t4, t1, not_upper	# if not uppercase, branch to not_upper 
	beqz t2, first_upper
	
upper:
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, loop
	beqz t4, end

first_upper:
	li t2, 1		# start the sequence by loading 1 into the register
	sb t4, (t5)
	addi t3, t3, 1
	addi t5, t5, 1
	lb t4, (t3)
	bnez t4, loop
	beqz t4, end
	
not_upper:			
	li t2, 0
	sb t4, (t5)
	addi t5, t5, 1
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, loop
	beqz t4, end
end:
	
	li a7, 4
	la a0, text
	ecall
	
	li a7, 10
	ecall
