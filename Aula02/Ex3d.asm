	.data
str1:	.asciiz "Introduza 2 numeros\n "
str2:	.asciiz "A soma dos dois numeros é: "
	.eqv	read_int,5
	.eqv	print_string,4
	.eqv	print_int10,1
	.text
	.globl main
main:	la  $a0,str1
	ori $v0,$0,print_string
	syscall				# print_string(str1);
	
	ori $v0,$0,read_int
	syscall				# valor lido é retornado em $v0
	or  $t0,$0,$v0			# $t0 = $v0(read_int) (1º valor lido guardado em $t0)
	
	ori $v0,$0,read_int
	syscall				# valor lido é retornado em $v0
	or  $t1,$0,$v0			# $t1 = $v0(read_int) (2º valor lido guardado em $t1)
	
	la  $a0,str2
	ori $v0,$0,print_string
	syscall				# print_string(str2);
	
	add $a0,$t0,$t1			# $a0 = $t0 + $t1	
	ori $v0,$0,print_int10
	syscall				# print_int10($a0);
	
	jr  $ra 			# fim do programa