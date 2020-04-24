BASE 	EQU $F8000
	PEA 0
	MOVE.W #$20,-(A7)
	TRAP #1
	LEA $2000,A7
	MOVEM.L OFONT(PC),D0-D7
	MOVEM.L D0-D7,$FFFF8240.W
	BSR CLS
	BSR PREPFNT
	LEA MES1(PC),A0
	LEA LMES1(PC),A1
	BSR CODECAD
	BSR CLS
	LEA LMES1(PC),A0
	LEA BASE,A1
	BSR PRINT
	PEA 0 
	TRAP #1

CLS	LEA BASE,A0
	LEA BASE+32000,A1
LKK	CLR.L (A0)+
	CMPA.L A0,A1
	BGT.S LKK
	RTS

PREPFNT	INCLUDE 'PREPAREF.S'

CODECAD	LEA CHARLLE(PC),A2
	LEA CHARSIM(PC),A3
	MOVEQ #0,D0
	MOVE.B (A0)+,D0
	MOVEQ #0,D1
	MOVE.B (A0)+,D1
	MOVE.W D1,(A1)+
	ADD.W D0,D0
	LEA FONTIND(PC,D0.W),A4
	MOVE.W (A4),D0
	MOVE.W #(40*6*2*2*2)+(40*6*2*2*2),D1
	MOVEQ #6*2,D2
DECODE	MOVE.B (A0)+,D3
	BPL.S NOENDDE
	MOVE.W #-1,(A1)
	RTS
FONTIND	DC.W 0
	DC.W (40*6*2*2)
	DC.W (40*6*2*2*2)
	DC.W (40*6*2*2*2)+(40*6*2*2)
NOENDDE	CMP.B #'^',D3
	BLT.S MAYU
	CMP.B #'}',D3
	BGT.S MAYU
	LEA (A3),A4
	MOVE.L #$FFFF,D5
SEARCHN	MOVE.B (A4)+,D4
	CMP.B #-1,D4
	BEQ.S NFOUNDN
	ADDQ.W #1,D5
	CMP.B D4,D3
	BNE.S SEARCHN
NFOUNDN	MULU D2,D5
	ADD.W D1,D5
	MOVE.W D5,(A1)+
	BRA.S DECODE
MAYU	LEA (A2),A4
	MOVE.L #$FFFF,D5
SEARCHM	MOVE.B (A4)+,D4
	CMP.B #-1,D4
	BEQ.S NFOUNDM
	ADDQ.W #1,D5
	CMP.B D4,D3
	BNE.S SEARCHM
NFOUNDM	MULU D2,D5
	ADD.W D0,D5
	MOVE.W D5,(A1)+
	BRA.S DECODE
PRINT	LEA FONT(PC),A2
	MOVE.W (A0)+,D0
	MOVE.W D0,D2
	MOVE.W D0,D4
	SUBQ.W #1,D0
	LSR.W #1,D4	
PRINTX	MOVE.W (A0)+,D1
	BPL.S GOON1
	RTS
GOON1	LEA 0(A2,D1.W),A3
	SUBQ.W #2,D2
	BPL.S PIT1
	MOVEQ #20,D2
	SUB.W D4,D2
	LSL.W #3,D2
	ADD.W #160*5,D2
	LEA 0(A1,D2.W),A1
	MOVE.W D0,D2
PIT1	MOVE.B (A3)+,(A1)
	MOVE.B (A3)+,2(A1)
	MOVE.B (A3)+,(160*1)(A1)
	MOVE.B (A3)+,(160*1)+2(A1)
	MOVE.B (A3)+,(160*2)(A1)
	MOVE.B (A3)+,(160*2)+2(A1)
	MOVE.B (A3)+,(160*3)(A1)
	MOVE.B (A3)+,(160*3)+2(A1)
	MOVE.B (A3)+,(160*4)(A1)
	MOVE.B (A3)+,(160*4)+2(A1)
	MOVE.B (A3)+,(160*5)(A1)
	MOVE.B (A3)+,(160*5)+2(A1)
	ADDQ.L #1,A1
	MOVE.W (A0)+,D1
	BPL.S GOON2
	RTS
