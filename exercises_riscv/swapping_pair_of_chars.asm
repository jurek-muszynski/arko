		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100
text: 	.space 100

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
	
	li t0, 'a'
	li t1, 'z'
	
	la t2, buf 	#adres do pierwszego znaku z wejsciowego bufora
	la t3, text 	#adres do pierwszego znaku z wyjsciowego bufora
	lb t4, (t2) 	#loadujesz pierwszy znak z bufora
	beqz t4, end

first_loop:
	addi t2, t2, 1
	lb t4, (t2)
	bnez t4, first_loop

second_loop:
	addi t2, t2, -1
	lb t4, (t2)
	sb t4, (t3)
	addi t3, t3, 1
	bnez t4, second_loop	

end:

	li a7, 4
	la a0, text
	ecall

	
	li a7, 10
	ecall
