.pos 0x100
		ld $-1, r0				# r0 = -1
		ld $n, r1
		ld (r1), r1				# r1 = n
		ld $a, r2				# r2 = address of a[0]
		ld $b, r3				# r3 = address of b[0]
		ld $0, r4				# r4 = 0, counter, to be store in c
loop:	inc r0					# r0++
		mov r0, r5
		not r5
		inc r5
		add r1, r5
		bgt r5, L3
		br L0
L3:		ld (r2, r0, 4), r6		# r6 = a[r0]
		ld (r3, r0, 4), r7		# r7 = b[r0]
		not r7
		inc r7
		add r6, r7
		ld $0, r5
		bgt r7, L1
L2:		add r5, r4
		br loop
		
L1:		ld $1, r5
		br L2
		
L0:		ld $i, r2				# r2 = address of i
		st r0, (r2)				# i = r0
		ld $c, r2
		st r4, (r2)				# c = r4
		halt
		
.pos 0x1000
i:		.long -1
n:		.long 5
a:		.long 14
		.long 20
		.long 30
		.long 40
		.long 50
b:		.long 11
		.long 20
		.long 28
		.long 44
		.long 48
c:		.long 0