TITLE Ejercicio BM 1

; Irvine libraries
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB  \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

; main proc
texto   BYTE "El coronel no tiene "
        BYTE "quien le escriba."
        BYTE  0
conul   BYTE "enur"             ; caracteres a contabilizar
acont   DWORD 4 DUP (0)         ; total de cada carácter

len     DWORD, ?
adios   BYTE "ADIOS", 0

; totalCaracteres variables locales
dirRet1 DWORD ?
cadena DWORD ?

; imprimirCadena
dirRet2 DWORD ?
cadenaImp DWORD ?
lenCadena DWORD ?
txt1 BYTE "Texto: ", 0
txt2 BYTE " Longitud: ", 0
txt3 BYTE " caracteres.", 0

; cuentaCaracteres
dirRet3 DWORD ?
caracteres DWORD ?
totCaracteres DWORD ?
txt DWORD ?
lenTxt DWORD ?

; imprimirTotal
dirRet4 DWORD ?
carac DWORD ? 
totales DWORD ?

txtHeader BYTE "Caracter    cantidad", 0
txtEspacio BYTE "      ", 0

.CODE 

main PROC
    PUSH OFFSET texto
    CALL totalCaracteres              ; llamamos a la funcion
    POP len                           ; obtenemos resultado

    PUSH OFFSET texto
    PUSH len
    CALL imprimirCadena

    PUSH OFFSET conul
    PUSH OFFSET acont
    PUSH OFFSET texto
    PUSH len
    CALL cuentaCaracteres

    PUSH OFFSET conul
    PUSH OFFSET acont
    CALL imprimirTotal

    MOV EDX, OFFSET adios
    CALL WriteString

    EXIT
main ENDP

totalCaracteres PROC
    ; totalCaracteres(texto)
    ; Recibe
    ;     Stack: texto (OFFSET)
    ; Regresa
    ;     Stack: total de caracteres

    POP dirRet          ; obtenemos parámetros
    POP cadena

    MOV ESI, 0          ; contador (y total de caracteres)

    MOV AL, cadena[ESI]

    .WHILE AL != 0
        INC ESI
        MOV AL, cadena[ESI]
    .ENDW
    
    PUSH ESI
    PUSH dirRet

    RET
totalCaracteres ENDP

imprimirCadena PROC
    POP dirRet2
    POP cadenaImp
    POP lenCadena

    MOV EDX, OFFSET txt1
    CALL WriteString
    MOV EDX, cadenaImp
    CALL WriteString
    MOV EDX, OFFSET txt2
    CALL WriteString
    MOV EAX, lenCadena
    CALL WriteInt
    MOV EDX, OFFSET txt3
    CALL WriteString

    CALL CrLf

    PUSH dirRet2

    RET
imprimirCadena ENDP

cuentaCaracteres PROC
    POP dirRet3
    POP lenTxt
    POP txt
    POP totCaracteres
    POP caracteres

    MOV ESI, 0              ; apuntador cadena original

    .WHILE ESI < lenTxt
        MOV AL, txt[ESI]

        MOV EDI, 0          ; apuntador caracteres
        MOV ECX, 0          ; bandera para salir del while

        .WHILE EDI < 4 && ECX == 0

            .IF AL == caracteres[EDI]
                INC totalCaracteres[EDI]        ; incremento el numero de ocurrencias del caracter
                MOV ECX, 1
            .ENDIF

            INC EDI             ; cambio de caracter a comparar
        .ENDW

        INC ESI                 ; me muevo en la cadena
    .ENDW

    PUSH dirRet3
    RET
cuentaCaracteres ENDP

imprimirTotal PROC
    POP dirRet4
    POP totales
    POP carac

    MOV EDX, OFFSET txtHeader
    CALL WriteString

    MOV ESI, 0

    .WHILE ESI < 4

        MOV AL, carac[ESI]
        CALL WriteChar

        MOV EDX, OFFSET txtEspacio
        CALL WriteString

        MOV EAX, totales[ESI]
        CALL WriteInt

        CALL CrLf

        INC ESI
    
    .ENDW

    PUSH dirRet4

    RET
imprimirTotal ENDP

END main
