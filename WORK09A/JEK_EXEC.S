L0037 EQU ZUEND+$4E 
L0036 EQU ZUEND+$32 
L0035 EQU ZUEND+$30 
L0034 EQU ZUEND+$2C 
L0033 EQU ZUEND+$28 
L0032 EQU ZUEND+2 
L0031 EQU ZUEND+0 
 TEXT 
Begin:
L0000:PEA     L002E(PC) 
  MOVE.W  #9,-(A7)
  TRAP    #1
  ADDQ.L  #6,A7 
  MOVE.B  #$23,L0031
  PEA     L0031(PC) 
  MOVE.W  #$A,-(A7) 
  TRAP    #1
  ADDQ.L  #6,A7 
  LEA     L0005(PC),A0
  LEA     L002E(PC),A1
L0001:LEA     L0035(PC),A2
  MOVE.L  A1,D0 
  SUB.L   A0,D0 
  MOVE.L  D0,L0033
L0002:MOVE.B  (A0)+,(A2)+ 
  CMPA.L  A0,A1 
  BNE.S   L0002 
  MOVE.W  #0,-(A7)
  PEA     L0032(PC) 
  MOVE.W  #$3D,-(A7)
  TRAP    #1
  ADDQ.L  #8,A7 
  MOVE.L  D0,D7 
  BMI     L0004 
  LEA     L0035(PC),A3
  ADDA.L  L0033(PC),A3
  PEA     (A3)
  PEA     $000AAE60 
  MOVE.W  D7,-(A7)
  MOVE.W  #$3F,-(A7)
  TRAP    #1
  ADDA.W  #$C,A7
  MOVE.L  D0,L0034
  MOVE.L  D0,L0037
  ADDA.L  D0,A3 
  CLR.L   (A3)+ 
  CLR.L   (A3)+ 
  CLR.L   (A3)+ 
  MOVE.W  D7,-(A7)
  MOVE.W  #$3E,-(A7)
  TRAP    #1
  ADDQ.L  #4,A7 
  MOVE.L  L0033(PC),D3
  ADD.L   L0034(PC),D3
  MOVE.L  D3,L0036
  ADDQ.L  #8,D3 
  MOVE.W  #0,-(A7)
  PEA     L0032(PC) 
  MOVE.W  #$3C,-(A7)
  TRAP    #1
  ADDQ.L  #8,A7 
  MOVE.L  D0,D7 
  BMI.S   L0004 
  PEA     L0035(PC) 
  MOVE.L  D3,-(A7)
  MOVE.W  D7,-(A7)
  MOVE.W  #$40,-(A7)
  TRAP    #1
  ADDA.W  #$C,A7
  TST.L   D0
  BMI.S   L0004 
  MOVE.W  D7,-(A7)
  MOVE.W  #$3E,-(A7)
  TRAP    #1
  ADDQ.L  #4,A7 
  PEA     L002F(PC) 
  MOVE.W  #9,-(A7)
  TRAP    #1
  ADDQ.L  #6,A7 
  MOVE.W  #1,-(A7)
  TRAP    #1
  ADDQ.L  #2,A7 
  CMP.B   #$79,D0 
  BEQ     L0000 
  CMP.B   #$59,D0 
  BEQ     L0000 
L0003:CLR.W   -(A7) 
  TRAP    #1
L0004:PEA     L0030(PC) 
  MOVE.W  #9,-(A7)
  TRAP    #1
  ADDQ.L  #6,A7 
  MOVE.W  #7,-(A7)
  TRAP    #1
  BRA.S   L0003 
L0005:DC.B   '`',$1A,$00,$00,$02,'n',$00,$00
  DS.W    9,0 
  DC.B   $FF,$FF
L0006:BRA.S   L0008 
L0007:DC.B   $12,'4Vx'
L0008:LEA     L002A(PC),A0
  LEA     L002E(PC),A1
  MOVE.L  A1,(A0) 
  MOVE.L  L0007(PC),D0
  BSR     L0014 
  LEA     L0001(PC),A5
  LEA     L002E(PC),A3
  TST.W   26(A3)
  BNE.S   L000C 
  MOVE.L  2(A3),A0
  ADDA.L  6(A3),A0
  ADDA.L  14(A3),A0 
  ADDA.W  #$1C,A0 
  ADDA.L  A3,A0 
  LEA     L0006(PC),A1
  MOVE.L  A1,D0 
  LEA     28(A3),A1 
  TST.L   (A0)
  BEQ.S   L000C 
  ADDA.L  (A0),A1 
  CLR.L   (A0)+ 
