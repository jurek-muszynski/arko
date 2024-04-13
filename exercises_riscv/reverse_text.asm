		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100
res: 		.space 100

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
	
	la t2, buf 	#adres do pierwszego znaku z bufora
	la t3, res	#adres do pierwszego znaku wyjœciowego bufora
	lb t4, (t2) 	#loadujesz pierwszy znak z bufora
	beqz t4, end
loop:
	blt t4, t0, not_upper
	bgt t4, t1, not_upper

first_upper_sq:
	sb t4, (t3)
	addi t3, t3, 1
	addi t2, t2, 1
	blt t4, t0, not_upper
	bgt t4, t1, not_upper
	
upper_sq:
	addi t2, t2, 1
	blt t4, t0, not_upper
	bgt t4, t1, not_upper
	bnez t4, upper_sq
	b end
	

not_upper:
	sb t4, (t3)
	addi t3, t3, 1
	addi t2, t2, 1
	lb t4, (t2)
	bnez t4, loop	



end:
	li a7, 4
	la a0, res
	ecall
	
	

	
	li a7, 10
	ecall
