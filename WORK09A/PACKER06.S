  	CLR.L -(A7)
	MOVE.W #$20,-(A7)
	TRAP #1
	LEA 6(A7),A7
	MOVE.L $44E,SCREEN
	BSR SAVE_AL
	BSR RETARD
ST_C	BSR CLR
	MOVE.W #$000,$FFFF8240.W
	MOVE.W #$777,$FFFF8240+(15*2).W
	MOVE.W #$777,$FFFF8240+2.W
	LEA WELLCO,A3
	BSR T
KEY_B	MOVE.W #7,-(A7)
	TRAP #1
	LEA 2(A7),A7
	CMP.B #'1',D0
	BEQ CRU_S
	CMP.B #'2',D0
	BEQ CRU_D
	CMP.B #'3',D0
	* BEQ MUZAK
	CMP.B #'4',D0
	BEQ GO_GEM
	BRA.S KEY_B
CRU_D	PEA B_FILE
	MOVE.W #$1A,-(A7)
	TRAP #1
	LEA 6(A7),A7
	CLR.W -(A7)
	PEA PATH
	MOVE.W #$4E,-(A7)
	TRAP #1
	LEA 8(A7),A7
	TST.W D0
	BMI FAIL_LD
	BSR P_FF
	BSR CLR
MAS_FF	MOVE.W #$4F,-(A7)
	TRAP #1
	LEA 2(A7),A7
	TST.W D0
	BMI FAIL_LD
	BSR P_FF
	BSR CLR
	BRA MAS_FF
P_FF	LEA B_FILE+30,A0
	LEA B_1,A1
C_NOMBR	MOVE.B (A0)+,(A1)+	
	BNE C_NOMBR
	LEA B_1,A1
	CLR.W EX
MAS_L	MOVE.B (A1)+,D0
	TST.B D0
	BEQ NO_P
	CMP.B #'.',D0
	BNE MAS_L
	MOVE.B (A1)+,D0
	MOVE.B (A1)+,D1
	MOVE.B (A1)+,D2
	CMP.B #'P',D0
	BNE PAS_1
	CMP.B #'R',D1
	BNE NO_P
	CMP.B #'G',D2
	BNE NO_P
	MOVE.W #-1,EX
	BRA.S NO_P
PAS_1	CMP.B #'T',D0
	BNE NO_P
	CMP.B #'O',D1
	BNE NO_P
	CMP.B #'S',D2
	BNE NO_P
	MOVE.W #-1,EX
NO_P	BSR LOAD_IT
	BSR PACK_F
	BSR SAVE_IT
	RTS
PATH	DC.B '*.*'
	DS.B 45
B_FILE	DS.B 256		
FAIL_LD	BSR CLR
	LEA FAILT,A3
	BSR T
	BSR RETARD
	BSR RETARD
	BRA ST_C
CRU_S	CLR.W EX
	BSR CLR
	LEA EXE,A3
	BSR T
MAS_K	MOVE.W #7,-(A7)
	TRAP #1
	LEA 2(A7),A7
	CMP.B #'1',D0
	BEQ EXEC
	CMP.B #'2',D0
	BEQ NEXEC
	BRA.S MAS_K
GO_GEM	BSR CLS
	BSR GET_AL
	CLR.L -(A7)
	TRAP #1
EXEC	MOVE.W #-1,EX
NEXEC	BSR CLR
	LEA CRUN_SE,A3
	BSR T
	LEA B_1,A4
	MOVEQ.L #26-1,D4
	BSR INPUT
	LEA LINEA,A3
	BSR T
	BSR LOAD_IT
	BSR PACK_F
	MOVE.L SCREEN,T_SC
	ADD.L #8*8*160,T_SC
	LEA PERES,A3
	BSR T
	MOVE.W #7,-(A7)
	TRAP #1
	LEA 2(A7),A7
	BSR CLR
	LEA CRU_SS,A3
	BSR T
	MOVEQ.L #26-1,D4
	LEA B_1,A4
	BSR INPUT
	BSR SAVE_IT
E_CRU_S	BSR CLR
	BSR MAS_F
	CLR.L -(A7)
	TRAP #1
