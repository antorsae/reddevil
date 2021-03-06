BASE	EQU $F8000
MAX	EQU 320-16
MAY	EQU 133-7
XYINC	EQU $00030001 ;Y,X
XYINK	EQU $00070004 ;Y,X
	CLR.L -(A7)
	MOVE.W #$20,-(A7)
	TRAP #1
	LEA 6(A7),A7
	BSR ROXRED
	BSR GENSIN
ME	MOVE.W #$25,-(A7)
	TRAP #14
	LEA 2(A7),A7
	BSR BOSPR
	BSR CALCTR
	BSR PUTSPR
	BSR PUTREX
	BRA.S ME
XPOS	DC.W 0
YPOS	DC.W 0
XREL	DC.W 0
YREL	DC.W 0
PUTSPR	LEA TRAY,A0
	MOVEQ #9-1,D7
SPRT	MOVE.L (A0)+,A1
	MOVE.L (A0)+,A2
PPART	MACRO LI	
	MOVE.W \1*160(A2),D0
	MOVE.L (\1*160)+2(A2),D1
	MOVE.L (A1)+,D2
	AND.W D2,D0
	AND.L D2,D1
	OR.W (A1)+,D0
	MOVE.L D1,(\1*160)+2(A2)
	MOVE.W D0,\1*160(A2)
	MOVE.W (\1*160)+8(A2),D0
	MOVE.L (\1*160)+2+8(A2),D1
	MOVE.L (A1)+,D2
	AND.W D2,D0
	AND.L D2,D1
	OR.W (A1)+,D0
	MOVE.L D1,(\1*160)+2+8(A2)
	MOVE.W D0,(\1*160)+8(A2)
	ENDM
	PPART 0
	PPART 1
	PPART 2
	PPART 3
	PPART 4
	PPART 5
	PPART 6
	DBF D7,SPRT
	RTS
PUTREX	LEA TRAYR(PC),A0
	MOVEQ #9-1,D7
PUTREXL	MOVE.L (A0)+,A1
	MOVE.L (A0)+,A2
PART	MACRO LI	
	MOVE.W \1*160(A2),D0
	MOVE.L (\1*160)+2(A2),D1
	MOVE.L (A1),D2
	AND.W D2,D0
	AND.L D2,D1
	OR.W 4(A1),D0
	MOVE.L D1,(\1*160)+2(A2)
	MOVE.W D0,\1*160(A2)
	MOVE.W (\1*160)+8(A2),D0
	MOVE.L (\1*160)+2+8(A2),D1
	MOVE.L 6(A1),D2
	AND.W D2,D0
	AND.L D2,D1
	OR.W 10(A1),D0
	MOVE.L D1,(\1*160)+2+8(A2)
	MOVE.W D0,(\1*160)+8(A2)
	LEA 24(A1),A1
	ENDM
	PART 0
	PART -1
	PART -2
	DBF D7,PUTREXL
	RTS
BOSPR	LEA TRAY+4,A0
	MOVEQ #0,D7
	MOVEQ #9-1,D0
BORED	MOVEA.L (A0),A1
BOLI	MACRO LI
	MOVE.W D7,\1*160(A1)
	MOVE.W D7,(\1*160)+8(A1)
	ENDM
	BOLI 0
	BOLI 1
	BOLI 2
	BOLI 3
	BOLI 4
	BOLI 5
	BOLI 6
	ADDQ.L #4*2,A0
	DBF D0,BORED
	LEA TRAYR+4,A0
	MOVEQ #9-1,D0
BOREDD	MOVEA.L (A0),A1
	BOLI 0
	BOLI -1
	BOLI -2
	ADDQ.L #4*2,A0
	DBF D0,BOREDD
	RTS	
TRAY	REPT 9
	DC.L LE1
	DC.L BASE+2
	ENDR
TRAYR	REPT 9
	DC.L LE1
	DC.L BASE+2
	ENDR
ROXRED	LEA FILE+(16*2)+(25*13*6)(PC),A0
	LEA ROXLETS,A1
	LEA BASE,A2
	MOVEQ #0,D7
	MOVEQ #8-1,D0
RLETRAS	BSR PRINTLE
	MOVEQ #16-1,D1
RRLETR	BSR SALVALE
	BSR ROTALA
	DBF D1,RRLETR
	DBF D0,RLETRAS
	RTS
PRINTLE	MOVE.W (A0)+,(A2)
	MOVE.W (A0)+,1*160(A2)
	MOVE.W (A0)+,2*160(A2)
	MOVE.W (A0)+,3*160(A2)
	MOVE.W (A0)+,4*160(A2)
	MOVE.W (A0)+,5*160(A2)
	MOVE.W (A0)+,6*160(A2)
	MOVE.W D7,(160*0)+8(A2)
	MOVE.W D7,(160*1)+8(A2)
	MOVE.W D7,(160*2)+8(A2)
	MOVE.W D7,(160*3)+8(A2)
	MOVE.W D7,(160*4)+8(A2)
	MOVE.W D7,(160*5)+8(A2)
	MOVE.W D7,(160*6)+8(A2)
	RTS
SALVALE	
PLETRA	MACRO LI
	MOVE.W \1*160(A2),D5
	MOVE.W D5,4(A1)
	NOT.W D5
	MOVE.W D5,(A1)
	MOVE.W D5,2(A1)
	ADDQ.L #6,A1
	MOVE.W (\1*160)+8(A2),D5
	MOVE.W D5,4(A1)
	NOT.W D5
	MOVE.W D5,(A1)
	MOVE.W D5,2(A1)
	ADDQ.L #6,A1
	ENDM
	PLETRA 0
	PLETRA 1
	PLETRA 2
	PLETRA 3
	PLETRA 4
	PLETRA 5
	PLETRA 6
	RTS
