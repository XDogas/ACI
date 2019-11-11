	.include "tp5_macros.h"
	.eqv SIZE,10
	.eqv LAST_IDX,9	#SIZE-1
	
	.data
#lista .word , -4, 3, 5, 124, -15, 87, 9, 27, 15
lista 	.word 0:SIZE
s_intr_1_nbr:
	.asciiz "Introduza um número: "
s_arr_cnt:
	.asciiz "\nConteúdo do b-sorted array:\n"

	.globl main
	.text
main:
# use a fixed array for debug the sorting algorithm
# -------- READ
# for (i=0; i < SIZE; i++)
	li $t0,0	# i=0
	la $t1,lista	# $t1 = lista
for1:	bge $t0,SIZE,bubble_sort
	#
	print_str( s_intr_1_nbr )
	read_int		# $v0 = decimal value
	sll $t2,$t0,2		# $t3 = int_byte_idx = 4*i
	addu $t2,$t1,$t2	# $t2 = &lista[i]
	sw $v0,0($t2)		# lista[i] = read_int();
	#
	addi $t0,$t0,1		# i++
	b for1
# -------------------------
# $t0 = i; $t1 = lista; $t2 = byte_i;
# $t5 = houveTroca
# $v0 = value_i; # $v1 = value_i_next;
bubble_sort:
# do {
	li $t5,0	# houveTroca = 0
	# for (i=0; i < SIZE; i++)
	li $t0,0	# i=0
	la $t1,lista	# $t1 = lista
for2:
	bge $t0,LAST_IDX.for2_end	# if (i >= SIZE-1)
	#
	sll $t2,$t0,2		# $t1 = 4*i
	addu $t2,$t1,$t2	# $t2 = &lista[i]
	lw $v0,0($t2)		# $v0 = list[i]
	lw $v1,4($t2)		# $v1 = list[i+1]
	
	# if (lista[i]>lista[i+1])
	ble $v0,$v1,if_end
	sw $v1,0($t2)		# lista[i] = lista[i+1];
	lw $v0,4($t2)		# lista[i+1] = aux;
	li $t5,1		# houveTroca = TRUE;
if_end:
	addi $t0,$t0,1		# i++
	b for2
	# end for2
for2_end:
	# while (houveTroca == TRUE);
	bnez $t5, bubble_sort
# -----> PRINT
do_print: # omitted for space
# <----- PRINT
exit: done
# ---------------------------
# Conteúdo do b-sorted array:
# -15,-4,3,5,8,9,15,27,87,124,
	
	
	
	
	
	
	