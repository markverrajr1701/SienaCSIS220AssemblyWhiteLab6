# Program File:  isPalindromRecursiveSTARTER.asm
# Author:        Mark Verra
# Version:       11/10/2021
# Purpose:       Recursively determine if the string 
#                in memory is a palindrome.
# Precondition:  The string in memory has at least one
#                character.
.text
main:
    # $s0 <-- the address of the first char in string
    # $s1 <-- the address of the last char in string
    # YOUR CODE HERE	
    la $s0, string
    lw $s1, stringLength
    mul $s1, $s1, 4
    add $s1, $s1, $s0
    # Determine isPalindrome
    # Set the arguments before 
    # calling the function
    # YOUR CODE HERE
    add $a0, $s0, $zero
    add $a1, $s1, $zero
    jal isPalindromeRecursive		
    
    # Print the answer
    # $s3 <-- result
    add $s3, $zero, $v0
    la $a0, answer
    jal utilPrintString		
    add $a0, $zero, $s3
    jal utilPrintString
    jal utilPrintNewLine
    
    # End the program
    jal utilEndProgram

#########################################################
# Function:       isPalindromeRecursive
# Purpose:        Recursively determine if the
#                 input string is a palindrome 
# Arguments:      $a0 <-- address of first char in string
#                 $a1 <-- address of last char in string
# Return values:  $v0 <-- yes if palindrome
#                         no if not
########################################################
isPalindromeRecursive:
    # push pointer to first char in string, 
    # pointer to last char in string, return address
    # to the stack
    # YOUR CODE HERE		
    addi $sp, $sp, -12
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $ra, 0($sp)
    # base case 1:
    # if string length == 1, $v0 <-- yes
    # YOUR CODE HERE
    seq $v0, $a0, $a1
    add $t0, $v0, $zero
    bnez $t0, return # meaning string length == 1
    
    # base case 2 and 3:
    # if string length == 2 or string length == 3 and 
    #    first and last characters match, 
    #    $v0 <-- yes
    # else $v0 <-- no
    # YOUR CODE HERE
    lb $t1, 0($a0)
    lb $t2, 0($a1)
    sub $t3, $a1, $a0
    ble $t3, 3, checkChars
    
    j recursiveStep
    
    # YOU MAY NEED TO ADD CODE HERE
checkChars:
    seq $v0, $t1, $t2
    
        
recursiveStep:
    # string length > 3
    # Recursive step:  if characters at pointers
    # are not equal, $v0 <-- no, end recursion.
    # YOUR CODE HERE
    
    bne $t1, $t2, return
    
    # Otherwise move closer to the base case -
    # move the pointers in.
    # YOUR CODE HERE
    addi $a0, $a0, 1
    addi $a1, $a1, -1
    jal isPalindromeRecursive	
    
    # restore $a0 
    # restore $a1
    # YOUR CODE HERE
    lw $a0, 8($sp)
    lw $a1, 4($sp)
return:
    # string length = 1, 2, or 3, end recursion
    # Restore the return address
    # and return from the recursive call
    # i.e., pop the recursive calls
    # YOUR CODE HERE
    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra		

.data
    answer:        .asciiz "\nAnswer: "
    no:            .asciiz "no"
    string:        .asciiz "nursesrun"
    stringLength:  .word 9
    yes:           .asciiz "yes"

.include "utils.asm"
