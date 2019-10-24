TITLE Program Template          (InvStrBK02.asm)

; Este programa invierte un String.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; Area de Variables
unaCade BYTE "Gabriel Garcia Marquez",0
lenCade DWORD SIZEOF unaCade - 1


; Textos
inicio BYTE "Cadena inicial: ", 0
fin BYTE "Cadena final: ", 0
numCaracteres BYTE "La longitud, sin espacios, es: ", 0

.CODE
main PROC
    MOV EDX, OFFSET inicio
    CALL WriteString
    MOV EDX, OFFSET unaCade
    CALL WriteString
    CALL CrLf
    
    MOV ESI, 0

    .WHILE ESI < lenCade
        MOVZX BX, unaCade[ESI]
        ADD ESI, TYPE unaCade
        PUSH BX 
    .ENDW

    MOV EAX, 0
    MOV ESI, 0
    .WHILE ESI < lenCade
        POP BX
        MOV unaCade[ESI], BL
        .IF BL != " "
            INC EAX
        .ENDIF
        ADD ESI, TYPE unaCade
    .ENDW

    MOV EDX, OFFSET fin
    CALL WriteString
    MOV EDX, OFFSET unaCade
    CALL WriteString
    CALL CrLf
    MOV EDX, OFFSET numCaracteres
    CALL WriteString
    CALL WriteInt
    exit
    
main ENDP

END main