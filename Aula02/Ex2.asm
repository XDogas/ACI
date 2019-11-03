	.data
	.text
	.globl main
	# b) e c)
	# operandos : $t0 e a constante Imm
	# resultados : $t2, $t3 e $t4
main: 	li  $t0,0x862A5C1B # instrução virtual (decomposta em duas instruções nativas)	comentar se não pretender esta alínea	
	sll $t2,$t0,4
	srl $t3,$t0,4
	sra $t4,$t0,4
	# d)
	# bin to gray
	# bin = $t0
	# gray = $t1
	ori $t0,$0,5	#$t0(bin) = 2(or other)	comentar se não pretender esta alínea
	srl $t1,$t0,1	# $t1 = $t0(bin) >> 1
	xor $t1,$t0,$t1 # $t1(gray) = $t0(bin) ^ $t1 = $t0(bin) ^ ($t0(bin) >> 1)
	# e)	Duvidas!!!!
	# gray to bin
	# gray = $t0
	# num = $t1
	# bin = $t2
	
	# penso que esta maneira está incorreta!!
	#ori $t0,$0,11 	# $t0(gray) = 2
	#move $t1,$t0	# $t1(num) = $t0(gray)
	#srl $t3,$t1,4	# $t3 = $t1 >> 4
	#xor $t1,$t1,$t3	# $t1 = $t1 ^ $t3 = $t1 ^ ($t1 >> 4)
	#srl $t3,$t1,2	# $t3 = $t1 >> 2
	#xor $t1,$t1,$t3	# $t1 = $t1 ^ $t3 = $t1 ^ ($t1 >> 2)
	#srl $t3,$t1,1	# $t3 = $t1 >> 1
	#xor $t1,$t1,$t3 # $t1 = $t1 ^ $t3 = $t1 ^ ($t1 >> 1)
	#move $t2,$t1	# $t2(bin) = $t1(num)
	
	# penso que esta maneira está correta!!
	ori $t0,$0,15 	# $t0(gray) = 2
	move $t1,$t0	# $t1(num) = $t0(gray)
	srl $t5,$t1,4	# $t5 = $t1 >> 4
	xor $t6,$t1,$t5	# $t6 = $t1 ^ $t5 = $t1 ^ ($t1 >> 4)
	srl $t5,$t6,2	# $t5 = $t6 >> 2
	xor $t7,$t6,$t5	# $t7 = $t6 ^ $t5 = $t6 ^ ($t6 >> 2)
	srl $t5,$t7,1	# $t5 = $t7 >> 1
	xor $t8,$t7,$t5 # $t8 = $t7 ^ $t5 = $t7 ^ ($t7 >> 1)
	move $t2,$t8	# $t2(bin) = $t8(num)
	
	jr $ra 			# fim do programa
