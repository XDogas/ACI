.data
lista: .word 0:10 # static int lista[SIZE]
str1: .asciiz "\nIntroduza um numero: "
str2: .asciiz "\nConteudo do array:\n"

.text
.globl main
main:
	la $t0, lista # $t0 = &array = p
	addiu $t1, $t0, 40 # $t1 = &array + 40 = *pUltimo
	
forloopread:
	bne $t0, $t1, flbodyread
	j endloopread
	
flbodyread:
	# print_str("\nIntroduza um numero:");
	la $a0, str1
	ori $v0, $0, 4
	syscall
	
	# read_int()
	ori $v0, $0, 5
	syscall
	
	# lista[i] = read_int()
	sw $v0, 0($t0)
	
	addiu $t0, $t0, 4 # p++
	
	j forloopread
	
endloopread:
	# int houveTroca, i, aux
	or $t2, $0, $0 # $t2 = houveTroca (boolean -> 0 or 1)
	or $t3, $0, $0 # $t3 = aux
	la $t0, lista # $t0 = &lista
	
doloop:
	or $t2, $0, $0 # houveTroca = FALSE
	or $t1, $0, $0 # $t1 = i = 0
	j forloop
	
forloop:
	blt $t1, 9, flbody # i < SIZE-1
	j dowhileend
	
flbody:
	sll $t4, $t1, 2 # $t4 = 4 * i
	add $t5, $t0, $t4 # $t5 = &lista[i]
	addi $t6, $t5, 4 # $t6 = &lista[i + 1]
	
	lw $t7, 0($t5) # $t7 = lista[i]
	lw $t8, 0($t6) # $t8 = lista[i + 1]
	
	bgt $t7, $t8, ifbody # if (lista[i] > lista[i+1])
	j flend	

ifbody:
	or $t3, $0, $t7 # aux = lista[i]
	sw $t8, 0($t5) # lista[i] = lista[i+1]
	sw $t3, 0($t6) # lista[i+1] = aux
	ori $t2, $0, 1 # houveTroca = TRUE
	j flend
	
flend:
	addi $t1, $t1, 1
	j forloop
	
dowhileend:
	beq $t2, 1, doloop # while (houveTroca==TRUE)
	
	# Start printing
	
	# *p = lista; ($t0)
	# int i;  ($t1)
	
	la $t0, lista # p = lista
	
	# print_str("\nConteudo do array:\n");
	la $a0, str2
	ori $v0, $0, 4
	syscall
	
	move $t1, $0 # i = 0
	
	j flprint
	
flprint:
	blt $t1, 40, flprintbody # i < SIZE * 4
	j endloop
	
flprintbody:
	# print_int10( lista[i] )
	ori $v0, $0, 1
	addu $t2, $t0, $t1 # $t2 = lista[i]
	lw $a0, 0($t2)
	syscall
	
	# print_str("-")
	ori $v0, $0, 11
	ori $a0, $0, 45
	syscall
	
	addi $t1, $t1, 4 # i++ 
	
	j flprint
	
endloop:
	jr $ra