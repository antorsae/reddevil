	 
 MOVE.L A7,A5
 MOVE.L #$77FFE,A7
 MOVE.L 4(A5),A5
 MOVE.L $C(A5),D0
 ADD.L $14(A5),D0
 ADD.L $1C(A5),D0
 ADD.L #$100,D0
 MOVE.L D0,-(SP)
 MOVE.L A5,-(SP)
 MOVE.L A5,AREA
 CLR.W -(SP)
 MOVE.W #$4A,-(SP)
 TRAP #1
 ADD.L #12,SP
 CLR.L -(SP)
 MOVE.W #$20,-(SP)
 TRAP #1
 ADDQ.L #6,SP
 MOVE.L D0,SR_USER
 CLR.W -(SP)
 pea -1
 PEA -1
 MOVE.W #5,-(SP)
 TRAP #14
 ADD.L #12,SP
 LEA $FF8240,A5
 LEA PAL,A6
 MOVE.W #32,D0
 BSR MOV
 LEA $FF8240,A0
 MOVE.W #16,D0
 clr.b $484
BUL
 CLR (A0)+
 DBF D0,BUL
 LEA MUSIC,A0
 LEA $33C2C,A1
 MOVE.W #$2254,D0
C
 MOVE.B (A0)+,(A1)+
 DBF D0,C
 JSR $33C2C
 LEA PIC+34,A5
 MOVE.L $44E,A6
 MOVE.W #32000,D0
 BSR MOV
 PEA PIC+2
 MOVE.W #6,-(SP)
 TRAP #14
 ADDQ.L #6,SP
restart	
        lea	message2,a6 
nextlet	move.b 	(a6)+,d0
	cmp.b 	#$ff,d0
	bne.s 	notend
	bra.s 	restart
notend	clr.w 	d5
	andi.l 	#$ff,d0
	lea 	FONT,a1
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
	move.l $44e,A0
	ADDA.L #$7580,A0
	moveq.l #7,d7
lines	move.l 	a0,-(a7)
	adda.l 	#$138,a0
	move.b 	(a5),d1
	lsl.b 	#1,d1
	move.b 	d1,(a5)+
	moveq.l #$13,d6
cols	move.w 	(a0),d1
	roxl.w 	#1,d1
	move.w 	d1,(a0)
	move.w 	d1,$2(a0)
	move.w 	d1,$4(a0)
	move.w 	d1,$6(a0)
	subq.l 	#8,a0
	dbf 	d6,cols
	movea.l (a7)+,a0
	adda.l 	#$a0,a0
	dbf 	d7,lines
	addq.w 	#1,d5
	andi.w 	#7,d5
	bne 	test0
	bra 	nextlet
keyhit;si se presiona..
 SUB #$30,D0
 BLT cont
 CMP.W #$0,D0
 BEQ NO0
 CMP.W #$1,D0
 BEQ NO1
 CMP.W #$2,D0
 BEQ NO2
 
 
 BRA cont
MOV
 MOVE.B (A5)+,(A6)+
 DBF D0,MOV
 RTS
NO0
 eor.b #2,$FF820A
 bra  cont
NO1
 BSR ENDM
 LEA $80000,A7
 CLR.B $800
 PEA SR_USER
 MOVE.W #$20,-(A7)
 TRAP #1
 ADDA.L #6,A7
 LEA $80000,A7
 CLR.L -(A7)
 TRAP #1
NO2
 BSR ENDM
 LEA $80000,A7
 ST.B $800
 PEA SR_USER
 MOVE.W #$20,-(A7)
 TRAP #1
 ADDA.L #6,A7
 LEA $80000,A7
 CLR.L -(A7)
 TRAP #1
ENDM
 PEA AREA
 MOVE.W #$49,-(A7)
 TRAP #1
 ADDA.L #6,A7
 LEA PAL,A5
 LEA $FF8240,A6
 MOVE.W #32,D0
 BSR MOV
 BSR CLS
 CLR.L $4DA.W
 MOVE.L	#$FF8800,A0
 MOVE.L	#$8080000,(A0)
 MOVE.L	#$9090000,(A0)
 MOVE.L	#$A0A0000,(A0)
 MOVE.W #0,-(A7)
 PEA -1
 PEA -1
 MOVE.W #5,-(A7)
 TRAP #14
 ADDA.L  #12,A7
 RTS
CLS
 MOVEA.L $44E,A0
 MOVE.W #$7D00,D0
CLBU
 CLR.B (A0)+
 DBF D0,CLBU
 RTS

PAL	DS.W 16
HAND 	DS.L 1
zero2	dc.w $0
build	dc.l $0,$0,$0,$0 
AREA	DS.L 1
HANDLE
 DS.L 1 
message2	DC.B "  "
	DC.B "HEY! THE DELIVERANCE PRESENTS:MENU 11                         (REMEMBER THE CODE FROM MENU 10? AFTER I WILL CODE OTHERS MESSAGES) "
 	DC.B "NOW! THE DELIVERANCE ARE:ALEATUM SOFT,GAL AND RED DEVIL. WOW ! GREAT?? OH FIRST OF ALL "
	DC.B "THE GREETINGS:THE DELIVERANCE,ELECTRO SOFT,JORGE,DRAKE,IVAN DE DONOSTI,ALEX,ALLEN,SIMON,GHOSTBUSTERS(SPECIALLY ALEXIS),SKYWALKERS,AND ALL ...(OTHER CONTACTS NOT MENTIONED) YEAH "
	DC.B "THIS MENU WAS FINALLY PACKED THANX TO RED DEVIL AND HIS 'MORAL SUPPORTER':BLACK STAR OK! CONTINUE WITH THE MAIN SCROLL..."
	DC.B "HEY! DO YOU LIKE THESE GAMES? (SPECIALLY PACKED!!) "
	DC.B "OH...MY TELEPHONE (96) 5218701 ASK FOR ANDRES I ALSO "
	DC.B "CAN HELP YOU IF YOU HAVE SPANISH OLD ROM...THAT MEANS THAT GAMES LIKE:"
	DC.B "FALCON,DUNGEON MASTER,LED STORM,BIONIC COMMANDO ETC... DOESN'T WORK "
	DC.B "IN YOUR COMPUTER.WE HAVE A PROGRAM WICH TURNS THE OLD TOS INTO A NEW,"
	DC.B "GREAT,ISN'T IT? SO THAT'S ALL,AND WRITTING SCROLL LINES IS REALLY BORING (IT IS),"
	DC.B "ARE YOU A 'RE-CRACKER' IF YOU ARE PRESS KEY 'C'................................."
	DC.B "HEY RE-CRACKERS NOTHING HAPPENS IF YOU DID PRESS C,DON'T IT? IF YOU PRESSED YOU ARE AN STUPID GUY! RECRACK IS GOOD FOR YOU! CRACKED GAMES ARE TOO NICE! "
	DC.B "NO NO NO NO THE CODE:QBDLJOH JT DBTJDS UIBO DSBDLJOH! (FORGET THAT CODE,I'LL CHANGE IT SOON) "
	DC.B "OK -NOW RESTART- BYE!!                                       (WOW)            "
	DC.B "                                 PLEASE PRESS 1 OR 2 (OR 0) .....................                   -FINALLY RESTART-"
 	DC.B $FF,0	
SR_USER	DS.L 1
FONT	INCBIN 'FONT1.FNT',0  
PIC	INCBIN 'CALAVERA.PI1',0
MUSIC 	INCBIN 'TEXMUS.BIN',0

	







	
