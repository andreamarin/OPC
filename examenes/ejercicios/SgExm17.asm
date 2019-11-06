TITLE Ejercicio Examen 2018

; Irvine libraries
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB  \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

; Symbolic Area
myNull=0

.DATA 
; variables del main
DiezStr BYTE "on1on", myNull
        BYTE "tw2tw", myNull
        BYTE "th3th", myNull 
        BYTE "fo4fo", myNull 
        BYTE "fi5fi", myNull
        BYTE "si6si", myNull
        BYTE "se7se", myNull
        BYTE "ei8ei", myNull
        BYTE "ni9ni", myNull
        BYTE "teAte", myNull
N SDWORD 10
T SDWORD ?

txtLen BYTE "Longitud de cada string: ", 0
txtLista BYTE "Lista de strings: ============= ", 0
txtStr1 BYTE "String ", 0
txtStr2 BYTE ": ", 0
adios BYTE "ADIOS.", 0

; variables proc ID
id BYTE "Soy: 158999AMA", 0

.CODE 

main PROC
    ; imprimir cu
    MOV EDX, OFFSET id
    CALL WriteString
    CALL CrLf

    ; Calcular longitud cadena
    MOV ESI, 0;OFFSET DiezStr
    MOV ECX, 0

    MOV AL, DiezStr[ESI]
    .WHILE AL != 0
        INC ECX
        ADD ESI, TYPE BYTE
        MOV AL, DiezStr[ESI]
    .ENDW
    
    MOV T, ECX

    ; imprimir longitud
    MOV EDX, OFFSET txtLen
    CALL WriteString
    MOV EAX, T
    CALL WriteInt
    CALL CrLf

    ; Imprimir cadenas
    MOV EDX, OFFSET txtLista
    CALL WriteString
    CALL CrLf

    MOV EBX, 0
    MOV ESI, OFFSET DiezStr
    .WHILE EBX < N
        MOV EDX, OFFSET txtStr1
        CALL WriteString

        MOV EAX, EBX                ; imprimir no. cadena
        INC EAX
        CALL WriteInt

        MOV EDX, OFFSET txtStr2
        CALL WriteString

        MOV EDX, ESI                ; imprimir cadena
        CALL WriteString
        CALL CrLf

        ADD ESI, T                  ; incrementar ESI y contador
        INC ESI
        INC EBX
    .ENDW

    MOV EDX, OFFSET adios
    CALL WriteString

    EXIT
main ENDP



END main


