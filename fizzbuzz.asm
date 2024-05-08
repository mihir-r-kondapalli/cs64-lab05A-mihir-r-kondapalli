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
    move $t0 $a0
    move $t1 $a1

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

