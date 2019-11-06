TITLE Ejercicio Examen 2018

; Irvine libraries
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB  \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA 

; variables del main
arrInd  DWORD 7, 2, 8, 11
        DWORD 14, 3, 10, 6, 0
        DWORD 16, 9, 1, 4, 5
totInd  SDWORD ?
arrPot  DWORD 1000, 2000, 3000, 4000
        DWORD 5000, 0, 12000, 11000
        DWORD 10000, 9000, 8000, 7000
totPot SDWORD ?

txtInd BYTE "El total de indices es: ", 0
txtPot BYTE "El total de potencias es: ", 0
adios BYTE "HASTA LUEGO.", 0

; variables proc ID
id BYTE "Soy 158999AndreaM", 0

; variables CtaElemArrD
dirRet DWORD ?
arrD DWORD ?
sigElem DWORD ?

; variables ImprimirArrD
dirRet2 DWORD ?
indices DWORD ?
arr DWORD ?
lenIndices SDWORD ?
lenArr SDWORD ? 

txtPos BYTE "Posicion ", 0
txtVal BYTE " con valor: ", 0

.CODE 

main PROC
    CALL ID

    ; Contar Indices
    PUSH OFFSET arrInd
    PUSH OFFSET totInd
    CALL CtaElemArrD
    POP totInd

    MOV EDX, OFFSET txtInd
    CALL WriteString
    MOV EAX, totInd
    CALL WriteInt
    CALL CrLf


    ; Contar potencias
    PUSH OFFSET arrPot
    PUSH OFFSET totPot
    CALL CtaElemArrD
    POP totPot

    MOV EDX, OFFSET txtPot
    CALL WriteString
    MOV EAX, totPot
    CALL WriteInt
    CALL CrLf

    PUSH arrInd
    PUSH totInd
    PUSH arrPot
    PUSh totPot
    CALL ImprimirArrD

    MOV EDX, OFFSET adios
    CALL WriteString

    EXIT
main ENDP

ID PROC
    MOV EDX, OFFSET id
    CALL WriteString
    CALL CrLf

    RET
ID ENDP

CtaElemArrD PROC
    POP dirRet
    POP arrD
    POP sigElem

    MOV ESI, arrD
    MOV ECX, 0

    .WHILE ESI < sigElem
        INC ECX
        INC DWORD PTR ESI
    .ENDW

    PUSH ECX
    PUSH dirRet
    RET
CtaElemArrD ENDP

ImprimirArrD PROC
    POP dirRet2
    POP indices
    POP lenIndices
    POP arr
    POP lenArr

    MOV ESI, 0                                  ; apuntador arreglo indices

    .WHILE ESI < lenIndices
        MOV EDI, indices[ESI*TYPE DWORD]       ; obtener indice

        .IF EDI < lenArr                        ; checar que indice sea menor a la longitud
            MOV EDX, OFFSET txtPos
            CALL WriteString

            MOV EAX, EDI                        ; imprimir indice
            CALL WriteInt

            MOV EDX, OFFSET txtVal
            CALL WriteString

            MOV EAX, arr[EDI*TYPE DWORD]       ; obtener el valor del arreglo en el índice dado
            CALL WriteInt

            CALL CrLf

        .ENDIF

        INC ESI
    .ENDW

    PUSH dirRet2
    RET
ImprimirArrD PROC

END main


