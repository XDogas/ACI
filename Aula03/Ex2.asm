# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
	.eqv 	print_string,4
	.eqv 	read_int,5
	.eqv	print_char,11
	.text
	.globl 	main
main:	li	$v0,print_string
	la	$a0,str1
	syscall				# print_string("Introduza um numero: ");
	li	$v0,read_int
	syscall
	move	$t0,$v0			# value = read_int();
	li	$v0,print_string
	la	$a0,str2
	syscall				# print_string("\nO valor em binário é: ");
	li	$t2,0			# i = 0
for:	bge	$t2,32,endfor		# while(i < 32) {
	rem	$t3,$t2,4							# alínea c)
	bne	$t3,0,endif2		#	if((i % 4) == 0)		#
	li	$v0,print_char							#
	li	$a0,' '								#
	syscall				#		print_char(' ');	#
endif2:	andi	$t1,$t0,0x80000000	#	bit = value & 0x80000000
	beq	$t1,$0,else		#		if(bit != 0)
	li	$v0,print_char
	li	$a0,'1'
	syscall				#			print_char('1');
	j	endif
else:	li	$v0,print_char		#		else
	li	$a0,'0'
	syscall				#			print_char('0');
endif:	sll	$t0,$t0,1		#		value = value << 1;
	addi	$t2,$t2,1		#		i++;
	j	for			# }
endfor:	jr	$ra			# fim do programa

	
	
	
	
	