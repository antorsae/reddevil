 
EMS
 MOVE.L A7,OLDSP
 MOVE.L A7,A5
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
 LEA PIC+2,A5
 LEA PAL,A6
 MOVE.W #32,D0
 BSR MOV
 LEA PIC+2,A5
 LEA PALB,A6
 MOVE.W #32,D0
 BSR MOV
 CLR.L -(SP)
 MOVE.W #$20,-(SP)
 TRAP #1
 ADDQ.L #6,SP 
 MOVE.L $44E,OLDSC
 LEA PIC+34,A5
 LEA $60300,A6
 MOVE.W #32000,D0
 BSR MOV
 CLR.W -(SP)
 PEA $58600
 PEA $58600
 MOVE.W #5,-(SP)
 TRAP #14
 ADD.L #12,SP
 LEA $FF8240,A0
 MOVE.W #16,D0
BUL
 CLR (A0)+
 DBF D0,BUL
 LEA MUSIC,A5
 LEA $1E684,A6
 MOVE.L #$A00,D0
C_MUSIC
 MOVE.L (A5)+,(A6)+
 DBF D0,C_MUSIC 
 ADDQ.L #6,SP 
 MOVE.B #0,$484
 MOVE.L #INTER,$4D2
 MOVEQ #1,D0
 JSR $1E684
 PEA PAL
 MOVE.W #6,-(A7)
 TRAP #14
 ADDA.L #6,A7
 BSR PUTPIC
 MOVE.W #$777,$FF825E

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
	lea $67920,A0
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
 CMP.W #$3,D0
 BEQ NO3
 BRA cont 
NO0
 eor.b #2,$FF820A
 bra  cont
NO1
 BSR ENDM
 LEA 1,A0
 BRA LOADME
LOADME
 MOVEA.L OLDSP,A7
 MOVE.L A0,$500
 CLR.L -(A7)
 TRAP #1
NO2
 BSR ENDM
 LEA 2,A0
 BRA LOADME
NO3
 BSR ENDM
 LEA 3,A0
 BRA LOADME 
ENDM
 CLR.L $4D2
 MOVE.L	#$FF8800,A0
 MOVE.L	#$8080000,(A0)
 MOVE.L	#$9090000,(A0)
 MOVE.L	#$A0A0000,(A0)
 MOVE.W #0,-(A7)
 MOVE.L OLDSC,-(A7)
 MOVE.L OLDSC,-(A7)
 MOVE.W #5,-(A7)
 TRAP #14
 ADDA.L #12,A7
 RTS
PUTPIC
 MOVEA.L #$7D00,A5
 MOVEA.L $44E,A6
 ADDA.L A6,A5		;A5 FINAL
CALC			;A6 COUNTER
 LEA $500(A6),A6
 MOVE.W #$25,-(A7)
 TRAP #14
 ADDA.L #2,A7
 MOVE.W #$FFFF,-(A7)
 PEA (A6)
 PEA -1
 MOVE.W #$5,-(A7)
 TRAP #14
 ADDA.L #12,A7
 CMPA.L A5,A6
 BLT CALC
 RTS 
MOV
 MOVE.B (A5)+,(A6)+
 DBF D0,MOV
 RTS

INTER
 MOVEM.L A0-A6/D0-D7,-(A7)
 JSR $1E692
 MOVEM.L (A7)+,A0-A6/D0-D7
 RTS    
DATA	DS.L 1
PW	DS.W 16
BALL	DC.B 'BALL.DEL',0
WICKED	DC.B 'WICKED.DEL',0
MUNS	DC.B 'BOOT.DEL',0
HAND 	DS.L 1
zero2	dc.w $0
build	dc.l $0,$0,$0,$0 
AREA	DS.L 1
HANDLE:
 DS.L 1 
PAL	DS.W 16
PALB	DS.W 16
OLDSP
 DS.L 1
OLDSC
 DS.L 1
message2	DC.B "  "
	DC.B "THE DELIVERANCE IS PROUD TO PRESENT MENU NO 13.NO!!"
	DC.B "THE DELIVERANCE ARE:ALEATUM SOFT,GAL & RED DEVIL.NOW!!! TODAY IS 13TH (OCTOBER) (FRIDAY!!!)  "
	DC.B "BAH IT DOES NOT MATTER (??) IF YOU WANNA CONTACT THE DELIVERANCE (!!) PHONE:(96) 5218701 (ANDRES) (THAT'S ME.RED DEVIL!!)"
 	DC.B "SO THAT'S ALL FOR NOW..........NO! ONLY JOKING........I FORGET THE GREETINGS:ELECTRO SOFT(SPECIALLY RUNAWAY & DR.JAIV),DRAKE,"
	DC.B "SKYWALKERS,IVAN DE DONOSTI,SPIKIE,DUN-EPIN,GHOST,JORDI(THANX FOR THE 'BIG' SCROLLER),AND FINALLY ALL THE MEMBERS OF THE "
	DC.B "DELIVERANCE!!!!!                           OH,THIS PIC WAS AAAAAAHHHHHH MADE BY RED DEVIL......NICE....NO?               NEVER "
	DC.B "LET THE DISK PROTECTION.......(YOU KNOW HOW...) BECASE OF THE VIRUS...........(THE ORIGINAL DISK HAD NO VIRUS)  "
	DC.B "SORRY ABOUT THIS SCROLL IS (WQASQAS) (IT MEANS HORRIBLE) BUT...WAIT!! ALEATUM HAS THE SCROLL READY.....I HOPE SO!!!       BUT IF NOT,I WILL USE JORDI'S SCROLLER "
	DC.B "                     REMEMBER THAT.....CRACKING,PACKING & FUCKING (EVEN WHITH THE COMPUTER) IS (REALLY) GOOD FOR YOU!!!!!!!!  "
	DC.B "DO YOU KNOW WHAT DOES A WALL SAY TO A THREE?                     NOTHING BECAUSE THE WALL DOESN'T SPEAK!!!!!!!!!!!!!!     (HAHAHAHA)"
	DC.B "  NEXT MENU WILL USE A OVERSCAN (ONLY BOTTON SCREEN) AND A BETTER SCROLLER (I HOPE SO) "
	DC.B "OK THAT'S BORIN' SEE YOU IN THE NEXT MENU BYE"
	DC.B "                                                        AHHHHHH  13 13 13 13 13 13 13                            "
	DC.B "                                                              NO MORE TEXT!!"
	DC.B "-------------((((((((((NOW RESTART-BYE!!)))))))))))))))))--------------------"
	DC.B $FF,0	
FONT	INCBIN 'FONT1.FNT'
MUSIC 	INCBIN 'MUSIC,BI'
PIC	INCBIN 'MENUST.PI1'
SC	DS.B 1
FIN	DC.B 1



	







	
