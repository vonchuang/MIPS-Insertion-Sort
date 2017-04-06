# MIPS-Insertion Sort
# 2017.4.6

.data
Array: .word 9, 2, 8, 1, 6, 5, 4, 10, 3, 7 

.text
main:
	# $t0 : the base address of the numbers array
	# $t1 : temp
	# $t2 : firstUnsortedIndex
	# $t3 : testIndex
	# $t4 : elementToInsert
	# $t5 : value of A
	# $t6 : calculate the address of A in
	# $t7 : the value of (length-1)
	# $t9 : temp
	addi $t0, $zero, 4097      # $t0 = 0x00001001
	sll  $t0, $t0, 16          # set the base address of the array into $t0 = 0x10010000    	
	addi $t2, $zero, 1			# i = 1
	addi $t7, $zero, 10			# length = 10
	sub $t7, $t7, 1				# 10 - 1
for_loop: 
	slt $t1, $t7, $t2			# $t1 = ($t2 > $t7)? 1 : 0
	bne $t1, $zero, end_for		# if($2 > $7) -> end_for
	sub $t3, $t2, 1				# j = i - 1
	sll $t6, $t2, 2				# i*4
	add $t6, $t0, $t6			# address of A[i]= base addr of A + i*4
	lw $t4, 0($t6)				# $4 <- A[i]
while: 
	slt $t1, $t3, $zero			# $t1 = ( j < 0 )? 1 : 0
	bne $t1, $zero, end_while	# if( j < 0 ) -> end_while
	sll $t6, $t3, 2				# j*4
	add $t6, $t0, $t6			# address of A[j]= base addr of A + j*4
	lw $t5, 0($t6)				# $5 <- A[j]
	addi $t9, $t4, 1			# A[i] = A[i] + 1
	slt $t1, $t5, $t4			# $t1 = (A[j] < A[i])? 1 : 0
	bne $t1, $zero, end_while	# if(A[j] < A[i]) -> end_while	
	sw $t5, 4($t6)				# A[j]
	sub $t3, $t3, 1				# j = j - 1
	j while
end_while:
	sll $t6, $t3, 2				# j*4
	add $t6, $t0, $t6			# address of A[j]= base addr of numbers + j*4
	sw $t4, 4($t6)				# A[i]
	addi $t2, $t2, 1			# i = i + 1
	j for_loop					# for loop
end_for:
	li   $v0, 10               # program stop
	syscall