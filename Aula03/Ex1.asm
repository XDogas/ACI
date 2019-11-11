# Mapa de registos:
# $t0 – soma
# $t1 – value
# $t2 - i
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos positivos é: "
	.eqv 	print_string,4
	.eqv 	read_int,5
	.eqv 	print_int10,1
	.text
	.globl 	main
main:	li	$t0,0			# soma = 0;
	li	$t2,0			# i = 0;
for:	bge	$t2,0x00000005,endfor	# while(i < 5) {
	li	$v0,print_string
	la	$a0,str1	
	syscall				#	print_string("Introduza um numero: ");
	li	$v0,read_int
	syscall				#	value=read_int();
	move	$t1,$v0
	ble	$t1,$0,else		#	if(value > 0)
	add	$t0,$t0,$t1		# 		soma += value;
	j	endif
else:	li	$v0,print_string		#	else
	la	$a0,str2
	syscall				#		print_string("Valor ignorado\n");
endif:	addi	$t2,$t2,1			#	i++;
	j	for			# }
endfor:	li	$v0,print_string
	la	$a0,str3
	syscall				# print_string("A soma dos positivos e': ");
	li	$v0,print_int10
	move	$a0,$t0
	syscall				# print_int10(soma);
	jr	$ra			# fim do programa



