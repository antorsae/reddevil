
	MOVE.L $4(A7),A5
	MOVE.L $C(A5),D0
	ADD.L $14(A5),D0
	ADD.L $1C(A5),D0
	ADD.L #$100,D0
	MOVE.L D0,-(A7)
	MOVE.L A5,-(A7)
	CLR.W -(A7)
	MOVE.W #$4A,-(A7)
	TRAP #01
	ADD.L #12,A7

	CLR.L -(A7)
	MOVE.W #$20,-(A7)
	TRAP #01
	ADDQ.L #6,A7
	
	CLR.W -(A7)
	PEA NOM
	MOVE.W #$3D,-(A7)
	TRAP #1
	ADDQ.L #8,A7
	MOVE.W D0,-(A7)
	MOVE.L #$75000-128,-(A7)
	MOVE.L #32128,-(A7)
	MOVE.W D0,-(A7)
	MOVE.W #$3F,-(A7)
	TRAP #1
	ADD.L #12,A7
	MOVE.W #$3E,-(A7)
	TRAP #1
	ADDQ.L #4,A7

	BSR SALINT
	
	CLR.W VBLANK
ESP	TST.W VBLANK
	BEQ.S ESP	

	CLR.W $FFFF8260.w
	MOVE.B #$7,$FFFF8201.w
	MOVE.B #$50,$FFFF8203.w
	MOVE.W #0,QUEPAS
	move.l $68,$c0000
REINT	
	CLR.W VBLANK
ESPLI	TST.W VBLANK
	BEQ.S ESPLI
	move.w #$2100,sr

	LEA DATOWORD+$4,A0
	MOVE.W QUEPAS,D1
	ADD.W D1,D1
	ADD.W D1,A0
	ADD.W D1,A0
	ADD.W D1,A0
	MOVE.L #$75000,D0
	MOVEQ #0,D2
	MOVE.W (A0),D2
	LSL.L #8,D2
	SUB.L D2,D0
	LSR.L #8,D0
	MOVE.B D0,$FFFF8203.W
	LSR.W #8,D0
	MOVE.B D0,$FFFF8201.W

	TST.B PX
	BNE.S NOPAISA
	ADDQ.W #1,QUEPAS
	AND.W #%11111,QUEPAS
NOPAISA	ADDQ.B #1,PX
	AND.B #15,PX

	MOVE.W #$1A,LINCOM
	MOVE.L #HBL1,$68

	MOVE.B $FFFFFC02.W,D0
	CMP.B #1,D0
	BNE.S REINT
	move.l $c0000,$68
	MOVE.W #$555,$FFFF8240.W
	BSR RECINT
	CLR.W -(A7)
	TRAP #1



HBL1
	SUBQ.W #1,LINCOM
	BMI.S HBL2
	RTE
HBL2	
	MOVE.L #HBL3,$68
HG	STOP #$2100
	BRA HG
	RTE
HBL3	MOVE.W #$2700,SR
	ADDQ.L #6,A7
	MOVEM.L D0-D7/A0-A6,-(A7)
	LEA DATOWORD(PC),A4
	MOVE.W QUEPAS(PC),D0
	ADD.W D0,D0
	ADD.W D0,A4
	ADD.W D0,A4
	ADD.W D0,A4
	MOVEQ #0,D0
	LEA $FFFF8209.W,A0
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVE.W #$60,D2
LOP	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVE.W #$4,D6
	MOVE.W #$0000,$FFFF8240.W
	MOVE.B #$0,$ffff820A.w
	MOVEQ #3,D7
LOP1	NOP
	DBF D7,LOP1
	MOVE.B #2,$FFFF820A.W
	MOVE.W #$0000,$FFFF8240.W
LOP2	MOVE.B (A0),D0
	CMPI.B #$40,D0
	BGT.S LOP3
	DBF D6,LOP2
	ST VAL1
	ADDQ.W #1,VAL2
	NOP
	NOP
	NOP
	BRA LOP	
LOP3	SUB.W D0,D2
	LSL.W D2,D0
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVEQ #0,D2
	LEA $200.W,A5
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.L D2,(A5)+
	MOVE.W (A4),D4
	MOVE.W $2(A4),D5
	LEA $FFFF820A.W,A5
	LEA $FFFF8260.W,A6
	MOVEQ #2,D6
	MOVEQ #0,D7
	MOVE.W #$13,D0
