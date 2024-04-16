	.data
prompt: .asciz "Enter string:\n"
buf:	.space 100
result: .space 100

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
	
	li a2, 'a'
	li a3, 'z'
	li a4, 'A'
	li a5, 'Z'
	
	li t2, 0x1	
	la t3, buf
	la t5, result
	
	lb t4, (t3)
	beqz t4, end
	
search:
	blt t4, a4, store	# if lower than 65 'A', store into the result buf	
	bgt t4, a3, store	# if greater than 122 'Z', store into the result buf
	bleu t4, a5, letter	# if greater than 65 'A' and lower than 90 'Z', branch to letter loop
	bgeu t4, a2, letter	# if greater than 97 'a' and lower than 122 'z', branch to letter loop
	b store			# if between 91 '[' and 96 '`', store into the result buf

letter:
	and t6, t4, t2		# check the lsb	
	beqz t6, store		# if even, branch to storing loop
	b end_search
	
store:
	sb t4, (t5)		# if even store into the result buf
	addi t5, t5, 1		# increment the result buf pointer
	
end_search:
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, search

end:
	li a7, 4
	la a0, result
	ecall
	
	li a7, 10
	ecall
