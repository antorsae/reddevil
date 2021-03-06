   	LEA PIC+34(PC),A0
	LEA $F8000,A1
	BSR DEPACK
	BSR CUTLOGO
	CLR.L -(A7)
	TRAP #1
DEPACK	MOVE.L #2,D0
	NEG.B D0
	MOVE.W	#$C7,D4		; 200 LINEAS
	CLR.W	D7
	CLR.B	D0
L30842	MOVE.L	A1,-(A7) 	; A1=DI PANTALLA
	MOVE.W	#3,D5
L30848	MOVE.L	A1,-(A7)
	MOVE.W	#$13,D6
L3084E	BSR.S	L3086E
	BSR.S	L3086E
	LEA	6(A1),A1
	DBF	D6,L3084E
	MOVEA.L	(A7)+,A1
	ADDQ.L	#2,A1
	DBF	D5,L30848
	MOVEA.L	(A7)+,A1
	LEA	$A0(A1),A1
	DBF	D4,L30842
	RTS
L3086E	SUBQ.B	#1,D0
	BPL	L30892
L30874	MOVE.B	(A0)+,D0
	CMPI.B	#$80,D0
	BEQ	L30874
	BTST	#7,D0
	BNE	L3088C
	CLR.W	D7
	BRA	L30892
L3088C	NEG.B	D0
	MOVE.W	#$FFFF,D7
L30892	TST.W	D7
	BNE	L3089C
	MOVE.B	(A0)+,(A1)+
	RTS
L3089C	MOVE.B	(A0),(A1)+
	TST.B	D0
	BNE.S NOSUM
	ADDQ.L	#1,A0
NOSUM	RTS
CUTLOGO	LEA FONT(PC),A1
	MOVEM.L PIC+2,D0-D7
	MOVEM.L D0-D7,(A1)
	LEA $F8000,A0
	LEA 16*2(A1),A1 
	MOVEQ #2-1,D0
D0L	MOVEQ #20-1,D1
D1L	MOVEQ #16-1,D2
D2L	MOVE.W (A0),(A1)+
	LEA 160(A0),A0
	DBF D2,D2L
	LEA (-160*16)+8(A0),A0
	DBF D1,D1L
	LEA 15*160(A0),A0
	DBF D0,D0L
N	EQU 41
	MOVEQ #N-1,D1
K1L	MOVE.W (A0),(A1)+
	MOVE.W 8*1(A0),(A1)+
	MOVE.W 8*2(A0),(A1)+
	MOVE.W 8*3(A0),(A1)+
	LEA 160(A0),A0
	DBF D1,K1L
	RTS
PIC	INCBIN 'FILM.PC1'
FONT