PACK_F	BSR CLR
	BSR INT_OFF
	MOVE.W #$000,$FFFF8240.W
	MOVE.W #$777,$FFFF8240+2.W
	MOVE.L SCREEN,T_SC
	LEA PACKIN1,A3
	BSR T
	LEA B_1,A3
	BSR T
	MOVE.L SCREEN,T_SC
	ADD.L #8*2*160,T_SC
	CLR.W CDC
	LEA PACKIN2,A3
	BSR T
	MOVE.L T_SC,P_SC
	MOVE.L S_FILE,P_START
	MOVE.L E_FILE,P_END
	MOVE.L S_FILE,P_PACK
	MOVE.L P_START,D0
	MOVE.L P_END,D1
	BSR CRUNCH
	MOVE.L A2,OLDDES
	MOVE.L P_SC,T_SC
	LEA CERO,A3
	BSR T
	MOVE.L P_START,D1
	MOVE.L P_END,D0
	SUB.L D1,D0
	BSR TEXTS
	MOVE.L SCREEN,T_SC
	ADD.L #8*5*160,T_SC
	LEA INFO_P1,A3
	CLR.W CDC
	BSR T
	LEA TO_GO,A3
	BSR T
	MOVE.L P_PACK,A0
	MOVE.L OLDDES,D0
	SUB.L A0,D0
	MOVE.L D0,LONG_P
	BSR TEXTS
	MOVE.L SCREEN,T_SC
	ADD.L #8*6*160,T_SC
	CLR.W CDC
	LEA INFO_P2,A3
	BSR T
	LEA TO_GO,A3
	BSR T
	CLR.W $FFFF8240.W
	BSR INT_ON
	RTS
CLR	CLR.W CDC
	MOVE.L SCREEN,T_SC
	BSR CLS
	RTS
MAS_F	LEA PREG,A3
	BSR T
	MOVE.W #7,-(A7)
	TRAP #1
	LEA 2(A7),A7
	CMP.B #'N',D0
	BEQ ST_C
	CMP.B #'n',D0
	BEQ ST_C
	BRA CRU_S
RETARD	MOVE.W #10,D1
ASRR	MOVE.W #-1,D0
ASR	DBF D0,ASR
	DBF D1,ASRR
	RTS
LOAD_IT	CLR.W -(A7)
	PEA B_1
	MOVE.W #$3D,-(A7)
	TRAP #1
	LEA 8(A7),A7
	TST.W D0
	BMI FAIL_L
	MOVE.W D0,-(A7)
	PEA FILE
	PEA $FFFFFF
	MOVE.W D0,-(A7)
	MOVE.W #$3F,-(A7)
	TRAP #1
	LEA 12(A7),A7
	MOVE.L #FILE,S_FILE
	LEA FILE,A0
	ADDA.L D0,A0
	MOVE.L A0,E_FILE
	MOVE.W #$3E,-(A7)
	TRAP #1
	LEA 4(A7),A7
	RTS
SAVE_AL	MOVE.W #$2700,SR
	MOVEM.L $FFFF8240.W,D0-D7
	MOVEM.L D0-D7,OLDPAL
	MOVE.B $484.W,OLDTI
	CLR.B $484.W
	MOVE.W #$2300,SR
	RTS
GET_AL	MOVEM.L OLDPAL,D0-D7
	MOVEM.L D0-D7,$FFFF8240.W
	MOVE.B OLDTI,$484.W
	RTS
OLDPAL	DS.W 16
OLDTI	DS.W 1
OOLD70	DS.L 1
OO7	DS.B 1
OO9	DS.B 1
SAVE_IT	MOVE.L P_PACK,INIT
	TST.W EX
	BEQ NAHH
	MOVE.L #XEC_DA,INIT 
	MOVE.L LONG_P,$1E+XEC_DA
	ADD.L #FILE-XEC_DA,LONG_P
	MOVE.L LONG_P,$2+XEC_DA
	MOVEA.L INIT,A3
	ADDA.L LONG_P,A3
	CLR.L (A3)+
	CLR.L (A3)+
	CLR.L (A3)+
NAHH	CLR.W -(A7)
	PEA B_1
	MOVE.W #$3C,-(A7)
	TRAP #1
	LEA 8(A7),A7
	TST.W D0
	BMI FAIL_S
	MOVE.W D0,-(A7)
	MOVE.L INIT,-(A7)
	MOVE.L LONG_P,-(A7)
	MOVE.W D0,-(A7)
	MOVE.W #$40,-(A7)
	TRAP #1
	LEA 12(A7),A7
	TST.W D0
	BMI FAIL_S
	LEA FILE,A0
	ADDA.L D0,A0
	MOVE.L A0,E_FILE
	MOVE.W #$3E,-(A7)
	TRAP #1
	LEA 4(A7),A7
	RTS
