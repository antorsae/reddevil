** RUTINA LOADER PARA "THE COOL DEMO"
** BIEN, BASICAMENTE EL FUNCIONAMIENTO
** DE ESTA 'INTRO' SE PUEDE OBSERVAR
** EN OTRAS RUTINAS HECHAS ANTERIOR-
** MENTE....
 
** (C) 1990 RED DEVIL

LON	EQU $800*2
BASE	EQU $F0000
ESTR1	EQU 64	
ESTR2	EQU 32	
ESTR3	EQU 16	
	PEA 0
	MOVE.W #$20,-(A7)
	TRAP #1
	LEA $2000,A7
	MOVEQ #1,D0
	
	BSR PREPAL
	BSR SETSTAR
	MOVEQ #1,D0
	BSR MUS
	BSR CLS
	MOVEM.L $FFFF8240.W,D0-D7
	MOVEM.L D0-D7,OLDCO

	MOVEM.L COLORS(PC),D0-D7
	MOVEM.L D0-D7,$FFFF8240.W
	
ME	MOVE.W #$25,-(A7)
	TRAP #14
	LEA 2(A7),A7
	
	BSR CHGSC
	BSR MUS+8
	BSR STARS
	BSR CLR
	BSR ROTAL
	BSR PLINES
	CMP.B #$39,$FFFFFC02.W
	BNE.S ME
	MOVEM.L OLDCO(PC),D0-D7
	MOVEM.L D0-D7,$FFFF8240.W
	PEA 0
	TRAP #1
	
SCREEN	DC.L BASE
OLDCO	DS.W 16
COLORS	DC.W $000,$444,$555,$555,$666,$666,$666,$666
	REPT 8
	DC.W $700
	ENDR
CHGSC	LEA SCREEN(PC),A0
	MOVE.L (A0),D0
	BCHG #15,D0
	MOVE.L D0,(A0)
	LSR.L #8,D0
	MOVE.B D0,$FFFF8203.W
	LSR.W #8,D0
	MOVE.B D0,$FFFF8201.W
	RTS
CLR	MOVEA.L SCREEN,A0
	LEA 6+(5*8)+(30*160)(A0),A0
	MOVE.W #140-1,D0
	MOVEQ #0,D1
CLSLLOP	MOVE.W D1,(A0)
	MOVE.W D1,8*1(A0)
	MOVE.W D1,8*2(A0)
	MOVE.W D1,8*3(A0)
	MOVE.W D1,8*4(A0)
	MOVE.W D1,8*5(A0)
	MOVE.W D1,8*6(A0)
	MOVE.W D1,8*7(A0)
	MOVE.W D1,8*8(A0)
	MOVE.W D1,8*9(A0)
	LEA 160(A0),A0
	DBF D0,CLSLLOP
	RTS
ROTAL	LEA LOG2D(PC),A0
	LEA RLOGO,A1
	LEA TRIGO(PC),A2
	LEA LON(A2),A3
	LEA PROT(PC),A4
	MOVE.W #LON-1,D5
GEN3D	BSR GEN
	MOVE.L (A0),D0
	SWAP D0
	TST.W D0
	BPL.S GEN3D
	ADDQ.L #2,A0
	MOVE.W D0,(A1)+
	SWAP D0
	TST.W D0
	BPL.S GEN3D
GONOW	MOVE.W D0,(A1)
	RTS
GEN	MOVE.W (A0)+,D4
	MOVE.W D4,D0
	ADD.W D0,D0
	MOVE.W D0,D1
	
	MOVE.W (A0),D2
	ADD.W #$10,D2
	AND.W D5,D2
	MOVE.W D2,(A0)+
	MOVE.W (A0),D3
	ADD.W #$18,D3
	AND.W D5,D3
	MOVE.W D3,(A0)+
	
	MULU 0(A2,D2.W),D0
	MULU 0(A3,D3.W),D1
	
	SWAP D0
	SWAP D1
	
	SUB.W D4,D0
	SUB.W D4,D1
	ADD.W #320/2,D0
	ADD.W #200/2,D1
	MOVE.W D0,(A1)+
	MOVE.W D1,(A1)+
	
	RTS
