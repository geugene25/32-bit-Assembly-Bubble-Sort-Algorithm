#####################################################################################################
#                                         							    #
#                                           Greg Eugene					    #
#				    MIPS-32 Bubble Sort Algorithm			            #
#												    #
#											            #
#####################################################################################################
.data

Array: .word -4, 5, -1, 3, 0, 5, 2, 6, -1, 9, 22, -25, 13, -5, 15, 16

prompt: .asciiz "enter 'a' to sort the array in ascending order or 'd' to sort in descneding order: "

buff: .space 1
#####################################################################################################
.text
.globl main

main:

la $a0, prompt  #loads prompt to $a0
li $v0, 4	#prints prompt
syscall

li $v0, 12	# **important note syscall of '12' is a MARS supported directive**
syscall 	#
		# Normally written as:
		#
		# li $v0, 8    <-------directive number
		# la $a0, buff <-------load allocated space in to register
		# li $a1, 1    <-------state the amount of space to be used

move $t1, $v0	#moves $v0 to $t1

li $s0, 97	#sets the value of register $s0 to 97
li $s1,	100	#sets the value of register $s1 to 100

li $t0, 16	#sets the value of register $t0 to 16
li $t5, 16
la $t3, Array	#puts the address of Array into $t3

 
 beq $t1, $s0, ascend #if the user input is 'a' jump to ascend
 beq $t1, $s1, descend #if the user input is 'd' jump to descend
 
 # In this iteration of the bubble sort two counters are used
 #
 #
 #			Counter 1: $t0
 #
 #			This counter starts at $t0 decreasing by 1 to determine when we are finished sorting.
 #			
 #			1) The counter $t0 decreases - line 81
 #			2) Check to see if the first element $t2 > $t4 swap the two values - line 86
 #			3) If the swap condition is met we reset $t0 to 16 because it should countinuously 
 #			   countdown ONLY when no swap occurs. - line(s) 108-109
 #			   	
 #					*This is how we know that the array has been completely sorted.
 #					 This counter will only go to zero if no swaps occurs when traversing the array;
 #					 meaning the the array has been sorted.
 #
 #
 #############################################################################################################
 #			
 #			Counter 2: $t5
 #
 #			We need to have a way to go back to the first element in the array once we have travesed it once
 #			to see if anything else needs to be sorted. There are 16 elements in the array therefore loop can only
 #			swap or not swap 16 times.
 #
 #			1) Set the counter to 16 - line 82
 #			2) This counter decrements regardsless of whether or not a swap occurs.
 #			3) When $t5 = 0  meaning every position has been checked we go to 'reset' - line 115
 #			4) $t5 is reset to 16 because we need to start the process of checking all of the elements again - line 116
 #
 #
 ###############################################################################################################
 
 
 	ascend:	beqz $t0, exit #if the value of $t0 is equal to 0 jump to exit
 		addi $t0, $t0, -1 #decrement inside loop
 		addi $t5, $t5, -1 #decrement counter
 		blez $t5, reset #This counter lets us know when we checked every position in the array
 		lw $t2, 0($t3) #loads the first position of array
 		lw $t4, 4($t3) #loads n+1 postion of array
 		bgt $t2, $t4, swap
 		beq $t2, $t4, no_swap
 		addi $t3, $t3, 4 #increment array position
 		j	ascend
 		
 	descend:beqz $t0, exit #if the value of $t0 is equal to 0 jump to exit
 		addi $t0, $t0, -1 #decrement inside 
 		addi $t5, $t5, -1
 		blez $t5, reset_2
 		lw $t2, 0($t3) #loads the first position of array
 		lw $t4, 4($t3) #loads n+1 postion of array
 		blt $t2, $t4, swap_2
 		beq $t2, $t4, no_swap_2
 		addi $t3, $t3, 4 #increment array position
 		j	descend
 		
 
 	
 	
 	swap:	sw $t4, 0($t3) #store the value on $t4 into the array cell 60
 		sw $t2, 4($t3) #store the value on $t5 into the array cell n+1
 		addi $t3, $t3, 4 #increment array position
 		li $t0, 0 #sets $t0 to 0
 		addi $t0, $t0, 16 #$t0 back to 16
 		j	ascend
 	
 	no_swap:addi $t3, $t3, 4 #increment array position 
 		j 	ascend
 		
 	reset:  la $t3, Array #loads original array back to $t3 to check the first element again
 		li $t5, 16    #resets counter to 16
 		j	ascend
 		
 	swap_2:	sw $t4, 0($t3) #store the value on $t4 into the array cell 60
 		sw $t2, 4($t3) #store the value on $t5 into the array cell n+1
 		addi $t3, $t3, 4 #increment array position
 		li $t0, 0 #sets $t0 to 0
 		addi $t0, $t0, 16 #$t0 back to 16
 		j	descend
 	
 	no_swap_2:addi $t3, $t3, 4 #increment array position 
 		j 	descend
 		
 	reset_2: la $t3, Array 	#loads original array back to $t3 to check first element again
 		 li $t5, 16	#resets inside counter to 16
 		 j	descend
 		
 		
 	exit:	li $v0, 10	#exits program
 		syscall
 	
 	
 	
 	
 	
 	
 	
 	
