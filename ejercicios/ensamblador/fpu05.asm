TITLE fpu05						(fpu05.asm)

; FPU Stack TOP

INCLUDE myIrvine.inc

.data
Alfa  REAL8 100.0
Beta  REAL8 -200.0
rab  REAL8 300.0
Ar  REAL8 -400.0
Bi  REAL8 500.0
Ce  REAL8 -600.0
str1  BYTE "Six FP values pushed into the FPU Stack: ",0
str2  BYTE "ST(0), TOP= FPUregister ",0
str3  BYTE "fsub ST(3), ST(0)",0

.code
main PROC

    finit   ; starts up the FPU

    mov EDX, OFFSET str2
    call WriteString
    mov EAX, 0
    fnstsw AX    ; copying FPU Status Word into AX
    ; TOP, in 11, 12 and 13 bits, need a shift
    and AX, 0011100000000000b
    shr AX, 11    ; 11 places shift to the right
    call WriteHex
    call CrLF
    call CrLf
    
    mov EDX, OFFSET str1
    call WriteString
    fld Alfa
    fld Beta
    fld rab
    fld Ar
    fld Bi
    fld Ce
    call ShowFPUStack
    call CrLf

    mov EDX, OFFSET str2
    call WriteString
    mov EAX, 0
    fnstsw AX    ; copying FPU Status Word into AX
    and AX, 0011100000000000b
    shr AX, 11    ; 11 places shift to the right
    call WriteHex
    call CrLF
    call CrLf
    
    EXIT
main ENDP

END main