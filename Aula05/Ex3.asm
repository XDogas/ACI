# Não está correto

# Mapa de registos
# houve_troca:	$t4
# i:		$t5
# lista:	$t6
# lista + i:	$t7
# lista[i]:	$t8
# lista[i+1]:	$t9

	.data
	.eqv	SIZE,10
str1:	.asciiz	"\nIntroduza um numero: "
str2:	.asciiz "\nConteudo do array ordenado:\n"
str3:	.asciiz "; "
	.align	2
lista:	.space	40		# SIZE*4
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
	.eqv	TRUE,1
	.eqv	FALSE,0
	.text
	.globl	main
	
main:	li	$t5,0		# i = 0;
	li	$t4,FALSE	# houve_troca = FALSE;

	li	$v0,print_string
	la	$a0,str2
	syscall			# print_string("\nConteudo do array ordenado:\n");
	
reader:	bgeu 	$t5,SIZE,do	# while(i < SIZE) {
	li	$v0,print_string
	la	$a0,str1
	syscall			#	print_string(str1);
	li	$v0,read_int
	syscall			#	$v0 = read_int();
	la	$t6,lista	#	$t6 = lista (ou &lista[0])
	sll	$t7,$t5,2
	addu	$t7,$t7,$t6	#	$t7 = &lista[i]
	sw	$v0,0($t7)	#	lista[i] = read_int();
	addi	$t5,$t5,1	#	i++;
	j	reader		# }
	
do:	beq	$t4,TRUE,do		# do {
	li	$t4,FALSE	#	houve_troca = FALSE;
	li	$t5,0 		#	i = 0;
	li	$t8,SIZE	#	($t8 = SIZE)
	sub	$t8,$t8,1	#	($t8 = SIZE - 1)
	
while:	bge	$t5,$t8,do	#	while(i < SIZE-1) {
	sll	$t7,$t5,2	#		$t7 = i * 4
	addu	$t7,$t7,$t6	#		$t7 = &lista[i]
	lw	$t8,0($t7) 	#		$t8 = lista[i]
	lw	$t9,4($t7) 	#		$t9 = lista[i+1]
	ble	$t8,$t9,endif	#		if(lista[i] > lista[i+1]) {
	sw	$t8,4($t7)	#			lista[i+1] = $t8
	sw	$t9,0($t7)	#			lista[i] = $t9
	li	$t4,TRUE	#			houve_troca = TRUE;	
	
endif:				#		}
	addi	$t5,$t5,1	#		i++;
	j	printer		#	}
	
doloop:	beq	$t4,TRUE,do	# } while(houve_troca == TRUE);	

printer:
	li	$v0,print_int10
	move	$a0,$t9
	syscall			#	print_int10(lista[i]);
	li	$v0,print_string
	la	$a0,str3
	syscall			#	print_string("; ");
	j	while
	
exit:	jr	$ra		# termina o programa


	
	
	
	
	
	