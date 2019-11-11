# O argumento da função é passado em $a0
# O resultado é devolvido em $v0
# Sub-rotina terminal: não devem ser usados registos $sx

	.data
str:	.asciiz	"Arquitetura de Computadores I"	# static char str[]="Arquitetura de Computadores I";
s_len:	.asciiz	"O comprimento da string é: "
	.eqv	print_string,4
	.eqv	print_int10,1
	.text
	.globl	main
	
main:	addiu	$sp,$sp,-4	# stack space
	sw	$ra,0($sp)	# save $ra
	
	li	$v0,print_string
	la	$a0,s_len
	syscall						# print_string("O comprimento da string é: ");
	
	la	$a0,str
	jal	strlen
	
	move	$a0,$v0
	li	$v0,print_int10	
	syscall						# print_int10(strlen(str));
	
	lw	$ra,0($sp)	# return $ra
	addiu	$sp,$sp,4	# return $sp
	
	li	$v0,0					# return 0
	jr	$ra
	
strlen:	li	$v0,0					# len = 0;
	
while:	lb	$t0,0($a0)				# while(*s != '\0')
	beqz	$t0,endw				# {	
	addi	$v0,$v0,1				#	len++;
	addiu	$a0,$a0,1				#	*s++
	j	while					# }
	
endw:	jr	$ra		# return to caller
