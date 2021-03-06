	LEA B_1,A4
	MOVEQ.L #24-1,D4
	BSR INPUT
	CLR.L -(A7)
	TRAP #1
T	LEA FONT,A0
	MOVEA.L T_SC,A1
	BSR TEXT
	RTS
INPUT	MOVE.L T_SC,OSC
	MOVEM.L D4/A4,B_SEG
AINPUT	* MOVEM.L D4/A4,REGS
	MOVE.W #7,-(A7)
	TRAP #1
	LEA 2(A7),A7
	CMP.B #'A',D0
	BGE YAHH
	CMP.B #$D,D0
	BEQ FUA_G
	CMP.B #8,D0
	BEQ BACK_SP
	BRA.S WOWA
YAHH	BCLR #5,D0
WOWA	MOVE.B D0,(A4)+
	LEA BASURA,A3
	LEA FONT,A0
	MOVEA.L T_SC,A1
	MOVEM.L D4/A4,REGS
	BSR CHAR
	MOVEM.L REGS,D4/A4
RESTAS	DBF D4,AINPUT
	MOVE.B #0,(A4)
FUA_G	RTS
OSC	DS.L 1
REGS	DS.L 2
B_SEG	DS.L 2
BACK_SP	MOVEM.L B_SEG,D4/A4
	MOVE.W #24-1,D0
B_A4	CLR.B (A4)+
	DBF D0,B_A4
	MOVE.L OSC,T_SC
	LEA SPACE,A3
	CLR.W CDC
	BSR T
	CLR.W CDC
	MOVE.L OSC,T_SC
	MOVEM.L B_SEG,D4/A4
	BRA AINPUT 
BASURA	DS.L 16
TEXT	MOVEA.L A0,A4
	MOVE.L A1,SCREE
OTROC	MOVEA.L A4,A0
	CLR.W D0
	MOVE.B (A3)+,D0
CHAR	TST.B D0
	BEQ SALTE
	CMP.B #$F,D0
	BNE NESP
	MOVEQ.L #-1,D1
AQW	DBF D1,AQW
	BRA OTROC
NESP	CMP.B #' ',D0
	BNE NOESP
	MOVE.B #39,D0
	BRA TODOL
NOESP	CMP.B #$A,D0
	BNE NRETURN
	LEA 8*160(A1),A1
	MOVEA.L SCREE,A5
	SUBA.L A5,A1
	MOVE.L A1,D7
	DIVU #160,D7
	SWAP D7
	CLR.W D7
	SWAP D7
	MULU #160,D7
	MOVEA.L D7,A1
	ADDA.L A5,A1
	BRA OTROC
NRETURN CMP.B #'A',D0
	BLT MENOR
	SUB.B #'A',D0
TODOL	MULS #8,D0
	LEA 0(A0,D0.W),A0
COPA	MOVE.B (A0)+,(A1)
	MOVE.B (A0)+,160*1(A1)
	MOVE.B (A0)+,160*2(A1)
	MOVE.B (A0)+,160*3(A1)
	MOVE.B (A0)+,160*4(A1)
	MOVE.B (A0)+,160*5(A1)
	MOVE.B (A0)+,160*6(A1)
	MOVE.B (A0)+,160*7(A1)
	EOR.W #-1,CDC
	BNE PALA 
	ADDQ.L #6,A1
PALA	ADDQ.L #1,A1
	BRA OTROC
SALTE	MOVE.L A1,T_SC
	ST CON
	RTS
CON	DS.W 1
T_SC	DC.L $F8000
SCREE	DS.L 1
CDC	DS.W 1
MENOR	CMP.B #'.',D0
	BNE COND4
	MOVE.B #38,D0
	BRA TODOL
COND4	CMP.B #'!',D0
	BNE COND5
	MOVE.B #37,D0
	BRA TODOL
COND5	CMP.B #':',D0
	BNE COND6
	MOVE.B #36,D0
	BRA TODOL
COND6	SUB.B #'0',D0
	ADD.B #26,D0
	BRA TODOL
FONT	INCBIN 'FONT8P.RED'
SPACE	DC.B '                           ',0
B_1	DS.B 26       	
