# operandos : $t0 e $t1
# resultados : $t2(AND), $t3(OR), $t4(NOR) e $t5(XOR)
	.data
	.text
	.globl main
main:	ori $t0,$0,0xE543	# $t0 = operando1
	ori $t1,$0,0xA3E4 	# $t1 = operando2
	and $t2,$t0,$t1		# $t2 = $t0 & $t1 (and bit a bit)
	or  $t3,$t0,$t1	 	# $t3 = $t0 | $t1 (or bit a bit)
	nor $t4,$t0,$t1	 	# $t4 = !($t0 | $t1) (nor bit a bit)
	xor $t5,$t0,$t1		# $t5 = $t0 ^ $t1 (xor bit a bit)
	
	nor $t1,$0,$t0		# $t1 = ~$t0
	
	jr  $ra	 		# fim do programa
