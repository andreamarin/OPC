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
    CALL ProcId

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

    CALL CrLf

    ; Imprimir arreglo
    PUSH OFFSET arrInd
    PUSH totInd
    PUSH OFFSET arrPot
    PUSH totPot
    CALL ImprimirArrD

    MOV EDX, OFFSET adios
    CALL WriteString

    EXIT
main ENDP

ProcId PROC
    MOV EDX, OFFSET id
    CALL WriteString
    CALL CrLf

    RET
ProcId ENDP

CtaElemArrD PROC
    POP dirRet
    POP sigElem
    POP arrD

    MOV ESI, arrD
    MOV ECX, 0

    MOV EAX, sigElem

    .WHILE ESI < sigElem
        INC ECX
        ADD ESI, TYPE DWORD
    .ENDW

    PUSH ECX
    PUSH dirRet
    RET
CtaElemArrD ENDP

ImprimirArrD PROC
    POP dirRet2
    POP lenArr
    POP arr
    POP lenIndices
    POP indices

    MOV ESI, indices                            ; apuntador arreglo indices
    MOV EBX, 0                                  ; contador

    
    .WHILE EBX < lenIndices
        MOV EAX, DWORD PTR [ESI]                ; obtener indice
        
        .IF EAX < lenArr                        ; checar que indice sea menor a la longitud
            MOV EDX, OFFSET txtPos
            CALL WriteString

            ;MOV EAX, ECX                        ; imprimir indice
            CALL WriteInt

            MOV EDX, OFFSET txtVal
            CALL WriteString

            MOV ECX, 4
            MUL ECX                              ; calcular indice del arreglo de potencias
            MOV EDI, arr
            ADD EDI, EAX

            MOV EAX, [EDI]                      ; obtener el valor del arreglo en el índice dado
            CALL WriteInt

            CALL CrLf

        .ENDIF

        ADD ESI, 4
        INC EBX
    .ENDW

    PUSH dirRet2
    RET
ImprimirArrD ENDP

END main