FAIL_L	CLR.W CDC
	BSR CLS
	MOVE.L SCREEN,T_SC
	LEA FAIL,A3
	BSR T
	BRA E_CRU_S
FAIL_S	CLR.W CDC
	BSR CLS
	MOVE.L SCREEN,T_SC
	LEA FAILS,A3
	BSR T
	BRA E_CRU_S
INT_OFF	MOVE.W SR,O_SR
	MOVE.W #$2700,SR
	MOVE.B $FFFFFA07.W,OLD7
	MOVE.B $FFFFFA09.W,OLD9
	MOVE.L $70.W,OLD70
	CLR.B $FFFFFA07.W
	CLR.B $FFFFFA09.W
	MOVE.L #N_70,$70.W
	MOVE.W #$2300,SR
	RTS
N_70	RTE
INT_ON	STOP #$2300
	MOVE.W #$2700,SR
	MOVE.B OLD7,$FFFFFA07.W
	MOVE.B OLD9,$FFFFFA09.W
	MOVE.L OLD70,$70.W
	MOVE.W O_SR,SR
	RTS
CLS	MOVEA.L SCREEN,A0
	LEA $7D00(A0),A1
BORRA_S	CLR.L (A0)+
	CMPA.L A0,A1
	BGT BORRA_S
	RTS
CRUNCH	MOVEA.L	P_START,A0
	MOVEA.L	P_PACK,A2
	MOVEA.L	P_END,A1
	MOVEQ	#1,D2
	CLR.W	D1
	MOVEQ	#0,D7
LD7F6	BSR.S	LD844
	TST.B	D0
	BEQ.S	LD808
	ADDQ.W	#1,D1
	CMPI.W	#$108,D1
	BNE.S	LD808
	BSR	LD906
LD808	ADDQ.W #1,C_STEP
	MOVE.W C_STEP,D7
	CMP.W #3,D7
	BNE.S PAAA 
	MOVE.W #-1,C_STEP
	MOVEM.L A0-A6/D0-D7,-(A7)
	MOVE.L A1,D0
	SUB.L A0,D0
	BSR TEXTS
	MOVE.L P_SC,T_SC
	LEA TO_GO,A3
	BSR T	 
	MOVEM.L (A7)+,A0-A6/D0-D7
PAAA	CMPA.L	A0,A1
	BGT.S	LD7F6
	BSR	LD906
	BSR	LD940
	MOVE.L	D7,(A2)+
	MOVE.L P_PACK,D1
	MOVE.L P_END,D2
	SUB.L D1,D2
	MOVE.L	D2,(A2)+
	MOVE.L #'JEK!',(A2)+
	RTS
LD844	MOVEA.L	A0,A3
	ADDA.L	TROZO,A3
	CMPA.L	A1,A3
	BLE.S	LD850
	MOVEA.L	A1,A3
LD850	MOVEQ	#1,D5
	MOVEA.L	A0,A5
	ADDQ.W	#1,A5
LD856	MOVE.B	(A0),D3
	MOVE.B	1(A0),D4
LD85C	CMP.B	(A5)+,D3
	BNE.S	LD864
	ADDQ.W #$001,$FFFF8240.W
	CMP.B	(A5),D4
	BEQ.S	LD86A
LD864	CMPA.L	A5,A3
	BGT.S	LD85C
	BRA.S	LD8C4
LD86A	SUBQ.W	#1,A5
	MOVEA.L	A0,A4
LD86E	MOVE.B	(A4)+,D3
	CMP.B	(A5)+,D3
	BNE.S	LD878
	CMPA.L	A5,A3
	BGT.S	LD86E
LD878	MOVE.L	A4,D3
	SUB.L	A0,D3
	SUBQ.L	#1,D3
	CMP.L	D3,D5
	BGE.S	LD8C0
	MOVE.L	A5,D4
	SUB.L	A0,D4
	SUB.L	D3,D4
	SUBQ.W	#1,D4
	CMPI.L	#4,D3
	BLE.S	LD8A2
	MOVEQ	#6,D6
	CMPI.L	#$101,D3
	BLT.S	LD8A0
	MOVE.W	#$100,D3
