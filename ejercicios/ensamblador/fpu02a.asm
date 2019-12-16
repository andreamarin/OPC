TITLE fpu02a					(fpu02a.asm)

; Floating point sample

INCLUDE myIrvine.inc

.data
Alfa  REAL8 ?
Beta  REAL8 ?
rab  REAL8 ?
Ar  REAL8 300.0
Bi  REAL8 -400.0
Ce  REAL8 ?
strAlfa  BYTE "Enter the value of Alfa: ",0
strBeta  BYTE "Enter the value of Beta: ",0
strResult  BYTE "Result Alfa+Beta: ",0

.code
main PROC

    finit   ; starts up the FPU

    mov  EDX, OFFSET strBeta
    call  WriteString
    call  ReadFloat        ; Like  FLD, Top--,  ST(0) <- teclado
    call  ShowFPUStack

    fst  Beta        ;  Beta <- ST(0)
    call ShowFPUStack
    call CrLf

    mov  EDX, OFFSET strAlfa
    call  WriteString
    call  ReadFloat
    call  ShowFPUStack

    fst  Alfa        ;  Alfa <- ST(0)
    call  ShowFPUStack
	
    fadd         ;  ST(0) <- ST(0) + ST(1), modifTOP
    call ShowFPUStack

    fstp  rab        ; rab <- ST(0), TOP++
    call  ShowFPUStack
    call  CrLf
 
    mov  EDX, OFFSET strResult
    call  WriteString
    fld  rab        ; Top--,  ST(0) <- rab
    call  WriteFloat
    call  ShowFPUStack

    EXIT
main ENDP

END main