GOON2	LEA 0(A2,D1.W),A3
	MOVE.B (A3)+,(A1)
	MOVE.B (A3)+,2(A1)
	MOVE.B (A3)+,(160*1)(A1)
	MOVE.B (A3)+,(160*1)+2(A1)
	MOVE.B (A3)+,(160*2)(A1)
	MOVE.B (A3)+,(160*2)+2(A1)
	MOVE.B (A3)+,(160*3)(A1)
	MOVE.B (A3)+,(160*3)+2(A1)
	MOVE.B (A3)+,(160*4)(A1)
	MOVE.B (A3)+,(160*4)+2(A1)
	MOVE.B (A3)+,(160*5)(A1)
	MOVE.B (A3)+,(160*5)+2(A1)
	ADDQ.L #7,A1
	BRA PRINTX
CHARLLE	DC.B 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[]$%/\@*()-+=:"!,.?>< ',-1
CHARSIM	DC.B "abcdefghijklmnopqrstuvwxyz{|}_^",-1
OFONT	INCBIN 'CHARSET.BIN'
MES1	DC.B 3,40
	DC.B 'abbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbc'
	DC.B 'm  DRAWING TOOLS         kgggggggggo   n'
	DC.B 'm ussssss_ssssssv        i  BLOCK  j   n'
	DC.B 'm qDRAW  yPOINT r        phhhhhhhhhl   n'
	DC.B 'm {zzzzzz}zzzzzz|                      n'
	DC.B 'm qSPRAY yLINE  r        kgggggggggo   n'
	DC.B 'm {zzzzzz}zzzzzz|        i  DESIGN j   n'
	DC.B 'm qKLINE yFILL  r        i  BRUSH  j   n'
	DC.B 'm {zzzzzz}zzzzzz|        phhhhhhhhhl   n'
	DC.B 'm qRAY   yBOX   r                      n'
	DC.B 'm {zzzzzz}zzzzzz|        kgggggggggo   n'
	DC.B 'm qCIRCLEyDISC  r        i  ZOOM   j   n'
	DC.B 'm {zzzzzz}zzzzzz|        phhhhhhhhhl   n'
	DC.B 'm qBLOCK yBRUSH r                      n'
	DC.B 'm wtttttt^ttttttx        kgggggggggo   n'
	DC.B 'm ussssss_ssssssv        iPIXEL FX.j   n'
	DC.B 'm qNORMALyBLOCK r        phhhhhhhhhl   n'
	DC.B 'm {zzzzzz}zzzzzz|                      n'
	DC.B 'm qBRUSH yDELETEr        kgggggggggo   n'
	DC.B 'm wtttttt^ttttttx        i RASTERS j   n'
	DC.B 'm ussssss_ssssssv        phhhhhhhhhl   n'
	DC.B 'm qTEXT  yCHANGEr                      n'
	DC.B 'm wtttttt^ttttttx        kgggggggggo   n'
	DC.B 'm ussssss_ss_s_sv        i COLORS  j   n'
	DC.B 'm qSCREENy00y[y]r        phhhhhhhhhl   n'
	DC.B 'm wtttttt^tt^t^tx                      n'
	DC.B 'm                        kgggggggggo   n'
	DC.B 'm                        iLOAD/SAVEj   n'
	DC.B 'm                        phhhhhhhhhl   n'
	

	DC.B -1,0
EMES1
LMES1	DS.W EMES1-MES1-2
FONT
FNORMAL	EQU FONT
FROTA	EQU FONT+(40*6*2*2)
FFONDO	EQU FONT+(40*6*2*2*2)
FDFONDO	EQU FONT+(40*6*2*2*2)+(40*6*2*2)
RSCS	EQU FONT+(40*6*2*2*2)+(40*6*2*2*2)

