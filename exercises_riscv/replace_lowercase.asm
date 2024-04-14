		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100
result: 	.space 100

	.text
	.globl main
main:
	jal replace
	b final
	
replace:
	
	li a7, 4
	la a0, prompt
	ecall

	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	li t0, 'a'	#kod ASCII 0
	li t1, 'z'	#kod ASCII 9
	li t2, 0x2A	#kod ASCII *
	
	la t3, buf 	#adres do pierwszego znaku z bufora
	la t4, result 	#adres do pierwszego znaku z wyniku
	li t5, 0	#dlugosc wyniku
	
	lb t6, (t3)
	beqz t6, end

loop:
	blt t6, t0, next
	bgt t6, t1, next
	sb  t2, (t3)
	
next:
	addi t3, t3, 1
	addi a4, a4, 1
	lb t6, (t3)
	bnez t6, loop

end:
	ret

final:
		
	li a7, 4
	la a0, buf
	ecall
	
	addi a4, a4, -1
	
	li a7, 1
	mv a0, a4
	ecall
	
		
	li a7, 10
	ecall