PLINES	LEA RLOGO,A1
	MOVE.W (A1)+,D0
	MOVE.W (A1)+,D1
	
MORE	MOVE.W (A1),D2
	MOVE.W 2(A1),D3
	MOVEA.L SCREEN,A0
	ADDQ.L #6,A0
	BSR LINE
	
	MOVE.W (A1)+,D0
	MOVE.W (A1)+,D1
	MOVE.W (A1),D7
	BPL.S MORE
	ADDQ.L #2,A1
	MOVE.W (A1)+,D0
	BMI.S GOGOGO
	MOVE.W (A1)+,D1
	BRA.S MORE
GOGOGO	RTS
LINE	
line	moveq	#0,d4
	move.w	#160,d5
	move.w	d2,d6
	sub.w	d0,d6
	bge	dxpos
	neg.w	d6
	exg	d0,d2
	exg	d1,d3
dxpos	sub.w	d1,d3
	bgt	lmain
	beq	hline
	neg.w	d3
	neg.w	d5
	bra	lmain

lmain	mulu	#160,d1
	add.w	d1,a0
	moveq	#15,d1
	and.w	d0,d1
	sub.w	d1,d0
	lsr.w	d0
	add.w	d0,a0
	add.w	d1,d1
	move.w	tplot0(pc,d1.w),d1
	move.w	d3,d0
loop	or.w	d1,(a0)
	tst.w	d4
	bge	incy
incx	ror.w	d1
	bcc	cont
	addq.w	#8,a0
cont	add.w	d3,d4
	bra	loop
incy	add.w	d5,a0
	sub.w	d6,d4
	dbf	d0,loop
endl	rts
tplot0	DC.W	%1000000000000000
	DC.W	%0100000000000000
	DC.W	%0010000000000000
	DC.W	%0001000000000000
	DC.W	%0000100000000000
	DC.W	%0000010000000000
	DC.W	%0000001000000000
	DC.W	%0000000100000000
	DC.W	%0000000010000000
	DC.W	%0000000001000000
	DC.W	%0000000000100000
	DC.W	%0000000000010000
	DC.W	%0000000000001000
	DC.W	%0000000000000100
	DC.W	%0000000000000010
	DC.W	%0000000000000001
	

hline	move.w	d2,d3
	sub.w	d0,d3
	bgt	dxgt
	beq	plot

	neg.w	d3
	exg	d0,d2

dxgt	mulu	#160,d1
	add.w	d1,a0

	moveq	#15,d1
	and.w	d2,d1
	sub.w	d1,d2
	lsr.w	d2
	add.w	d1,d1
	move.w	tline(pc,d1.w),d4
	not.w	d4
	swap	d4

	moveq	#15,d1
	and.w	d0,d1
	sub.w	d1,d0
	lsr.w	d0
	add.w	d0,a0
	add.w	d1,d1
	move.w	tline(pc,d1.w),d4

	moveq	#-1,d3
	sub.w	d0,d2
	lsr.w	#3,d2

	beq	onlyend

	or.w	d4,(a0)
	addq.w	#8,a0
hlloop	*dec.w	d2
	SUBQ.W #1,D2
	beq	endline

	or.w	d3,(a0)
	addq.w	#8,a0

	bra	hlloop

endline	swap	d4
	or.w	d4,(a0)
	rts

onlyend	move.w	d4,d3
	swap	d4
	and.w	d4,d3
	or.w	d3,(a0)
	rts

tline	DC.W	%1111111111111111
	DC.W	%0111111111111111
	DC.W	%0011111111111111
	DC.W	%0001111111111111
	DC.W	%0000111111111111
	DC.W	%0000011111111111
	DC.W	%0000001111111111
	DC.W	%0000000111111111
	DC.W	%0000000011111111
	DC.W	%0000000001111111
	DC.W	%0000000000111111
	DC.W	%0000000000011111
	DC.W	%0000000000001111
	DC.W	%0000000000000111
	DC.W	%0000000000000011
	DC.W	%0000000000000001

