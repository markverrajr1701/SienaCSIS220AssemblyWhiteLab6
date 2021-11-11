# Program File:  recursiveMultiply.asm
#       Author:  Adapted with permission from Charles Kuhn,
#                Gettysburg College, PA
#      Purpose:  Get two integers from the user, m and n,
#                and compute m * n recursively.
#  Modified by:  Prof. White
#      Version:  Fall 2021
.text
main:
    # $s0 <-- m
    # $s1 <-- n
    # $s2 <-- m * n
    
    # Get the multiplicand
    la $a0, prompt1		
    jal utilPromptInt
    add $s0, $zero, $v0

    # Get the multiplier
    la $a0, prompt2		
    jal utilPromptInt
    add $s1, $zero, $v0 
       
    # Do multiplication
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    jal multiplyRecursive		
    
    # Print the answer
    add $s2, $zero, $v0
    la $a0, answer
    jal utilPrintString		
    add $a0, $zero, $s2
    jal utilPrintInt
    jal utilPrintNewLine
    
    # End the program
    jal utilEndProgram

########################################
# Function:  multiplyRecursive
# Purpose:  Recursively find m * n 
# Arguments:  $a0 <-- m; $a1 <-- n
# Return values:  $v0 <-- m * n
#
# E.g., if m = 3 and n = 4, 
# recursively computes 0 + 3 + 3 + 3 + 3
# and returns the result.
########################################
multiplyRecursive:
    # Although the value of $a0 will not
    # change in this example, this is a
    # recursive function, so it is both
    # caller and callee; the caller
    # saves and restores $a0 by convention; 
    # the callee saves and restores the
    # return address.    
    addi $sp, $sp -8
    sw $a0, 4($sp) # push "+ m"		
    sw $ra, 0($sp)		
    
    # base case:
    # if n == 0, start our
    # sum "0 +" ; $v0 <-- 0
    addiu $v0, $zero, 0
    beq $a1, $zero, return
    
    # n > 0
    # Head recursion
    # Recursive step:  Move closer to the base case;
    # n = n - 1
    addi $a1, $a1, -1		
    jal multiplyRecursive	

    # restore $a0 <-- m from the stack
    # compute "+ m"; $v0 <-- $v0 + m
    lw $a0, 4($sp)
    add $v0, $v0, $a0

return:
    # n == 0
    # Restore the return address
    # and return from the recursive call
    # i.e., pop the recursive calls
    lw $ra, 0($sp)              
    addi $sp, $sp, 8
    jr $ra		

.data
    answer:  .asciiz "\nAnswer: "
    prompt1: .asciiz "Enter the multiplicand: "
    prompt2: .asciiz "Enter the multiplier: "

.include "utils.asm"
