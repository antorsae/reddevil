	LEA FONT,A0
	LEA $57FDE,A1
	MOVE.W #$FFFF,D0
VL	MOVE.B (A0)+,(A1)+
	DBF D0,VL
START	LEA	TEXT(PC),A0
	LEA	$50000,A1
	LEA	$7F260,A2 ;ADRESS
NEXTLET NOP
L3FEA2	MOVEQ	#0,D0
	MOVE.B	(A0)+,D0
	BEQ	START
	BPL.S	L3FEF0
	CMP.B	#$FE,D0
	BEQ.S	L3FEB4
	BRA.S	L3FEC4
L3FEB4	MOVEQ	#8,D5
	MOVE.L	A0,-(A7)
L3FEB8	MOVEQ	#$20,D0
	BSR.S	L3FEF6
	DBF	D5,L3FEB8
	MOVEA.L	(A7)+,A0
	BRA.S	L3FEA2
L3FEC4	MOVE.W	#$FFFF,D0
L3FEE8	BRA	NEXTLET
L3FEF0	BSR.S	L3FEF6
	BRA	NEXTLET
L3FEF6	MOVEM.L	A0-A2,-(A7)
	BSR	L3FF90
	MOVEQ	#7,D7
	MOVEM.L	(A7)+,A0-A2
L3FF04	BSR.S	L3FF1E
	BSR.S	L3FF1E
	MOVEM.L	D0-D7/A0-A1,-(A7)
	MOVE.W	#$25,-(A7)
	TRAP	#14
	ADDQ.L	#2,A7
	MOVEM.L	(A7)+,D0-D7/A0-A1
	DBF	D7,L3FF04
	RTS
L3FF1E	MOVEM.L	A1-A2,-(A7)
	MOVEQ	#$F,D0
L3FF24	MOVEQ	#3,D1
L3FF26	LSL	(A1)
	ROXL	$98(A2)
	ROXL	$90(A2)
	ROXL	$88(A2)
	ROXL	$80(A2)
	ROXL	$78(A2)
	ROXL	$70(A2)
	ROXL	$68(A2)
	ROXL	$60(A2)
	ROXL	$58(A2)
	ROXL	$50(A2)
	ROXL	$48(A2)
	ROXL	$40(A2)
	ROXL	$38(A2)
	ROXL	$30(A2)
	ROXL	$28(A2)
	ROXL	$20(A2)
	ROXL	$18(A2)
	ROXL	$10(A2)
	ROXL	8(A2)
	ROXL	(A2)
	ADDQ.L	#2,A1
	ADDQ.L	#2,A2
	DBF	D1,L3FF26
	LEA	$98(A1),A1
	LEA	$98(A2),A2
	DBF	D0,L3FF24
	MOVEM.L	(A7)+,A1-A2
	RTS
L3FF90	MOVEM.L	D0-D2/A0-A1,-(A7)
	SUBI.B	#$20,D0
	BPL.S	L3FF9C
	CLR.L	D0
L3FF9C	ROL.L	#2,D0
	LEA	BUILD(PC),A0
	ADDA.L	D0,A0
	MOVEA.L	(A0),A0
	LEA	$50000,A1
	MOVEQ	#$F,D0
COPY	MOVEM.L	(A0),D1-D2
	MOVEM.L	D1-D2,(A1)
	LEA	$A0(A0),A0
	LEA	$A0(A1),A1
	DBF	D0,COPY
	MOVEM.L	(A7)+,D0-D2/A0-A1
	RTS
BYTE1	DC.B 8
BYTE2	DC.B 0
BUILD 	DS.L 100
TEXT	DC.B 'ESTO ES UNA PRUEBA',00,$FF,$FE
FONT 	INCBIN 'FONTB.BIN'