plot	mulu	#160,d1
	adda.w	d1,a0

	moveq	#15,d1
	and.w	d0,d1
	sub.w	d1,d0
	lsr.w	d0
	add.w	d0,a0
	add.w	d1,d1
	move.w	tplot1(pc,d1.w),d0

	or.w	d0,(a0)
	rts

tplot1	DC.W	%1000000000000000
	DC.W	%0100000000000000
	DC.W	%0010000000000000
	DC.W	%0001000000000000
	DC.W	%0000100000000000
	DC.W	%0000010000000000
	DC.W	%0000001000000000
	DC.W	%0000000100000000
	DC.W	%0000000010000000
	DC.W	%0000000001000000
	DC.W	%0000000000100000
	DC.W	%0000000000010000
	DC.W	%0000000000001000
	DC.W	%0000000000000100
	DC.W	%0000000000000010
	DC.W	%0000000000000001
	
CLS	LEA BASE,A0
	LEA BASE+$8000+$7D00,A1
CDF	CLR.L (A0)+
	CMPA.L A0,A1
	BGT.S CDF
	RTS
PREPAL	LEA PROT(PC),A0
	MOVEQ #16-1,D0
DOCVT	MOVEQ #0,D1
	BSET D0,D1
	MOVE.W D1,(A0)+
	DBF D0,DOCVT
	LEA TRIGO(PC),A0
	MOVE.W #LON-1,D0
	MOVE.W #$8000,D1
DOADD	ADD.W D1,(A0)+
	DBF D0,DOADD
	LEA LOG2D(PC),A0
TRANS	ADDQ.L #2,A0
	MOVE.W (A0),D1
	ADD.W D1,D1
	MOVE.W D1,(A0)+
	MOVE.W (A0),D1
	ADD.W D1,D1
	MOVE.W D1,(A0)+
	MOVE.W (A0),D0
	BPL.S TRANS
	ADDQ.L #2,A0
	MOVE.W (A0),D0
	BPL.S TRANS
	RTS

PROT	DS.W 16

LOG2D	INCBIN 'WAIT.LIN'
	DC.L -1
TRIGO	INCBIN 'SIN_COS.RED'
STARS	BSR STAR1
	BSR STAR2
	BSR STAR3
	RTS
STAR1	MOVEA.L SCREEN(PC),A1
	MOVEA.L SDIR1,A0
	MOVEQ #0,D7
	REPT ESTR1
	ADDA.W (A0),A1
	ADDQ.L #4,A0
	MOVE.W D7,(A1)
	ENDR
	ADD.L #ESTR1*4,SDIR1
	CMP.L #POINT1+(ESTR1*4*320/1),SDIR1
	BLE.S NREV1
	MOVE.L #POINT1+(ESTR1*4),SDIR1
NREV1	MOVE.L SCREEN(PC),D0
	BCHG #15,D0
	MOVE.L D0,A1
	MOVEA.L SDIR1,A0
	REPT ESTR1
	ADDA.W (A0)+,A1
	MOVE.W (A1),D0
	OR.W (A0)+,D0
	MOVE.W D0,(A1)
	
	ENDR
	RTS
SDIR1	DC.L POINT1+(ESTR1*4)
STAR2	MOVEA.L SCREEN(PC),A1
	ADDQ.W #2,A1
	MOVEA.L SDIR2,A0
	MOVEQ #0,D7
	REPT ESTR2
	ADDA.W (A0),A1
	ADDQ.L #4,A0
	MOVE.W D7,(A1)
	ENDR
	ADD.L #ESTR2*4,SDIR2
	CMP.L #POINT2+(ESTR2*4*320/2),SDIR2
	BLE.S NREV2
	MOVE.L #POINT2+(ESTR2*4),SDIR2
NREV2	MOVE.L SCREEN(PC),D0
	BCHG #15,D0
	ADDQ.W #2,D0
	MOVE.L D0,A1
	
	
	MOVEA.L SDIR2,A0
	REPT ESTR2
	ADDA.W (A0)+,A1
	MOVE.W (A1),D0
	OR.W (A0)+,D0
	MOVE.W D0,(A1)
	ENDR
	RTS
