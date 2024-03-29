		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100
lower: 	.space 100

	.text
	.globl main
main:
	jal remove
	b end
	
remove:
	
	li a7, 4
	la a0, prompt
	ecall

	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	li t0, 'a'
	li t1, 'z'
	
	la t2, buf 	#adres do pierwszego znaku z bufora
	la t3, lower 	#adres do pierwszej cyfry
	lb t4, (t2) 	#loadujesz pierwszy znak z bufora
	li t5, 0	#dlugosc zwracanego tekstu
	beqz t4, endloop
loop:
	blt t4, t0, next
	bgt t4, t1, next
	
lower_char: 
	sb t4, (t3)	#jezeli mala litera to loadujemy do kolejnego miejsca w t3
	addi t3, t3, 1
	addi t5, t5, 1

next:
	addi t2, t2, 1	
	lb t4, (t2)	#loadujesz kolejny znak z bufora
	bnez t4, loop	


endloop:
	ret

end:

	li a7, 4
	la a0, lower
	ecall
	
	
	li a7, 1
	add a0, t5, zero
	ecall
	

	
	li a7, 10
	ecall