LD8A0	BRA.S	LD8A8
LD8A2	MOVE.W	D3,D6
	SUBQ.W	#2,D6
	LSL.W	#1,D6
LD8A8	LEA	C_DATA(PC),A6
	CMP.W	0(A6,D6.W),D4
	BGE.S	LD8C0
	MOVE.L	D3,D5
	MOVE.L	D4,DATA0
	MOVE.B	D6,DATA1
LD8C0	CMPA.L	A5,A3
	BGT.S	LD856
LD8C4	CMPI.L	#1,D5
	BEQ.S	LD8FC
	BSR.S	LD906
	MOVE.B	DATA1(PC),D6
	MOVE.L	DATA0(PC),D3
	MOVE.W	8(A6,D6.W),D0
	BSR.S	LD932
	MOVE.W	$10(A6,D6.W),D0
	BEQ.S	LD8E8
	MOVE.L	D5,D3
	SUBQ.W	#1,D3
	BSR.S	LD932
LD8E8	MOVE.W	$18(A6,D6.W),D0
	MOVE.W	$20(A6,D6.W),D3
	BSR.S	LD932
	ADDQ.W	#1,$28(A6,D6.W)
	ADDA.L	D5,A0
	CLR.B	D0
	RTS
LD8FC	MOVE.B	(A0)+,D3
	MOVEQ	#8,D0
	BSR.S	LD932
	MOVEQ	#1,D0
	RTS
LD906	TST.W	D1
	BEQ.S	LD920
	MOVE.W	D1,D3
	CLR.W	D1
	CMPI.W	#9,D3
	BGE.S	LD922
	ADDQ.W	#1,C_DATA+48
	SUBQ.W	#1,D3
	MOVEQ	#5,D0
	BRA.S	LD932
LD920	RTS
LD922	ADDQ.W	#1,C_DATA+50
	SUBI.W	#9,D3
	ORI.W	#$700,D3
	MOVEQ	#$B,D0
LD932	SUBQ.W	#1,D0
LD934	LSR.L	#1,D3
	ROXL.L	#1,D2
	BCS.S	LD942
	DBF	D0,LD934
	RTS
LD940	CLR.W	D0
LD942	MOVE.L	D2,(A2)+
	MOVE.W	D2,C_DATA+250
	EOR.L	D2,D7
	MOVEQ	#1,D2
	DBF	D0,LD934
	RTS
TEXTS	LEA TO_GO(PC),A0
	MOVEQ.L #10,D1
	CLR.L (A0)+
	CLR.L (A0)+
QLOOP1	DIVU D1,D0
	SWAP D0
	ADDI #'0',D0
	CMPI #'9',D0
	BLE QOK
	ADDQ #7,D0
QOK 	MOVE.B D0,-(A0)
	CLR.W D0
	SWAP D0
	BNE QLOOP1
YUU	CMPA.L #TO_GO,A0
	BEQ.S FUERA
	MOVE.B #' ',-(A0)
	BRA.S YUU
FUERA	RTS
T	LEA FONT,A0
	MOVEA.L T_SC,A1
	BSR TEXT
	RTS
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
	CLR.W CDC
	BRA OTROC
NRETURN CMP.B #'\',D0
	BNE AAOND4
	MOVE.B #40,D0
	BRA TODOL
AAOND4	CMP.B #'_',D0
	BNE AAND4
	MOVE.B #41,D0
	BRA TODOL
AAND4	CMP.B #'A',D0
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
	RTS
MENOR	CMP.B #'.',D0
	BNE COND4
	MOVE.B #38,D0
	BRA TODOL
COND4	CMP.B #'+',D0
	BNE D4
	MOVE.B #42,D0
	BRA TODOL
D4	CMP.B #'-',D0
	BNE COND4A
	MOVE.B #43,D0
	BRA TODOL
COND4A	CMP.B #'=',D0
	BNE OND4A
	MOVE.B #44,D0
	BRA TODOL
OND4A	CMP.B #'?',D0
	BNE ND4A
	MOVE.B #45,D0
	BRA TODOL
ND4A	CMP.B #'(',D0
	BNE D4A
	MOVE.B #46,D0
	BRA TODOL
