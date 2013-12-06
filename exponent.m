/* --------- EXPONENT FUNCTION ---------- */
 	.align	4
	.global	exponent
exponent:
	save	%sp,	-(92+8)&-8,	%sp
	std		%i0, 		[%fp-8] 	!load base into %f2
	ldd		[%fp-8],	%f2
 
	std		%i2, 		[%fp-8]
	ldd		[%fp-8], 	%f4			!load the exponent into %f4
	fitod	%f4, 		%f4			!convert exponent to double
 
	mov     1, 			%l0
	std     %l0, 		[%fp-8]
	ldd     [%fp-8], 	%f6 		!load 1 into %f6 	(index)
	fitod   %f6, 		%f6
 
	mov     1, 			%l2
	std     %l2, 		[%fp-8]
	ldd     [%fp-8], 	%f8 		!load 1 into %f8 (answer)
	fitod   %f8, 		%f8
 
	mov     1,			%l2
	std     %l2, 		[%fp-8]
	ldd     [%fp-8], 	%f10		!load 1 into f10	(increment)
	fitod   %f10, 		%f10
 	
loop1:
 
	fcmpd   %f6, 	%f4				!compare index to exponent
	nop
	fbg     endloop1 				!branch if greater than index
	nop
 
 
	fmuld	%f8, 	%f2, 	%f8		! multiply base by answer
	faddd	%f6, 	%f10, 	%f6		! increment index
 
	ba		loop1					!branch up
	nop
 
endloop1:

 	fmovs	%f8,	%f0 			!mov answer into %f0
 	fmovs	%f9,	%f1
	ret 
	restore 
