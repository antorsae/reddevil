	CLR.L -(A7)
	MOVE.W #$20,-(A7)
	TRAP #1
	LEA 6(A7),A7
	BSR HBLON
WAIT	CLR.B SYNC
VSYNC	TST.B SYNC
	BEQ.S VSYNC
	MOVE.L #$18000,D0
	LSR.L #8,D0
	MOVE.B D0,$FFFF8203.W
	LSR.W #8,D0
	MOVE.B D0,$FFFF8201.W
	CMP.B #$39,$FFFFFC02.W
	BNE.S WAIT
	BSR HBLOFF
	CLR.L -(A7)
	TRAP #1
HBLON	MOVE.W #$2700,SR
	MOVE.L $70.W,OLD70
	MOVE.L $120.W,OLD120
	MOVE.B $FFFFFA07.W,OLD7
	MOVE.B $FFFFFA09.W,OLD9
	CLR.B $FFFFFA07.W
	CLR.B $FFFFFA09.W
	MOVE.L #VBL,$70
	MOVE.W #$2300,SR
	RTS
HBLOFF	MOVE.W #$2700,SR
	MOVE.B OLD7,$FFFFFA07.W
	MOVE.B OLD9,$FFFFFA09.W
	MOVE.L OLD120,$120.W
	MOVE.L OLD70,$70.W
	MOVE.W #$2300,SR
	RTS
VBL	ST SYNC
	MOVE.B #0,$FFFF820A.W
	MOVE.L #HBL1,$120.W
	CLR.B $FFFFFA1B.W
	MOVE.B #1,$FFFFFA21.W
	MOVE.B #8,$FFFFFA1B.W
	OR.B #1,$FFFFFA07.W
	OR.B #1,$FFFFFA13.W
	RTE
HBL1	MOVE.B #2,$FFFF820A.W
	CLR.B $FFFFFA1B.W
	MOVE.B #228,$FFFFFA21.W
	MOVE.B #8,$FFFFFA1B.W
	MOVE.L #HBL2,$120.W
	BCLR #0,$FFFFFA0F.W
	RTE
HBL2	MOVE.B #0,$FFFF820A.W
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVE.B #2,$FFFF820A.W
	CLR.B $FFFFFA1B.W
	MOVE.B #1,$FFFFFA21.W
	MOVE.B #8,$FFFFFA1B.W
	MOVE.L #HBL3,$120.W
	BCLR #0,$FFFFFA0F.W
	RTE
HBL3	MOVE.B #2,$FFFF820A.W
	CLR.B $FFFFFA1B.W
	BCLR #0,$FFFFFA0F.W
	RTE
OLD70	DS.L 1
OLD120	DS.L 1
SYNC	DS.W 1
OLD7	DS.B 1
OLD9	DS.B 1

	
	
	 