
	local_var
	var(buf,1,1*8) 					!buffer for reader


	.align 	4
	.global	main 
main:
	save 	%sp,	-(92+8)&-8,	%sp

	set 	printtable,	%o0 		!print labels
	call	printf
	nop

	set 	fn,		%o0 			!first arg(input file)
	clr		%o1						!second arg(read only)
	clr		%o2						!third arg(not used)
	mov		OPEN,	%g1				!open request
	ta		0						!call sys function
	bcc		open_ok					!error check
	nop
	mov		1,		%g1				!exit to OS
	ta		0

open_ok:
	mov		%o0,	%fd_r			!move file descriptor into register

read:
	mov 	%fd_r,	%o0 			!file discriptor
	add 	%fp,	buf,	%o1		!arg
	mov		8,		%o2 			!read 8 bytes
	mov		READ,	%g1 			!read request
	ta		0 						!call sys function

	cmp		%o0,	8 				!compare bytes read to 8
	bne		end 					!if bytes read is not equal, EOF reached
	nop
	
	mov 	%fd_r,	%o0 			!file discriptor to o0
	mov		CLOSE,	%g1 			!close request
	ta 		0 						!sys call function
