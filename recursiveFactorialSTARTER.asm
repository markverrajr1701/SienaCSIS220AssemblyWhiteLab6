# Program File:  recursiveFactorialSTARTER.asm
#      Purpose:  Recursively find n! for n >= 1.
#                If n < 1, print an error message.
#       Author:  Mark Verra      
#      Version:  11/10/2021     
.text
main:
    # $s0 <-- n    
    la $a0, prompt1		
    jal utilPromptInt
    #YOUR CODE HERE
    add $s0, $v0, $zero 
    # if n > 0, find n! otherwise
    # print an error
    bgtz $s0, findNFactorial
    la $a0, error
    jal utilPrintString
    jal utilEndProgram
    
findNFactorial:
    # set the arguments before calling
    # the function
    #YOUR CODE HERE
    add $a0, $s0, $zero
    jal factorialRecursive		
    
    # Print the answer
    # $s1 <-- n!
    # YOUR CODE HERE
    add $s1, $v0, $zero
    la $a0, answer
    jal utilPrintString		
    add $a0, $zero, $s1
    jal utilPrintInt
    jal utilPrintNewLine
    
    # End the program
    jal utilEndProgram

########################################
#      Function: factorialRecursive
#       Purpose:  Recursively find n! 
#  Precondition:  n >= 1
#     Arguments:  $a0 <-- n
# Return values:  $v0 <-- n!
########################################
factorialRecursive:
    # push n, return address onto stack
    # YOUR CODE HERE		
    add $sp, $sp, -8
    sw $a0, 4($sp)
    sw $ra, 0($sp)
    # base case:
    # if n == 1, $v0 <-- 1!
    addiu $v0, $a0, 0
    seq $t0, $v0, 1
    bnez $t0, return # meaning n == 1
    
    # n > 1
    # Recursive step:  Move closer to the base case;
    # n = n - 1
    addi $a0, $a0, -1		
    jal factorialRecursive	

    # restore $a0 <-- n from the stack
    # compute "* n"; $v0 <-- $v0 * n
    # YOUR CODE HERE
    lw $a0, 4($sp)
    mul $v0, $v0, $a0
return:
    # n == 1 so end recursion by
    # restoring the return address
    # and return from the recursive call
    # i.e., pop the recursive calls
    lw $ra, 0($sp)            
    addi $sp, $sp, 8
    jr $ra		

.data
    answer:  .asciiz "\nAnswer: "
    error:   .asciiz "\nError:  n must be greater than or equal to 1\n"
    prompt1: .asciiz "Enter n: "

.include "utils.asm"
