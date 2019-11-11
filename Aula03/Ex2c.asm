# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
# $t4 = 4bitCounter
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
space: 	.asciiz " "
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
	
	li	$t2,0			# i = 0;
	li	$t4,1			# 4bitCounter = 1;
for:	beq	$t2,32,endfor		# while(i != 32) {
	
	andi	$t1,$t0,0x80000000	#	bit = value & 0x80000000;
	srl	$t1,$t1,31		#	bit = bit >> 31 = (value & 0x80000000) >> 31;
	
	li	$v0,print_char
	ori	$a0,$t1,48
	syscall				#	print_char();
	
shift:	sll	$t0,$t0,1		#	value = value << 1;
	
	beq	$t4,4,sp		#	if(4bitCounter == 4)
	j	addlp
	
sp:	la	$a0,space
	li	$v0,print_string
	syscall				#		print_string(" ");
	
	li	$t4,0			#		4bitCounter = 0;
	
addlp:	addi	$t2,$t2,1		#	i++;
	addi	$t4,$t4,1		#	4bitCounter++;
	j	for			#}
	
endfor:	jr	$ra			# fim do programa