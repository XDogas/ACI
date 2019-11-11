# Mapa de registos
# res:		$v0
# s:		$a0
# *s:		$t0
# digit:	$t1
# Sub-rotina terminal: não devem ser usados registos $sx

	.data
str:	.asciiz	"2016 e 2020 sao anos bissextos"	#static char str[]="2016 e 2020 sao anos bissextos";
s_res:	.asciiz	"Resultado: "
	.eqv	print_string,4
	.eqv	print_int10,1
	.text
	.globl	main
	
main:	addiu	$sp,$sp,-4	# stack space
	sw	$ra,0($sp)	# save $ra
	
	li	$v0,print_string
	la	$a0,s_res
	syscall						# print_string("Resultado: ");
	
	la	$a0,str
	jal	atoi
	
	move	$a0,$v0
	li	$v0,print_int10
	syscall						# print_int10( atoi(str) );
	
	lw	$ra,0($sp)	# return $ra
	addiu	$sp,$sp,4	# return $sp
	
	li	$v0,0					# return 0
	jr	$ra
	
atoi:	li	$v0,0					# res = 0;
	li	$t1,0					# digit = 0;

while:	lb	$t0,0($a0)
	blt	$t0,'0',not_digit			# while( (*s >= '0') && 
	bgt	$t0,'9',not_digit			#			(*s <= '9') ) {
	sub	$t1,$t0,'0'				#	digit = *s - '0';
	addiu	$a0,$a0,1				#	s++;
	mul	$v0,$v0,10				#	res = res * 10;
	add	$v0,$v0,$t1				#	res = res * 10 + digit;
	j	while					# }
	
not_digit:
	jr	$ra