D4A	CMP.B #')',D0
	BNE AD4A
	MOVE.B #47,D0
	BRA TODOL
AD4A	CMP.B #',',D0
	BNE AAD4A
	MOVE.B #48,D0
	BRA TODOL
AAD4A	CMP.B #'!',D0
	BNE COND5
	MOVE.B #37,D0
	BRA TODOL
COND5	CMP.B #"'",D0
	BNE CD5
	MOVE.B #49,D0
	BRA TODOL
CD5	CMP.B #'"',D0
	BNE CDO5
	MOVE.B #50,D0
	BRA TODOL
CDO5	CMP.B #':',D0
	BNE COND6
	MOVE.B #36,D0
	BRA TODOL
COND6	SUB.B #'0',D0
	ADD.B #26,D0
	BRA TODOL
	LEA B_1,A4
	MOVEQ.L #24-1,D4
	BSR INPUT
INPUT	CLR.W CDC
	MOVE.L #0,(A4)
	MOVE.L #0,4(A4)
	MOVE.L #0,8(A4)
	MOVE.L #0,12(A4)
	MOVE.L #0,16(A4)
	MOVE.W #0,24(A4)
	MOVE.L T_SC,OSC
	MOVEM.L D4/A4,B_SEG
AINPUT	MOVE.W #7,-(A7)
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
SPACE	DC.B '                           ',0
B_1	DS.B 26       	
TO_GO	DS.B 10	
OLD7	DS.B 1
LONG_P	DS.L 1
OLD9	DS.B 1
OSC	DS.L 1
REGS	DS.L 2
B_SEG	DS.L 2
OLD70	DS.L 1
INIT	DS.L 1
O_SR	DS.W 1
T_SC	DS.L 1
SCREEN	DS.L 1
SCREE	DS.L 1
CDC	DS.W 1
S_FILE	DS.L 1
E_FILE	DS.L 1
OLDDES	DS.L 1
C_STEP 	DC.W -1
P_SC	DS.L 1
P_START	DS.L 1
P_END	DS.L 1
EX	DS.W 1
P_PACK	DS.L 1
TROZO	DC.L $1000
DATA0	DS.L 1
DATA1	DS.W 1
LINEA	DC.B $A,$A,0
CERO	DC.B '       0',0
WELLCO	DC.B 'WELLCOME TO THE R-JEK PACKER, MADE BY ',$A
	DC.B 'JEK. FINAL MODIFICATIONS BY RED DEVIL ',$A,$A
	DC.B 'OK, CHOOSE: ',$A,$A,$A
	DC.B ' 1- CRUNCH SOME FILES.',$A
	DC.B ' 2- CRUNCH A WHOLE DISK (ALL FILES).',$A
	DC.B ' 3- MUZAK (ON\OFF). ',$A
	DC.B ' 4- EXIT TO GEM.',$A                               
	DC.B 0 
FAILT	DC.B 'END OF PROCESS. NO ERRORS',0
CRUN_SE	DC.B 'ENTER NAME OF SOURCE FILE TO PACK:',$A,0
CRU_SS	DC.B 'ENTER NAME OF DESTINATION FILE:',$A,0,0
EXE	DC.B 'TYPE OF FILE TO PACK:',$A,$A
	DC.B ' 1-EXECUTABLE FILE',$A
	DC.B ' 2-DATA FILE',$A,0
PACKIN1	DC.B 'PACKING FILE: ',0
PACKIN2	DC.B 'PLEASE WAIT...',$A
	DC.B 'BYTES TO GO: ',0
	DC.B 0
PERES	DC.B 'FILE PACKED, PRESS A KEY...',0 
PREG	DC.B 'DO YOU WANT TO PACK ANOTHER FILE? (Y\N)',$A,0
FAIL	DC.B 'ERROR:FILE NOT FOUND',$A,$A,0
FAILS	DC.B 'ERROR DURING SAVING FILE',$A,$A,0
INFO_P1	DC.B 'ORIGINAL LENGTH:',0
INFO_P2	DC.B 'PACKED LENGTH:  ',0
FONT	INCBIN 'A:FONT8P2.RED'
C_DATA	INCBIN 'A:DATAP.DAT'
XEC_DA	INCBIN 'A:EXEC.DAT'
FILE	




	
	