L0009:ADD.L   D0,(A1) 
L000A:MOVEQ   #0,D1 
  MOVE.B  (A0),D1 
  CLR.B   (A0)+ 
  TST.W   D1
  BEQ.S   L000C 
  CMP.W   #1,D1 
  BNE.S   L000B 
  ADDA.W  #$FE,A1 
  BRA.S   L000A 
L000B:LEA     0(A1,D1.W),A1 
  BRA.S   L0009 
L000C:LEA     L0006(PC),A1
  LEA     8(A5),A2
  MOVE.L  A1,(A2)+
  MOVE.L  2(A3),D0
  MOVE.L  D0,D3 
  MOVE.L  D0,(A2)+
  ADDA.L  D0,A1 
  MOVE.L  A1,(A2)+
  MOVE.L  6(A3),D0
  ADD.L   D0,D3 
  MOVE.L  D0,(A2)+
  ADDA.L  D0,A1 
  MOVE.L  A1,(A2)+
  MOVE.L  10(A3),D0 
  MOVE.L  D0,(A2)+
  ADDA.L  D0,A1 
  MOVE.L  A1,(A2)+
  MOVE.L  A1,A0 
  LEA     L0006(PC),A2
  SUBA.L  A2,A0 
  LEA     28(A3,A0.W),A0
  CMPA.L  A0,A1 
  BCC.S   L000D 
  MOVE.L  A0,A1 
L000D:MOVEQ   #$64,D0 
  ADD.L   A1,D0 
  BCLR    #0,D0 
  MOVE.L  D0,A1 
  LEA     L000F(PC),A0
  MOVE.L  A1,A2 
  MOVEQ   #$20,D0 
L000E:MOVE.L  (A0)+,(A1)+ 
  DBF     D0,L000E
  LEA     28(A3),A1 
  LEA     L0006(PC),A3
  MOVE.L  A3,A4 
  LSR.L   #4,D3 
  ADDQ.L  #2,D3 
  JMP     (A2)
L000F:MOVE.L  (A1)+,(A3)+ 
  MOVE.L  (A1)+,(A3)+ 
  MOVE.L  (A1)+,(A3)+ 
  MOVE.L  (A1)+,(A3)+ 
  DBF     D3,L000F
  MOVE.L  24(A5),A1 
  MOVE.L  32(A5),A2 
  MOVE.L  A2,D1 
  SUB.L   A1,D1 
  MOVEQ   #$10,D0 
  CMP.L   D0,D1 
  BCC.S   L0011 
  MOVEQ   #0,D0 
L0010:CMPA.L  A2,A1 
  BCC.S   L0013 
  MOVE.B  D0,(A1)+
  BRA.S   L0010 
L0011:CLR.B   (A1)
  MOVE.L  A1,D0 
  ADDQ.L  #1,D0 
  BCLR    #0,D0 
  MOVE.L  D0,A1 
  MOVEQ   #0,D0 
  LSR.L   #4,D1 
L0012:MOVE.L  D0,(A1)+
  MOVE.L  D0,(A1)+
  MOVE.L  D0,(A1)+
  MOVE.L  D0,(A1)+
  DBF     D1,L0012
  BRA.S   L0010 
L0013:MOVE.L  A5,4(A7)
  JMP     (A4)
L0014:MOVEM.L A0-A6/D0-D7,-(A7) 
  LEA     L002B(PC),A4
  LEA     L002D(PC),A3
  MOVE.L  D0,(A3) 
  LEA     L0029(PC),A3
  MOVE.L  D0,(A3) 
  BTST    #0,D0 
  BNE     L0024 
  MOVE.L  L002A(PC),A0
  MOVE.L  A0,D7 
  BTST    #0,D7 
  BNE     L0024 
  ADDA.L  D0,A0 
  MOVE.L  -(A0),D0
  CMPI.L  #$4A454B21,D0 
  BEQ.S   L0015 
  BRA     L0024 
L0015:LEA     L0029(PC),A3
  MOVE.L  -(A0),(A3)
  MOVE    SR,D1 
  BTST    #13,D1
  BNE.S   L0016 
  CLR.L   -(A7) 
  MOVE.W  #$20,-(A7)
  TRAP    #1
  ADDQ.L  #6,A7 
  LEA     L002C(PC),A6
  MOVE.L  D0,(A6) 
  MOVE.W  #1,(A4) 
L0016:LEA     L002D(PC),A3
  SUBQ.L  #4,(A3) 
  MOVE.L  L002A(PC),A0
  ADDA.L  L002D(PC),A0
  MOVE.L  L002A(PC),A1
  MOVE.L  -(A0),A2
  ADDA.L  A1,A2 
  MOVE.L  -(A0),D5
  MOVE.L  -(A0),D0
  EOR.L   D0,D5 
