TITLE fpu03						(fpu03.asm)

; FPU Stack, Overflow further than the eigth locations

INCLUDE myIrvine.inc

.data
Alfa  REAL8 ?
Beta  REAL8 ?
rab  REAL8 ?
Ar  REAL8 300.0
Bi  REAL8 -400.0
Ce  REAL8 500.0
str1  BYTE "Eight FP values pushed into the FPU Stack: ",0
str2  BYTE "Now the 9th FP value: ",0
str3  BYTE "Result Alfa+Beta: ",0

.code
main PROC

    finit   ; starts up the FPU
    
    mov EDX, OFFSET str1
    call WriteString
    fld Ar
    fld Bi
    fld Ar
    fld Bi
    fld Ar
    fld Bi
    fld Ar
    fld Bi
    call ShowFPUStack
    call CrLf

    ; After the 8th
    mov EDX, OFFSET str2
    call WriteString
    fld Ce
    call ShowFPUStack
    call CrLF

    ; After the 9th
    fld Ar
    fld Bi
    call ShowFPUStack
    call CrLF

    EXIT
main ENDP

END main