SDIR2	DC.L POINT2+(ESTR2*4)
STAR3	MOVEA.L SCREEN(PC),A1
	ADDQ.W #4,A1
	
	MOVEA.L SDIR3,A0
	MOVEQ #0,D7
	REPT ESTR3
	ADDA.W (A0),A1
	ADDQ.L #4,A0
	MOVE.W D7,(A1)
	ENDR
	ADD.L #ESTR3*4,SDIR3
	CMP.L #POINT3+(ESTR3*4*(320/4)),SDIR3
	BLE.S NREV3
	MOVE.L #POINT3+(ESTR3*4),SDIR3
NREV3	MOVE.L SCREEN(PC),D0
	BCHG #15,D0
	ADDQ.W #4,D0
	MOVE.L D0,A1
	
	
	MOVEA.L SDIR3,A0
	REPT ESTR3
	ADDA.W (A0)+,A1
	MOVE.W (A1),D0
	OR.W (A0)+,D0
	MOVE.W D0,(A1)
	
	ENDR
	RTS
SDIR3	DC.L POINT3+(ESTR3*4)
SETSTAR	LEA POINT1,A3
	MOVE.W #ESTR1-1,D7
	MOVE.W #ESTR1*4,FCTADD0+2
	MOVE.W #ESTR1*4,FCTADD1+2
	MOVEQ.L #1,D6
	BSR GETSKY
	LEA POINT2,A3
	MOVE.W #ESTR2-1,D7
	MOVE.W #ESTR2*4,FCTADD0+2
	MOVE.W #ESTR2*4,FCTADD1+2
	MOVEQ.L #2,D6
	BSR GETSKY
	LEA POINT3,A3
	MOVE.W #ESTR3-1,D7
	MOVE.W #ESTR3*4,FCTADD0+2
	MOVE.W #ESTR3*4,FCTADD1+2
	MOVEQ.L #4,D6
GETSKY	MOVE.L #320,D4
	DIVU D6,D4
	SUBQ.W #1,D4
	SWAP D4
	MOVE.W D7,D4
SKYLOP1	MOVE.L #320,D5
	DIVU D6,D5
	MOVEQ.L #0,D3
FCTADD0	LEA 0(A3),A0
	MOVE.W (A3)+,D0
	MOVE.W (A3)+,D3
	MULU #160,D3
	SUBQ.W #1,D5
SKYLOP2	MOVEQ #0,D1
	MOVEQ #0,D2
	ADD.W D6,D0
	CMP.W #320,D0
	BLT.S PNORMAL
	SUB.W #320,D0
PNORMAL	MOVE.W D0,D1
	DIVU #16,D1
	MOVE.W D1,D2
	LSL.W #3,D2
	ADD.W D3,D2
	MOVE.W D2,(A0)
	SWAP D1
	LSL.W #1,D1
	LEA PUN16(PC,D1.W),A2
	MOVE.W (A2),2(A0)
FCTADD1	LEA 0(A0),A0
	DBF D5,SKYLOP2
	DBF D7,SKYLOP1
RELATIV	MOVE.W D4,D6
	SWAP D4
RELOP1	MOVE.W D6,D5
	MOVEQ.L #0,D1
RELOP2	MOVE.W (A3),D0
	SUB.W D1,D0
	MOVE.W (A3),D1
	MOVE.W D0,(A3)
	ADDQ.L #4,A3
	DBF D5,RELOP2 
	DBF D4,RELOP1 
	RTS
PUN16	DC.W 32768,16384,8192,4096,2048,1024,512,256
	DC.W 128,64,32,16,8,4,2,1
MUS	INCBIN 'EIMAGES.MUS'
POINT1	INCBIN 'SPC1.RND'
	DS.L ESTR1*(320/1)
POINT2	INCBIN 'SPC2.RND'
	DS.L ESTR2*(320/2)
POINT3	INCBIN 'SPC3.RND'
	DS.L ESTR1*(320/4)
RLOGO