ROTALA	MOVE.W #0,CCR
PROTLE	MACRO LI
	ROXR \1*160(A2)
	ROXR (\1*160)+8(A2)
	ENDM
	PROTLE 0
	PROTLE 1
	PROTLE 2
	PROTLE 3
	PROTLE 4
	PROTLE 5
	PROTLE 6
	RTS
GENSIN	LEA SINUS,A0
	MOVE.W #MAX-1,D0
GENY	MOVEQ #0,D1
	MOVE.W (A0),D1
	MULU #160,D1
	MOVE.W D1,(A0)
	ADDQ.L #4,A0
	DBF D0,GENY
	MOVE.W #MAY-1,D0
GENX	MOVEQ #0,D1
	MOVE.W (A0),D1
	DIVU #16,D1
	LSL.W #3,D1
	MOVE.W D1,(A0)+
	CLR.W D1
	SWAP D1
	MULU #7*2*6,D1
	MOVE.W D1,(A0)+
	DBF D0,GENX
	RTS
CALCTR	LEA TRAY(PC),A0
	LEA TRAYR(PC),A4
	LEA SINUS(PC),A3
	MOVE.L SCREEN,D2
	MOVE.L D2,D5
	ADD.W #(199*160),D5
	ADD.L #XYINC*4,XPOS
PLE	MACRO COSA 
	MOVE.L D5,D7
	BSR CALC2
	ADD.L #\1,D1
	ADD.L D2,D0
	MOVE.L D1,(A0)+
	MOVE.L D1,(A4)+
	MOVE.L D0,(A0)+
	MOVE.L D7,(A4)+
	ENDM
	MOVE.L D5,D7
	BSR CALC1
	ADD.L #LE9,D1
	ADD.L D2,D0
	MOVE.L D1,(A0)+
	MOVE.L D1,(A4)+
	MOVE.L D0,(A0)+
	MOVE.L D7,(A4)+
	MOVE.L XPOS,XREL
	ADD.L #XYINK*4,XREL
	PLE LE8
	ADD.L #XYINK*4,XREL
	PLE LE7
	ADD.L #XYINK*4,XREL
	PLE LE6
	ADD.L #XYINK*4,XREL
	PLE LE5
	ADD.L #XYINK*4,XREL
	PLE LE4
	ADD.L #XYINK*4,XREL
	PLE LE3
	ADD.L #XYINK*4*2,XREL
	PLE LE2
	ADD.L #XYINK*4,XREL
	PLE LE1
	RTS
CALC1	MOVEQ #0,D0
	MOVEQ #0,D1
	MOVE.W XPOS,D0
	CMP.W #MAX*4,D0
	BLT.S GOSINY
	SUB.W #MAX*4,D0
	MOVE.W D0,XPOS
GOSINY	LEA 0(A3,D0.W),A1
	MOVE.W YPOS,D0
	CMP.W #MAY*4,D0
	BLT.S GOSINX
	SUB.W #MAY*4,D0
	MOVE.W D0,YPOS
GOSINX	ADD.W #MAX*4,D0
	LEA 0(A3,D0.W),A2
	MOVE.W (A1),D0
	MOVE.W D0,D6
	DIVU #160,D6
	LSR.W #1,D6
	MULU #160,D6
	SUB.W D6,D7
	MOVE.W (A2)+,D4
	ADD.W D4,D0
	ADD.W D4,D7
	MOVE.W (A2),D1
	RTS
CALC2	MOVEQ #0,D0
	MOVEQ #0,D1
	MOVE.W XREL,D0
	CMP.W #MAX*4,D0
	BLT.S GOSINY2
	SUB.W #MAX*4,D0
	MOVE.W D0,XREL
GOSINY2	LEA 0(A3,D0.W),A1
	MOVE.W YREL,D0
	CMP.W #MAY*4,D0
	BLT.S GOSINX2
	SUB.W #MAY*4,D0
	MOVE.W D0,YREL
GOSINX2	ADD.W #MAX*4,D0
	LEA 0(A3,D0.W),A2
	MOVE.W (A1),D0
	MOVE.W D0,D6
	DIVU #160,D6
	LSR.W #1,D6
	MULU #160,D6
	SUB.W D6,D7
	MOVE.W (A2)+,D4
	ADD.W D4,D0
	ADD.W D4,D7
	MOVE.W (A2),D1
	RTS
SINUS	INCBIN 'SENOSD.RED'
FILE	INCBIN 'INTROD.BIN'
SCREEN	DC.L BASE
ROXLETS 
LE1	EQU ROXLETS 	         ;P
LE2	EQU ROXLETS+(7*2*16*1*6) ;D
LE3	EQU ROXLETS+(7*2*16*2*6) ;L
LE4	EQU ROXLETS+(7*2*16*3*6) ;I
LE5	EQU ROXLETS+(7*2*16*4*6) ;B
LE6	EQU ROXLETS+(7*2*16*5*6) ;R
LE7	EQU ROXLETS+(7*2*16*6*6) ;A
LE8	EQU ROXLETS+(7*2*16*5*6) ;R
LE9	EQU ROXLETS+(7*2*16*7*6) ;Y

	