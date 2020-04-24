	clr.l -(a7)
	MOVE.W #$20,-(A7)
	TRAP #1
	ADDA.L #6,A7
	ORI.W #$700,SR
	MOVE.B #1,$FFFA07
	MOVE.B #$50,$FFFA09
	ORI.B #1,$FFFA13
	MOVE.L #USER,$4D2
USER	NOP
restart	
        MOVEM.L MYREGS,D0-D7/A0-A6
	lea	message2,a6 
nextlet	move.b 	(a6)+,d0
	cmp.b 	#$ff,d0
	bne.s 	notend
	bra.s 	nextlet
notend	clr.w 	d5
	andi.l 	#$ff,d0
	lea 	font1,a1
	adda.l 	d0,a1
	lea 	build,a2
	moveq.l	#7,d7
allchar	move.b 	(a1),(a2)+
	adda.l 	#$100,a1
	dbf 	d7,allchar
test0	cmpi.b 	#0,zero2
	bne.s 	sub1
	move.w 	#37,-(a7)
	trap 	#14
	addq.l	#2,a7
	move.b 	#2,zero2
sub1	subq.b 	#1,zero2
key	move.l 	#$600ff,-(a7)
	trap 	#1
	addq.l 	#4,a7
	tst.w 	d0
	bne.s 	keyhit
cont	moveq.l #0,d0
	lea 	build,a5
	movea.l $44e,a0
	moveq.l	#7,d7
lines	move.l 	a0,-(a7)
	adda.l 	#$138,a0
	move.b 	(a5),d1
	lsl.b 	#1,d1
	move.b 	d1,(a5)+
	moveq.l	#$13,d6
cols	move.w 	(a0),d1
	roxl.w 	#1,d1
	move.w 	d1,(a0)
	move.w 	d1,$2(a0)
	move.w 	d1,$4(a0)
	move.w 	d1,$6(a0)
	subq.l 	#8,a0
	dbf 	d6,cols
	movea.l	(a7)+,a0
	adda.l 	#$a0,a0
	dbf 	d7,lines
	addq.w 	#1,d5
	andi.w 	#7,d5
	bne 	test0
	MOVEM.L D0-D7/A0-A6,MYREGS
	RTS
keyhit	nop
        clr.l -(sp)
        trap #1
zero2	dc.w $0
MYREGS	DS.L 32
build	dc.l $0,$0,$0,$0
message2	DC.B "  "
	DC.B "SORRY!! IT SEEMS THAT YOUR ST HAS ONLY 512K RAM "
	DC.B "AVAILABLE, WHICH UNFORTUNATELY IS NOT ENOUGH TO "
	DC.B "RUN THE TWO GAMES ON THIS DISK (R-TYPE & MENACE). "
	DC.B "HOWEVER, YOU CAN STILL READ THE SCROLL, ADMIRE THE "
	DC.B "PICTURE AND LISTEN TO THE MUSIC, IT MAY NOT BE AS "
	DC.B "GOOD, BUT IT'S ALL YOUR GETTIN'  "
	DC.B $FF,0	

font1:
 incbin 'font1.fnt',00
	
	