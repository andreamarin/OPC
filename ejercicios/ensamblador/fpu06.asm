TITLE fpu06						(fpu06.asm)

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
        fld  X                  ; ST(0) = X
        fcomp  Y            ; compare ST(0) to Y
        fnstsw  ax          ; move FPU Status Word into AX
        sahf                    ; copy AH into EFLAGS
        jnb  L1                ; X not < Y?  skip
            mov  N, 1           ; N = 1
L1:
        mov EDX, OFFSET imp
        call WriteString
        mov eax, N
        call WriteInt
        call CrLf
    
    EXIT
main ENDP

END main