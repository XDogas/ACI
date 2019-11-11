# Mapa de registos:
# str:	$a0 -> $s0 (argumento é passado em $a0)
# p1:	$s1 (registo callee-saved)
# p2:	$s2 (registo callee-saved)

	.data
str:	.asciiz	"ITED - orievA ed edadisrevinU"			# static char str[]="ITED - orievA ed edadisrevinU";
s_res:	.asciiz	"A string inversa é: "
	.eqv	print_string,4
	.text
	.globl	main
	
main:	addiu	$sp,$sp,-4	# stack space
	sw	$ra,0($sp)	# save $ra
	
	li	$v0,print_string
	la	$a0,s_res
	syscall							# print_string(	"A string inversa é: ");
	
	la	$a0,str
	jal	strrev
	
	move	$a0,$v0
	li	$v0,print_string
	syscall							# print_string( strrev(str) );
	
	lw	$ra,0($sp)	# return $ra
	addiu	$sp,$sp,4	# return $sp
	
	li	$v0,0						# return 0;
	jr	$ra
	
strrev:	addiu	$sp,$sp,-16	# reserva espaço na stack
	sw	$ra,0($sp)	# guarda endereço de retorno
	sw	$s0,4($sp)	# guarda valor do registo $s0
	sw	$s1,8($sp)	# guarda valor do registo $s1
	sw	$s2,12($sp)	# guarda valor do registo $s2
		
	move	$s0,$a0		# registo "callee-saved"
	move	$s1,$a0						# char *p1 = str;
	move	$s2,$a0						# char *p2 = str;
	
while1:	lb	$t0,0($s2)	# $t0 = *p2
	beqz	$t0,endw1					# while(*p2 != '\0') {
	addiu	$s2,$s2,1					#	p2++;
	j	while1						# }
	
endw1:	addiu	$s2,$s2,-1					# p2--;

while2:	bge	$s1,$s2,endw2					# while( p1 < p2 ) {
	move	$a0,$s1		# $a0 = p1
	move	$a1,$s2		# $a1 = p2
	jal	exchange					#	exchange(p1, p2);
	addiu	$s1,$s1,1					#	p1++;
	addiu	$s2,$s2,-1					#	p2--;
	j	while2						# }
	
endw2:	move	$v0,$s0						# return str;

	lw	$ra,0($sp)	# repõe endereço de retorno
	lw	$s0,4($sp)	# repõe o valor do registo $s0
	lw	$s1,8($sp)	# repõe o valor do registo $s1
	lw	$s2,12($sp)	# repõe o valor do registo $s2
	addiu	$sp,$sp,16	# liberta espaço da stack
	
	jr	$ra		# termina a sub-rotina
	
exchange:							# void exchange(char *c1, char *c2) {
	lb	$t0,0($a0)					#	char aux = *c1;
	lb	$t1,0($a1)
	sb	$t1,0($a0)					#	*c1 = *c2;
	sb	$t0,0($a1)					#	*c2 = aux;
	
	jr	$ra						# }
	
