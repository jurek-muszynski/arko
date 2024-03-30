		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100
rev: 		.space 100

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
	
	la t2, buf 	#adres do pierwszego znaku z bufora
	la t3, rev 	#adres do pierwszego znaku niebêd¹cego cyfr¹
	lb t4, (t2) 	#loadujesz pierwszy znak z bufora
	beqz t4, end
loop:
	addi t2, t2,1
	lb t4, (t2)
	bnez t4, loop

reverse:
	addi t2, t2, -1
	lb t4, (t2)
	sb t4, (t3)
	addi t3, t3, 1
	bnez t4, reverse

end:
	li a7, 4
	la a0, rev
	ecall
	
	

	
	li a7, 10
	ecall
