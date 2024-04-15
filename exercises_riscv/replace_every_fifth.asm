		.data
prompt: 	.asciz "Enter string:\n"
buf:		.space 100

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

	li t0, 'A'	#kod ASCII 0
	li t1, 'Z'	#kod ASCII 9
	li t2, 0x2A	#kod ASCII *
	
	la t3, buf 	#adres do pierwszego znaku z bufora
	li t4, 0 	#iloœæ wielkich liter
	li t5, 0	#dlugosc wyniku
	
	lb t6, (t3)
	beqz t6, end

search_upper_loop:
	blt t6, t0, next
	bgt t6, t1, next
	addi t4, t4, 1
	
next:
	addi t3, t3, 1
	lb t6, (t3)
	bnez t6, search_upper_loop

conditions:
	li t0, 2
	rem t1, t4, t0
	la a0, buf
	addi a0, a0, -1
	beqz t1, even_upper_count
	b odd_upper_count 

even_upper_count:
	addi a0, a0, 5
	lb t1, (a0)
	beqz t1, end
	sb t2, (a0)
	b even_upper_count
	
odd_upper_count:
	addi a0, a0, 5
	lb t1, (a0)
	beqz t1, end
	addi t1, t1, 2
	sb t1, (a0)
	b odd_upper_count
		
end:
	ret

final:
		
	li a7, 4
	la a0, buf
	ecall
	
	
	li a7, 1
	mv a0, t4
	ecall
	
		
	li a7, 10
	ecall
