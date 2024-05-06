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

	li t0, 0x5B	#kod ASCII [
	li t1, 0x5D	#kod ASCII ]
	li t2, 0x2A	#kod ASCII *

	la t3, buf 	#adres do pierwszego znaku z bufora
	la t4, result 	#adres do pierwszej znaku z wyniku
	li a2, 0	#adres do pierwszego [
	li a3, 0 	#adres do pierwszego ]
	li a4, 0	#dlugosc wyniku


search_left_bracket:
	lb t5, (t3)
	beqz t5, end_loop
	beq t5, t0, found_left_bracket
	addi t3, t3, 1
	b search_left_bracket

found_left_bracket:
	mv a2, t3

search_right_bracket:
	lb t5, (t3)
	beqz t5, end_loop
	beq t5, t1, found_right_bracket
	addi t3, t3, 1
	b search_right_bracket

found_right_bracket:
	mv a3, t3


end_loop:
	beqz a2, end
	beqz a3, end
	la t0, buf
	lb t1, (t0)

replace_loop:
	ble t0, a2, next
	bge t0, a3, next
	sb t2, (t0)

next:
	addi t0, t0, 1
	addi a4, a4, 1
	lb t1, (t0)
	bnez t1, replace_loop

end:
	ret

final:
	li a7, 4
	la a0, buf
	ecall

	addi a4, a4, -1

	li a7, 1
	add a0, a4, zero
	ecall


	li a7, 10
	ecall
