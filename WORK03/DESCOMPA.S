START
 MOVE.L A7,A5
 MOVE.L #$77FFE,A7
 MOVE.L 4(A5),A5
 MOVE.L $C(A5),D0
 ADD.L $14(A5),D0
 ADD.L $1C(A5),D0
 ADD.L #$100,D0
 MOVE.L D0,-(SP)
 MOVE.L A5,-(SP)
 CLR.W -(SP)
 MOVE.W #$4A,-(SP)
 TRAP #1
 ADD.L #12,SP
 CLR.L -(SP)
 MOVE.W #$20,-(SP)
 TRAP #1
 ADDQ.L #6,SP
 CLR.W -(SP)
 PEA -1
 PEA -1
 MOVE.W #5,-(SP)
 TRAP #14
 ADD.L #12,SP
 DC.W $A00A
 MOVE.L $84,VAL_VECT+2
 LEA G,A0
 LEA $2000,A1
 MOVE.W #550,D0
BUC3:
 MOVE.B (A0)+,(A1)+
 DBRA D0,BUC3 
 MOVE.L #$2002,$84
 PEA texto(pc)
 move.w #9,-(sp)
 trap #1
 addq.l #6,sp
 move.w #7,-(sp)
 trap #1
 addq.l #2,sp
 PEA HANDLE
 PEA HANDLE
 PEA FILE
 CLR.W -(SP)
 MOVE.W #$4B,-(SP)
 TRAP #1
 ADD.L #12,SP
G:
 DS.W 1
RUT_VECT: 
 MOVEM.L D0-D6/A0-A6,$1000
 MOVEA.L A7,A1
 ADDQ.L #6,A1
 MOVE.W (A7),D0
 BTST #$D,D0
 BNE.S A
 MOVE.L USP,A1
A:
 NOP
 CMPI.W #$3D,(A1)
 BNE B
 MOVE.W #0,$2000
 MOVEA.L 2(A1),A1
 CMPI.B #$3A,1(A1)
 BNE.S C
 ADDQ.L #2,A1
C:
 CMPI.B #$5C,(A1)
 BNE.S D
 ADDQ.L #1,A1
D:
 MOVEA.L A1,A2
E:
 CMPI.B #$2E,(A2)+
 BNE.S E
 CMPI.B #$70,1(A2)
 BEQ.S F
 CMPI.B #$50,1(A2)
 BNE.S H
F:
  MOVE.W #-1,$2000
H:
 MOVEM.L $1000,D0-D6/A0-A6
VAL_VECT: 
 JMP 0
 DS.L 1
B:
 CMPI.W #$3E,(A1)
 BEQ.S I
 CMPI.W #$3F,(A1)
 BNE.S H
 CMPI.W #0,$2000
 BNE.S H
 MOVE.L 8(A1),$206E
 BRA.S H
I: 
 CMPI.W #0,$2000
 BNE.S H
 MOVEA.L $206E,A1
 MOVEA.L $206E,A0
 SUB.L #4,$1000
 ADD.L $1000,A0
 LEA DF(PC),A2
 MOVE.L A0,(A2)+
 MOVE.L A1,(A2)
 CMP.L #$4A454B21,(A0)
 BNE H
 BSR RUTINA
 BRA H
RUTINA: 
 LEA BUF2(PC),A2
 MOVEA.L -(A0),A2
 LEA BUF1(PC),A3
 MOVE.L A2,(A3)
 ADDA.L A1,A2
 LEA BUF3(PC),A3
 MOVE.L A2,(A3)
 MOVE.L -(A0),D5
 MOVE.L -(A0),D0
 EOR.L D0,D5
N1:
 LSR.L #1,D0
 BNE.S A1
 BSR B1
A1:
 BCS.S Q1
 MOVEQ #8,D1
 MOVEQ #1,D3
 LSR.L #1,D0
 BNE.S C1
 BSR B1
C1:
 BCS.S L1
 MOVEQ #3,D1
 CLR.W D4
I1:
 BSR D1
 MOVE.W D2,D3
 ADD.W D4,D3
G1:
 MOVEQ #7,D1
F1:
 LSR.L #1,D0
 BNE.S E1
 BSR B1
E1:
 ROXL.L #1,D2
 DBRA D1,F1
 MOVE.B D2,-(A2)
 DBRA D3,G1
 BRA H1
K1:
 MOVEQ #8,D1
 MOVEQ #8,D4
 BRA.S I1
Q1: 
 MOVEQ #2,D1
 BSR D1
 CMP.B #2,D2
 BLT.S J1
 CMP.B #3,D2
 BEQ.S K1
 MOVEQ #8,D1
 BSR D1
 MOVE.W D2,D3
 MOVE.W #$C,D1
 BRA L1
J1:
 MOVE.W #9,D1
 ADD.W D2,D1
 ADDQ.W #2,D2
 MOVE.W D2,D3
L1:
 BSR D1
M1:
 SUBQ.W #1,A2
 MOVE.B 0(A2,D2.W),(A2)
 DBRA D3,M1
H1:
 CMPA.L A2,A1
 BLT N1
 RTS
B1:
 MOVE.L -(A0),D0
 EOR.L D0,D5
 MOVE.B #$10,CCR
 ROXR.L #1,D0
 RTS
D1:
 SUBQ.W #1,D1
 CLR.W D2
P1:
 LSR.L #1,D0
 BNE.S O1
 MOVE.L -(A0),D0
 EOR.L D0,D5
 MOVE.B #$10,CCR
 ROXR.L #1,D0
O1:
 ROXL.L #1,D2
 DBRA D1,P1
 RTS
BUF0:
 DS.L 1
DF:
 DS.L 1
DI:
 DS.L 1 
BUF1:
 DS.L 1
NEWDATOS:
 DS.L 1
BUF2:
 DS.L 1
BUF3:
 DS.W 1
LOGIC:
 DC.L $78000
HANDLE:
 DS.L 1
texto:
 DC.B $0A,$0D
 dc.b '            THE DELIVERANCE           ',$0A,$0D
 DC.B $0A,$0D
 DC.B '                PRESENTS              ',$0A,$0D
 DC.B $0A,$0D
 DC.B '              FLYING SHARK            ',$A,$D
 DC.B $0A,$0D
 DC.B $0A,$0D
 DC.B '          PACKED BY RED DEVIL         ',$A,$D
 DC.B '                                      ',$A,$D
 DC.B '   HI TO:ALEATUM SOFT,GAL,ELECTRO SOFT',$A,$D
 DC.B '     SKYWALKERS,IVAN,ALLEN AND GHOST',$A,$D,00,00
FILE:
 DC.B 'FLYN.IMG',00

