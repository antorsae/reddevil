	pea INT
	MOVE.W #3,-(A7)
	MOVE.W #8,-(A7)
	MOVE.W #1,-(A7)
	MOVE.W #$1F,-(A7)
	TRAP #14
	ADDA.L #$C,A7 
	NOP
INT	MOVEM.L D0/A0,-(A7)
	MOVE.W DATA0,D0
	LEA COLS,A0
	MOVE.W 0(A0,D0.W),$FF825C
	SUBQ.W	#2,D0
	BPL.S CONT
	MOVE.W #$82,D0
CONT	MOVE.W D0,DATA0
	MOVEM.L (A7)+,D0/A0
	BCLR	#0,$FFFA0F
	RTE
DATA0	DC.W $5C
COLS	DC.W $700,$701,$702,$703,$704,$705,$706,$707,$617
	DC.W $527,$437,$347,$257,$167,$077,$076,$075,$074
	DC.W $073,$072,$071,$070,$070,$170,$270,$370,$470
	DC.W $570,$670,$770,$671,$572,$473,$374,$275,$176
	DC.W $077,$166,$255,$344,$433,$522,$611,$700,$710
	DC.W $720,$730,$740,$750,$760,$770,$661,$552,$443
	DC.W $334,$225,$116,$007,$106,$205,$304,$403,$502
	DC.W $601,$700,$600,$500,$600,$700,$323,$555,$232
	DC.W $777,$666,$555,$444,$343,$545,$323,$555,$232
	DC.W $777,$666,$555,$444,$343,$545,$323,$555,$232
	