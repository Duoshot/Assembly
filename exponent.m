.align	4
	.global factorial

factorial:
	save	%sp,	-(92+8)&-8,	%sp
	std	%i0, [%fp-8]		
	ldd	[%fp-8], %f2				!i0 is number fed in
 	fitod	%f2,	%f2 			!convert to decimal

	mov		1, 		%l2
	std		%l2, 	[%fp-8]
	ldd	[%fp-8], 	%f4				!put 1 into f4
	fitod		%f4, %f4 	
 
	mov		1,		 %l2
	std		%l2, 	[%fp-8]
	ldd		[%fp-8],	 %f6 		!f6 will be register for current toal
	fitod	%f6, %f6
 
loop:
	fcmpd	%f2, %f4				!compare input value to one
	nop
 
	fble	endloop 				!branch if equal or less than one
	nop
 
	fmuld	%f6, %f2, %f6			!multiply value by the current total
	fsubd	%f2, %f4, %f2			!decrement value of multiplier
 
	ba	loop 						!branch up
	nop
 
endloop:
	fmuld	%f6,	%f4,	%f0 	!mov answer into f0

 	ret
 	restore 