LOP4	CMPI.W #$0000,D4
	BEQ LOP5
	SUBQ.W #1,D4
	REPT 4
	NOP
	ENDR
	MOVE.B D6,(A6)
	MOVE.B D7,(A6)
	REPT 89
	NOP
	ENDR
	MOVE.B D7,(A5)
	MOVE.B D6,(A5)
	REPT 13
	NOP
	ENDR
	MOVE.B D6,(A6)
	NOP
	MOVE.B D7,(A6)
	DBF D0,LOP4
LOP54	REPT 5
	NOP
	ENDR
LOP5	CMPI.W #0000,D5
	BEQ LOP6
	MOVE.B D7,(A6)
	MOVE.B D7,(A6)
	SUBQ.W #1,D5
	REPT 92
	NOP
	ENDR
	MOVE.B D7,(A5)
	MOVE.B D6,(A5)
	REPT 13
	NOP
	ENDR
	MOVE.B D7,(A6)
	NOP
	MOVE.B D7,(A6)
	BRA LOP54
	* DBF D0,LOP54
LOP6	MOVEM.L (A7)+,D0-D7/A0-A6
	ORI.W #$300,(A7)
	MOVE.L #HBL4,$68
HBL4	RTE
	
	
	BSR RECINT
	CLR.W -(A7)
	TRAP #1
	
	
	
INTVBL	MOVE.W #1,VBLANK
	RTE	
	
SALINT	

	MOVE.B $FFFFFA07,TIMA
	MOVE.B $FFFFFA09,TIMB
	MOVE.B $FFFFFA13,MASKA
	MOVE.B $FFFFFA15,MASKB
	MOVE.B $FFFFFA19,DATA
	MOVE.B $FFFFFA1B,DATB
	MOVE.L $70,VBL
	MOVE.L $120,GUARDTB

	MOVE.W #$2700,SR
	MOVE.L #INTVBL,$70
	CLR.B $FFFFFA07
	CLR.B $FFFFFA09
	CLR.B $FFFFFA13
	CLR.B $FFFFFA15
	CLR.B $FFFFFA1B
*	OR.B #1,$FFFFFFA07
*	OR.B #1,$FFFFFFA13
	MOVE.W #$2300,SR
	RTS

RECINT	

	MOVE.B TIMA,$FFFFFA07
	MOVE.B TIMB,$FFFFFA09
	MOVE.B MASKA,$FFFFFA13
	MOVE.B MASKB,$FFFFFA15
	MOVE.B DATA,$FFFFFA19
	MOVE.B DATB,$FFFFFA1B
	MOVE.L VBL,$70
	MOVE.L GUARDTB,$120
	RTS
	
	
VBL	DC.L 0
GUARDTB	DC.L 0	
VBLANK	DC.W 0
QUEPAS	DC.W 0
LINCOM	DC.W 0
VAL1	DC.L 0
VAL2	DC.L 0
TIMA	DC.B 0
TIMB 	DC.B 0
MASKA	DC.B 0
MASKB	DC.B 0
DATA	DC.B 0
DATB	DC.B 0
PX	DC.B 0

	EVEN	
DATOWORD
	DC.L $00000000,$00000000,$00060001,$00020003
	DC.L $00010004,$00000001,$00040006,$00020006
	DC.L $00030002,$00080000,$00020008,$00060003
	DC.L $000A0003,$0003000C,$00000003,$000C0006
	DC.L $00040000,$00020000,$00000008,$00010002
	DC.L $00050001,$00040002,$00010004,$00080002
	DC.L $00060005,$00020008,$00020002,$00080008
	DC.L $0003000A,$00050003,$000C0002,$0003000C
	DC.L $00080004,$00000004,$00000002,$00010000
	DC.L $00020007,$00010004,$00040001,$00060001
	DC.L $00010006,$00070002,$00080004,$0002000A
	DC.L $00010002,$000A0007,$0003000C,$00040003
	DC.L $00000000,$FFFF0000,$00060000,$00020003
	DC.L $00000004,$00000000,$00040006,$00010006
	DC.L $00030001,$00080000,$00010008,$00060002

NOM	DC.B "1.NEO",0
