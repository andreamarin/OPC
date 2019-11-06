TITLE Ejercicio BM2 1

; Irvine libraries
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB  \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

; main proc
arr1 SDWORD 11, 10, 12, 14, 13, 10, 12
arr2 SDWORD 209, -131, -96, 160, -221, 85, -49
total SDWORD ?


txtRes BYTE "El resultado es: ", 0
adios BYTE "ADIOS", 0

; sumaMulti variables locales
dirRet DWORD ?
a1 DWORD ?
a2 DWORD ?
lenArr SDWORD ?

txtCalc1 BYTE "*", 0
txtCalc2  BYTE " = ", 0

.CODE 

main PROC
    PUSH OFFSET arr1
    PUSH OFFSET arr2
    PUSH LENGTHOF arr1

    CALL sumaMulti              ; llamamos a la funcion

    POP total                   ; obtenemos resultado

    MOV EDX, OFFSET txtRes      ; imprimir resultado
    CALL WriteString
    MOV EAX, total
    CALL WriteInt
    CALL CrLf

    MOV EDX, OFFSET adios
    CALL WriteString

    EXIT
main ENDP

sumaMulti PROC
    ; sumaMulti(arr1, arr2, lenArr)
    ; Recibe
    ;     Stack: arr1 (OFFSET arr1)
    ;     Stack: arr2 (OFFSET arr2)
    ;     Stack: lenArr (tamaño del arreglo)
    ; Regresa
    ;     Stack: total	

    POP dirRet          ; obtenemos parámetros
    POP lenArr              
    POP ESI
    POP EDI
    
    MOV EBX, 0          ; contador
    MOV ECX, 0          ; total
    MOV EDX, 0          ; resultado multiplicacion

    .WHILE EBX < lenArr

        MOV EAX, SDWORD PTR [ESI]    ; imprimir calculo
        CALL WriteInt               
        MOV EDX, OFFSET txtCalc1
        CALL WriteString
        MOV EAX, SDWORD PTR [EDI]
        CALL WriteInt

        IMUL EAX, SDWORD PTR [ESI]   ; a2 * a1

        MOV EDX, OFFSET txtCalc2
        CALL WriteString
        CALL WriteInt
        CALL CrLf


        ADD ECX, EAX                ; guardar suma

        ADD ESI, 4
        ADD EDI, 4
        INC EBX                     ; aumenta contador
    .ENDW

    PUSH ECX                        ; devolver resultado
    PUSH dirRet

    RET
sumaMulti ENDP

END main
