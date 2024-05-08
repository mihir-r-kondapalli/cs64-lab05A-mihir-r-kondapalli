# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
# Data Area.  
# Note that while this is typically only for global immutable data, 
# for SPIM, this also includes mutable data.
# DO NOT MODIFY THIS SECTION
input: 
    .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
length:
    .word 15
fizz:   .asciiz "Fizz "
buzz:   .asciiz "Buzz "
fizzbuzz:   .asciiz "FizzBuzz "
space:  .asciiz " "
ack:    .asciiz "\n"


.text
FizzBuzz:
    move $t0 $a0       # array ptr
    move $t1 $a1       # length

    li $t2, 0         # counter

    li $t3, 5         # 5
    li $t4, 3         # 3

    loop:
        bge $t2, $t1, return
        lw $t6, 0($t0)           # a[i]
        div $t6, $t4
        mfhi $t5
        beq $t5, $zero, fi        # mod 3
        div $t6, $t3
        mfhi $t5
        beq $t5, $zero, bu        # mod 5

        move $a0, $t6
        li $v0, 1
        syscall

        la $a0, space
        li $v0, 4
        syscall

        j inc_mem

    fi:
        div $t6, $t3
        mfhi $t5
        beq $t5, $zero, fibu        # mod 5  (this time goes to fb)
        la $a0, fizz
        li $v0, 4
        syscall
        j inc_mem

    bu:
        la $a0, buzz
        li $v0, 4
        syscall
        j inc_mem

    fibu:
        la $a0, fizzbuzz
        li $v0, 4
        syscall
        j inc_mem

    inc_mem:
        addiu $t0, 4
        addiu $t2, 1
        j loop

    return:
        jr $ra


main:
    #DO NOT MODIFY THIS
    la $a0 input
    lw $a1 length
    jal FizzBuzz
    j exit

exit:
    la $a0 ack
    li $v0 4
    syscall
	li $v0 10 
	syscall

