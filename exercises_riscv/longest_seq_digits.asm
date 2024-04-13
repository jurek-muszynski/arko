	.data
prompt: .asciz "Enter string:\n"
buf:	.space 100
text:	.space 100
max: 	.space 100

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
	
	li t0, '0'	
	li t1, '9'	
	li t2, 0		# current length of a seq	
	li t3, 0		# max length of a seq
	la t4, buf		# pointer to the current seq
	li t5, 0		# pointer to the end of the max seq
	lb t6, (t4)		
	beqz t6, end
	
loop:
	blt t6, t0, not_digit	
	bgt t6, t1, not_digit
	
	addi t2, t2, 1
	
	bge t2, t3, update_max
	
	b next
	
update_max:
	mv t3, t2
	mv t5, t4
	
next:
	addi t4, t4, 1
	lb t6, (t4)
	bnez t6, loop
	b end
		
not_digit:				# incrementing pointers t2, t3 without t5
	li t2, 0
	addi t4, t4, 1
	lb t6, (t4)
	bnez t6, loop
	b end

end:
	
	li a7, 1
	sub t5, t5, t3
	addi t5, t5, 1			# beginning of the longest digit seq
	la t2, max
	lb t4, (t5)

end_loop:
	sb t4, (t2)
	addi t2, t2, 1
	addi t3, t3, -1
	addi t5, t5, 1
	lb t4, (t5)
	bnez t3, end_loop
	
	
print_max:

	li a7, 4
	la a0, max
	ecall


	li a7, 10
	ecall

	