L0017:LSR.L   #1,D0 
  BNE.S   L0018 
  BSR     L0025 
L0018:BCS.S   L001F 
  MOVEQ   #8,D1 
  MOVEQ   #1,D3 
  LSR.L   #1,D0 
  BNE.S   L0019 
  BSR     L0025 
L0019:BCS.S   L0021 
  MOVEQ   #3,D1 
  CLR.W   D4
L001A:BSR     L0026 
  MOVE.W  D2,D3 
  ADD.W   D4,D3 
L001B:MOVEQ   #7,D1 
L001C:LSR.L   #1,D0 
  BNE.S   L001D 
  BSR     L0025 
L001D:ROXL.L  #1,D2 
  DBF     D1,L001C
  MOVE.B  D2,-(A2)
  DBF     D3,L001B
  BRA.S   L0023 
L001E:MOVEQ   #8,D1 
  MOVEQ   #8,D4 
  BRA.S   L001A 
L001F:MOVEQ   #2,D1 
  BSR.S   L0026 
  CMPI.B  #2,D2 
  BLT.S   L0020 
  CMPI.B  #3,D2 
  BEQ.S   L001E 
  MOVEQ   #8,D1 
  BSR.S   L0026 
  MOVE.W  D2,D3 
  MOVE.W  #$C,D1
  BRA.S   L0021 
L0020:MOVE.W  #9,D1 
  ADD.W   D2,D1 
  ADDQ.W  #2,D2 
  MOVE.W  D2,D3 
L0021:BSR.S   L0026 
L0022:SUBQ.W  #1,A2 
  MOVE.B  0(A2,D2.W),(A2) 
  DBF     D3,L0022
L0023:CMPA.L  A2,A1 
  BLT.S   L0017 
  CMPI.W  #1,(A4) 
  BNE.S   L0024 
  MOVE.L  L002C(PC),-(A7) 
  MOVE.W  #$20,-(A7)
  TRAP    #1
  ADDQ.L  #6,A7 
L0024:MOVE.W  #0,(A4) 
  MOVEM.L (A7)+,A0-A6/D0-D7 
  MOVE.L  L0029(PC),D0
  RTS 
L0025:MOVE.L  -(A0),D0
  EOR.L   D0,D5 
  MOVE    #$10,CCR
  ROXR.L  #1,D0 
  RTS 
L0026:SUBQ.W  #1,D1 
  CLR.W   D2
L0027:LSR.L   #1,D0 
  BNE.S   L0028 
  MOVE.L  -(A0),D0
  EOR.L   D0,D5 
  MOVE    #$10,CCR
  ROXR.L  #1,D0 
L0028:ROXL.L  #1,D2 
  DBF     D1,L0027
  RTS 
  DS.W    2,0 
L0029:DS.W    2,0 
L002A:DS.W    2,0 
L002B:DS.W    1,0 
L002C:DS.W    2,0 
L002D:DS.W    3,0 
  DC.B   $07,'w'
L002E:DC.B   $1B,'E',$0D,$0A,$0A,'Cod'
  DC.B   'ed by Ax' 
  DC.B   'e/Deligh' 
  DC.B   't.',$0D,$0A,$0A,'Thi' 
  DC.B   's progra' 
  DC.B   'ms creat' 
  DC.B   'es an ex' 
  DC.B   'ecutable' 
  DC.B   ' program' 
  DC.B   ' from a ' 
  DC.B   'packed d' 
  DC.B   'atafile.' 
  DC.B   $0D,$0A,'Use th' 
  DC.B   'e JEK-pa' 
  DC.B   'cker to ' 
  DC.B   'pack the' 
  DC.B   ' file an' 
  DC.B   'd then s' 
  DC.B   'tart thi' 
  DC.B   's progra' 
  DC.B   'm.',$0D,$0A,$0A,$0A,'Fi'
  DC.B   'lename: ' 
  DC.B   $00
L002F:DC.B   $0D,$0A,$0A,$0A,'Do yo'
  DC.B   'u want t' 
  DC.B   'o conver' 
  DC.B   't anothe' 
  DC.B   'r file (' 
  DC.B   'y/N)?',$00
L0030:DC.B   $0D,$0A,$0A,$0A,'A di' 
  DC.B   'sk-error' 
  DC.B   ' has occ' 
  DC.B   'ured. Pr' 
  DC.B   'ess any ' 
  DC.B   'key....',$00

 BSS
ZUEND:DS.B    40048 
 END
