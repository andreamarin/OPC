TITLE fpu07						(fpu07.asm)

; FPU Stack TOP

INCLUDE myIrvine.inc

.DATA
        X   REAL8  1.2
        Y   REAL8  3.0
        N   DWORD  0
        imp  BYTE "N= ", 0

.CODE
main PROC

    finit   ; starts up the FPU

        ; if( X < Y )
        ;      N = 1
        fld  Y                          ; ST(0) = Y
        fld  X                          ; ST(0) = X
        fcomi  ST(0), ST(1)            ; compare ST(0) to ST(1)
        jnb  L1                        ; ST(0) not < ST(1)?  skip
            mov  N, 1               ; N = 1
L1:
        mov EDX, OFFSET imp
        call WriteString
        mov eax, N
        call WriteInt
        call CrLf
    
    EXIT
main ENDP

END main