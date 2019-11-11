# Não está correto

# Mapa de registos
# p:		$t0
# pUltimo:	$t1
# houve_troca:	$t2
# i		$t3
# lista[i]:	$t7
# lista[i+1]:	$t8
	
	.data
	.eqv	SIZE,10
str1:	.asciiz	"\nIntroduza um numero: "
str2:	.asciiz "\nConteudo do array ordenado:\n"
str3:	.asciiz "; "
	.align	2
lista: 	.word 	0:SIZE # static int lista[SIZE]
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
	.eqv	TRUE,1
	.eqv	FALSE,0
	.text
	.globl	main
	
main:	la	$t0,lista		# $t0 = &lista = p
	addiu	$t1,$t0,40		# $t1 = &lista + 40 = pUltimo
	
reader:	beq	$t0,$t1,end_reader	# while(i < SIZE) {

	li	$v0,print_string
	la	$a0,str1
	syscall				#	print_string("\nIntroduza um numero: ");
	
	li	$v0,read_int
	syscall				#	$v0 = read_int();
	
	sw	$v0,0($t0)		#	lista[i] = read_int()
	
	addi	$t0,$t0,4		#	p++;
	j	reader			# }
	
end_reader:
	la	$t0,lista		# $t0 = &lista
	
do:	li	$t2,FALSE		# houveTroca = FALSE;
	li	$t3,0			# $t3 = i = 0	
	li	$t4,SIZE		# $t4 = SIZE
	sub	$t4,$t4,1		# $t4 = SIZE - 1
	
while:	bge	$t3,$t4,end_do		# while(i < SIZE - 1) {
	sll	$t4,$t3,2		#	$t4 = i * 4
	addu	$t5,$t0,$t4		#	$t5 = &lista[i]
	addi	$t6,$t5,4		#	$t6 = &lista[i + 1]
	lw	$t7,0($t5)		#	$t7 = lista[i]
	lw	$t8,0($t6)		#	$t8 = lista[i + 1]
	ble	$t7,$t8,end_if		#	if (lista[i] > lista[i+1]) {
	or	$t9,$0,$t7		#		tmp = lista[i];
	sw	$t8,0($t5)		#		lista[i] = lista[i+1];
	sw	$t9,0($t6)		#		lista[i+1] = tmp;
	li	$t2,TRUE		#		houve_troca = TRUE;
					# 	}
end_if:	addi	$t3,$t3,1		#	i++;
	j	while
	
end_do:
	beq	$t2,TRUE,do		# } while (houveTroca==TRUE)
	li	$v0,print_string
	la	$a0,str2
	syscall				# print_string("\nConteudo do array ordenado:\n");
	li	$t3,0			# i = 0;
	li	$t4,SIZE		# $t4 = SIZE
	sll	$t4,$t4,2		# $t4 = SIZE * 4
print_while:
	ble	$t3,$t4,exit	# while(i < SIZE * 4) {
	li	$v0,print_int10
	addu	$t7,$t0,$t3		#	$t2 = lista[i]
	lw	$a0,0($t7)
	syscall				#	print_int10(lista[i]);	
	li	$v0,print_string
	la	$a0,str3
	syscall				#	print_string("; ")
	addi	$t3,$t3,4		#	i++ 
	j	print_while		# }
	
exit:	jr	$ra			# termina o programa