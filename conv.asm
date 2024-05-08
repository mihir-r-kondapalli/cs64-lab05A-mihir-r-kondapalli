# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.
input: 
	.word -72 13 -68 27 94 -49 8 37
filter: 
	.word -63 27 44
output: 
	.word 0 0 0 0 0 0
output_length:
	.word 6
ack: .asciiz "\n"
space: .asciiz " "


.text
conv:
	# load addresses into t0, t1, t2
    # input, filter and output respectively
	move $t0 $a0       # input
    move $t1 $a1       # filter
    move $t2 $a2       # output

    li $t3, 3          # filt_size
    li $t4, 0          # counter (i)
    li $t5, 0          # counter (j)

    j loop1


    loop1:
        bge $t4, $a3, return
        j loop2

    loop2:
        bge $t5, $t3, incr_i
        add $t6, $t4, $t5      # i+j
        sll $t6, $t6, 2
        add $t7, $t6, $t0      
        lw $t7, 0($t7)         # input[i+j]

        sll $t8, $t5, 2
        add $t8, $t8, $t1      
        lw $t8, 0($t8)         # filt[j]

        mult $t7, $t8
        mflo $t9               # input[i+j]*filt[j]

        lw $s1, 0($t2)
        add $s1, $t9, $s1
        sw $s1, 0($t2)

        j incr_j


    incr_i:
        addiu $t4, 1
        addiu $t2, 4
        li $t5, 0
        j loop1

    incr_j:
        addiu $t5, 1
        j loop2

    return:
        li $s0, 0
        jr $ra


main:
    la $a0 input
    la $a1 filter
    la $a2 output
    #Result length
    lw $a3 output_length
    jal conv

    #Loop for printing result
    la $t0 output
    lw $t3 output_length
    sll $t3 $t3 2
    li $t1 0
    print_loop:
        add $t2 $t0 $t1
        lw $a0 0($t2)
        li $v0 1
        syscall
        la $a0 space
        li $v0 4
        syscall
        add $t1 4
        bne $t1 $t3 print_loop
    j exit

exit:
    la $a0 ack
    li $v0 4
    syscall
	li $v0 10 
	syscall

