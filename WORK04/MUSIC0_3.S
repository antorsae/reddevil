	CLR.L -(A7)
	MOVE.W #$20,-(A7)
	TRAP #1
	ADDA.L #6,A7
	CLR.B $484
	BSR CM1
	NOP
;A0,A1,D7,LONG,A2 DIR,D1 INT

CALL	CLR.L $4D2
	MOVE.B (A0)+,(A1)+
	DBF D7,CALL
	JSR (A2)
	MOVE.L D1,$4D2
	RTS
CM1	LEA MUSIC1,A0
	LEA $70000,A1
	MOVE.L #0,D0
	MOVE.W #$7000,D7
	LEA $70676,A2
	MOVE.L #$70684,D1
	BSR CALL
	RTS
CM2	LEA MUSIC1,A0
	LEA $70000,A1
	MOVE.L #1,D0
	MOVE.W #$7000,D7
	LEA $70676,A2
	MOVE.L #$70684,D1
	BSR CALL
	RTS
CM3	LEA MUSIC1,A0
	LEA $70000,A1
	MOVE.L #2,D0
	MOVE.W #$7000,D7
	LEA $70676,A2
	MOVE.L #$70684,D1
	BSR CALL
	RTS
CM4	LEA MUSIC1,A0
	LEA $70000,A1
	MOVE.L #3,D0
	MOVE.W #$7000,D7
	LEA $70676,A2
	MOVE.L #$70684,D1
	BSR CALL
	RTS
MUSIC1	INCBIN 'MUSIC.WOW'
