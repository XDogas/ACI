# y = 2x - 8
# x = $t0
# y = $t1
# O registo $v0 é usado para identificar a system call
# Os registos $a0 a $a3 são usados para transferir valores (argumentos) para a system call
# O system call pode usar $v0 para devolver um valor
	 	.data
decimal_line:	.asciiz "Decimal: "
hexaDec_line:	.asciiz "Hexadecimal: "
decUns_line:	.asciiz "Decimal Unsigned: "
new_line:	.asciiz "\n"
		.text
	 	.globl main
main: 		ori $v0,$0,5	# a system call read_int() é identificada com o número 5
		syscall		# chamada ao syscall "read_int()"
		or  $t0,$0,$v0	# $t0 = $v0 = valor lido do teclado (valor de x pretendido)
		ori $t2,$0,8	# $t2 = 8
		add $t1,$t0,$t0	# $t1 = $t0 + $t0 = x + x = 2x
		sub $t1,$t1,$t2	# $t1 = $t1 + $t2 = y = 2x - 8 ($t1 tem o valor calculado de y)
		
		ori $v0,$0,4	# a system call print_string() é identificada com o número 4
		la  $a0,decimal_line# $a0 = string
		syscall		# chamada ao syscall "print_string()"
		or  $a0,$0,$t1	# $a0 = y (copia o registo $t1 para o registo $a0)
		ori $v0,$0,1	# a system call print_int10() é identificada com o número 1
		syscall		# chamada ao syscall "print_int10()"
		
		ori $v0,$0,4	# a system call print_string() é identificada com o número 4
		la  $a0,new_line# $a0 = string
		syscall		# chamada ao syscall "print_string()"
		
		ori $v0,$0,4	# a system call print_string() é identificada com o número 4
		la  $a0,hexaDec_line# $a0 = string
		syscall		# chamada ao syscall "print_string()"
		or  $a0,$0,$t1	# $a0 = y (copia o registo $t1 para o registo $a0)
		ori $v0,$0,34	# a system call print_int16() é identificada com o número 1
		syscall		# chamada ao syscall "print_int16()"
		
		ori $v0,$0,4	# a system call print_string() é identificada com o número 4
		la  $a0,new_line# $a0 = string
		syscall		# chamada ao syscall "print_string()"
		
		ori $v0,$0,4	# a system call print_string() é identificada com o número 4
		la  $a0,decUns_line# $a0 = string
		syscall		# chamada ao syscall "print_string()"
		or  $a0,$0,$t1	# $a0 = y (copia o registo $t1 para o registo $a0)
		ori $v0,$0,36	# a system call print_intu10() é identificada com o número 1
		syscall		# chamada ao syscall "print_intu10()"
		 		
		jr  $ra		# fim do programa 
