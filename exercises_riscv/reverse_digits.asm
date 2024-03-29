		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100
digits: 	.space 100
rev_digits: 	.space 100

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
	la t3, digits 	#adres do pierwszej cyfry
	lb t4, (t2) 	#loadujesz pierwszy znak z bufora
	beqz t4, end
loop:
	blt t4, t0, next
	bgt t4, t1, next
digit: 
	sb t4, (t3)	#jezeli cyfra to loadujemy do kolejnego miejsca w t3
	addi t3, t3, 1
next:
	addi t2, t2, 1	
	lb t4, (t2)	#loadujesz kolejny znak z bufora
	bnez t4, loop	


second_loop:
	lb t4, (a0)	#loadujesz kolejny znak z bufora
	blt t4, t0, next_second_loop
	bgt t4, t1, next_second_loop


digit_second_loop:
	addi t3, t3, -1	#przechodzimy od ostatniej cyfry do pierwszej 
	lb t4, (t3)
	sb t4, (a0)
	


next_second_loop:
	addi a0, a0, 1
	bnez t4, second_loop


end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 4
	la a0, digits
	ecall
	
	
	li a7, 10
	ecall
