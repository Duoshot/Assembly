include(macro_defs.m)
/*define(i_r,	l7)

fmt:	.asciz "Factorial is %d\n"

	.align	4
	.global	factorial 
factorial:	save	%sp,	-(92-8)&-8,	%sp
	std		%i0, 		[%fp-8]
	ldd		[%fp-8], 	%f2			!load value in f2

	mov		1, 		%l0
	std		%l0, 	[%fp-8]
	ldd		[%fp-8], 	%f4				!1 is loaded into f4
	fitod	%f4, 		%f4
 
	mov		1, 		%l0
	std		%l0, 	[%fp-8]
	ldd		[%fp-8], 	%f6				!1 is loaded into f0
	fitod	%f6, 		%f6

loop:
	fcmpd	%f2, %f4				! Compare value to one
	nop
 
	fble	endloop
	nop
 
	fmuld	%f6, %f2, %f6		! Multiply value by the current total
	fsubd	%f2, %f4, %f2		! Decrement value of multiplier
 
	ba	loop
	nop
 
endloop:
 
		fmovs	%f6,	%f0
		fmovs	%f7,	%f1
		ret
		restore
 
*/

!.global	factorial
	!.section ".text"
	!.align 4
!factorial:
 
	!save	%sp, -112, %sp
 begin_fn(factorial)
 
	std	%i0, [%fp-8]		
	ldd	[%fp-8], %f2		! Load N into FPU Register
 	fitod	%f2,	%f2

	mov	1, %l0
	std	%l0, [%fp-8]
	ldd	[%fp-8], %f4		! Load one into FPU Register
	fitod	%f4, %f4
 
	mov	1, %l0
	std	%l0, [%fp-8]
	ldd	[%fp-8], %f6		! Load one into FPU Register
	fitod	%f6, %f6
 
loop:
	fcmpd	%f2, %f4		! Compare value to one
	nop
 
	fble	endloop
	nop
 
	fmuld	%f6, %f2, %f6		! Multiply value by the current total
	fsubd	%f2, %f4, %f2		! Decrement value of multiplier
 
	ba	loop
	nop
 
endloop:
	fmuld	%f6,	%f4,	%f0
 end_fn(factorial)
 
 

fmt:	.asciz "factorial is %E\n"

 	.section	".data"
 	.align	8
 	f_m:	.double 0r15.0


	!.section	".text"
	!.align	4
	!.global	main 
!main:	save 	%sp,	-(92+8) & -8,	%sp
begin_main
	!set 	f_m,		%l0
	!ldd 	[%l0],	%o0
	mov		50,	%o0
	call	factorial 
	nop
break:
	std		%f0,	[%fp-8]
	ld 		[%fp-8],	%o1
	ld 		[%fp-4],	%o2
	set 	fmt,		%o0
	call	printf
	nop

!mov 	1,	%g1
!ta 		0
end_main
