	.data
prompt: .asciz "Enter string:\n"
buf:	.space 100

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
	
	li a2, 3 		# divisor
	li t0, 'a'	
	li t1, 'z'	
	li t2, 0		# lowercase chars count
	
	la t3, buf
	lb t4, (t3)
	beqz t4, end
loop:
	blt t4, t0, next	
	bgt t4, t1, next	# if not lowercase, branch to next 
	addi t2, t2, 1		
	rem a5, t2, a2		
	bnez a5, next		# if lower count % 3 !== 0, branch to next

every_third:
	addi t4, t4, -0x20	# toUpper()
	
next:			
	sb t4, (t3)
	addi t3, t3, 1
	lb t4, (t3)
	bnez t4, loop
end:
	
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
