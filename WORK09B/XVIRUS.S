	PEA INIT
	MOVE.W #9,-(A7)
	TRAP #1
	ADDA.L #6,A7
	
AGAIN	PEA EXT0
	MOVE.W #9,-(A7)
	TRAP #1
	ADDA.L #6,A7
	MOVE.W #7,-(A7)
	TRAP #1
	ADDA.L #2,A7
	MOVE.W #1,-(A7)
	MOVE.W #0,-(A7)
	MOVE.W #0,-(A7)
	MOVE.W #1,-(A7)
	MOVE.W #0,-(A7)
	MOVE.L #0,-(A7)
	MOVE.L #BUFF2,-(A7)
	MOVE.W #8,-(A7)
	TRAP #14
	ADDA.L #20,A7	
	MOVE.W #$6038,BUFF
	LEA BUFF+2,A1
	LEA INDEX,A0
	MOVE.L (A0)+,(A1)+
	MOVE.W (A0)+,(A1)+
	LEA BUFF2+8,A0
	LEA BUFF+8,A1
	MOVE.W #27-1-6,D0
COPIA	MOVE.B (A0)+,(A1)+
	DBF D0,COPIA
	LEA BUFF+$38+2,A1
	LEA CODE,A0
	LEA CODE,A3
COP	MOVE.B (A0)+,(A1)+	
	CMPA.L A1,A3
	BNE COP
	LEA BUFF,A0
	CLR.L D0	
	MOVE.W #(510/2)-1,D3
BUC	MOVE.W (A0)+,D1
	ADD.W D1,D0
	DBF D3,BUC
	MOVE.W #$1234,D1
	SUB.W D0,D1
	MOVE.W D1,CODE-2
	MOVE.W #1,-(A7)
	MOVE.W #0,-(A7)
	MOVE.W #0,-(A7)
	MOVE.W #1,-(A7)
	MOVE.W #0,-(A7)
	MOVE.L #0,-(A7)
	MOVE.L #BUFF,-(A7)
	MOVE.W #9,-(A7)
	TRAP #14
	ADDA.L #20,A7
	BRA AGAIN
BUFF	DS.B 512
CODE	TST.L $42A
	BNE.S VIRUS
SIGUE	PEA TEXT(PC)
	MOVE.W #9,-(SP)
	TRAP #1
	ADDA.L #6,SP
	MOVE.L #$600FF,-(A7)
	TRAP #1
	ADDQ.W #4,A7
	CMP.W #" ",D0
	SEQ $482
	RTS
VIRUS	PEA TEXT1(PC)
	MOVE.W #9,-(A7)
	TRAP #1
	ADDA.L #6,A7
	MOVE.L #$07000000,$FFFF8240.W
MEE	BRA.S MEE
TEXT1	DC.B "Virus in reset-vector!",$A,$D,0
TEXT	DC.B "Red Devil Working Disk 2.",$a,$d,0
INDEX	DC.B 'LAMER!'
BUFF2	DS.B 512
EXT0	DC.B "INSERT DISK "
EXT1	DC.B "AND PRESS ANY KEY",$A,$D,$A,$D,0
INIT	DC.B "HOLA, ESTE PROGRAMA SIRVE PARA",$A,$D
	DC.B "INSERTAR UN ANTIVIRUS EN UN",$A,$D 
	DC.B "DISCO (SIEMPRE QUE SEA POR",$A,$D
	DC.B "FICHEROS).",$A,$D,$A,$D,0              