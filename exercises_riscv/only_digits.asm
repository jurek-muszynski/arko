	.data
prompt: .asciz "Enter string:\n"
buf:	.space 100
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
	
	li t0, '0'
	li t1, '9'
	
	la t3, buf
	la t5, text
	lb t4, (t3)
	beqz t4, end
loop:
	blt t4, t0, next
	bgt t4, t1, next
	sb t4, (t5)
	addi t5, t5, 1
next:
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, loop
end:
	
	li a7, 4
	la a0, text
	ecall
	
	li a7, 10
	ecall
