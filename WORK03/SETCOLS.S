;DIR COL EN A0.L
COLGRA	MOVEM.L	D0-4/A0,-(A7)
	MOVEQ	#7,D4
L3FF02	MOVE.L	A1,-(A7)
	LEA	$FFFF8200.W,A0
	MOVE.B	3(A0),D0
L3FF0C	CMP.B	7(A0),D0
	BNE.S	L3FF0C
	LEA	$FFFF8240.W,A0
	MOVEQ	#$F,D0
L3FF18	MOVE.W	(A0),D2
	ANDI.W	#7,D2
	MOVE.W	(A1),D1
	ANDI.W	#7,D1
	CMP.W	D1,D2
	BEQ.S	L3FF2A
	ADDQ.W	#1,D2
L3FF2A	MOVE.W	D2,D3
	MOVE.W	(A0),D2
	ANDI.W	#$70,D2
	MOVE.W	(A1),D1
	ANDI.W	#$70,D1
	CMP.W	D1,D2
	BEQ.S	L3FF40
	ADDI.W	#$10,D2
L3FF40	OR.W	D2,D3
	MOVE.W	(A0),D2
	ANDI.W	#$700,D2
	MOVE.W	(A1)+,D1
	ANDI.W	#$700,D1
	CMP.W	D1,D2
	BEQ.S	L3FF56
	ADDI.W	#$100,D2
L3FF56	OR.W	D2,D3
	MOVE.W	D3,(A0)+
	DBF	D0,L3FF18
	MOVE.W	#$6000,D0
L3FF62	DBF	D0,L3FF62
	MOVEA.L	(A7)+,A1
	DBF	D4,L3FF02
	MOVEM.L	(A7)+,D0-4/A0
	RTS
	
