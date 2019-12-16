TITLE SgExm19.asm  (Andrea Marin)

; Esqueleto para el segundo examen.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; DATA del procedimiento "main"
indices DWORD 7, 2, 8, 11, 14, 3, 20
        DWORD 10, 5, 0, 16, 9, 1, 4, 6
canin DWORD ?
consumos DWORD 1000, 2000, 3000, 4000
         DWORD 5000, 0, 12000, 11000
         DWORD 6000, 9000, 8000, 7000
canco DWORD ?

txtInd BYTE "Cantidad de indices: ",0
txtCon BYTE "Cantidad de consumos de agua: ", 0
txtAdios BYTE "HASTA LUEGO", 0

; DATA del procedimiento "ID"
textoID BYTE "Soy 158999AndreaM", 0

; Variables locales de CtaElemsArreglo
dirRet1 DWORD ?
sigElem DWORD ?

; Variables locales de ImprimirConsumos
dirRet2 DWORD ?
totIndices DWORD ?
lenArr  DWORD ?

txtRes BYTE "Consumo ", 0
txtVal BYTE " con valor: ", 0
txtError BYTE " INDICE FUERA DE RANGO", 0

.CODE
main PROC

    call ID

    CALL CrLf

    ; Contar numero de indices
    PUSH OFFSET indices
    PUSH OFFSET canin
    CALL CtaElemsArreglo
    POP canin                       ; guardar resultado

    ; Imprimir resultado
    MOV EDX, OFFSET txtInd
    CALL WriteString
    MOV EAX, canin
    CALL WriteInt
    CALL CrLf

    ; Contar numero de consumos
    PUSH OFFSET consumos
    PUSH OFFSET canco
    CALL CtaElemsArreglo
    POP canco                       ; guardar resultado

    ; Imprimir resultado
    MOV EDX, OFFSET txtCon
    CALL WriteString
    MOV EAX, canco
    CALL WriteInt
    CALL CrLf

    ; Imprimir consumos
    PUSH canco
    PUSH OFFSET consumos
    PUSH canin
    PUSH OFFSET indices
    CALL ImprimirConsumos

    ; Mensaje de salida
    CALL CrLF
    MOV EDX, OFFSET txtAdios
    CALL WriteString

    
    ;
    EXIT
main ENDP

; Procedimiento para imprimir mi ID
; No hay argumentos a pasar. El string es local.
; No hay resultado a regresar.
ID PROC
    call CrLF
    mov EDX, oFFSET textoID
    call WriteString
    call CrLF
    RET
ID ENDP

; CtaElemsArreglo(arr, sigElem)
; Procedimiento para calcular el número de elementos de un arreglo
; Recibe:
;      arr: OFFSET del arreglo DWORD
;      sigElem: OFFSET del siguiente elemento en memoria
; Regresa:
;       número total de elementos
CtaElemsArreglo PROC
    POP dirRet1
    POP sigElem
    POP ESI                 ; posicion del arreglo a contar

    MOV EBX, 0              ; contador
    .WHILE ESI < sigElem    ; mientras no haya llegado a la direccion del siguiente elemento
        INC EBX
        ADD ESI, TYPE DWORD
    .ENDW

    PUSH EBX                ; regresa el total
    PUSH dirRet1

    RET
CtaElemsArreglo ENDP

; ImprimirConsumos(arrInd, totIndices, arrCon, lenArr)
; Procedimiento para calcular el número de elementos de un arreglo
; Recibe:
;      arrInd: OFFSET del arreglo de indices DWORD
;      totIndices: Longitud del arreglo de indices
;      arrCon: OFFSET del arreglo de consumos DWORD
;      lenArr: Longitud del arreglo de indices
; Regresa:
;       Nada
ImprimirConsumos PROC
    POP dirRet2
    POP ESI                             ; direccion del arreglo de indices
    POP totIndices
    POP EDI                             ; direccion del arreglo de consumos
    POP lenArr

    CALL CrLf

    MOV EBX, 0                          ; contador para el arreglo de indices
    MOV ECX, 0                          ; contador de consumos impresos
    .WHILE EBX < totIndices
        MOV EAX, DWORD PTR [ESI]        ; obtenemos indice

        .IF EAX < lenArr                ; Checamos que esté dentro del rango
            MOV EDX, OFFSET txtRes
            CALL WriteString
            CALL WriteInt               ; Imprimir indice

            MOV EDX, [EDI + EAX*4]      ; Obtenemos el consumo correspondiente
            MOV EAX, EDX

            .IF ECX == 2
                NEG EAX                 ; Negamos el número
                MOV ECX, -1
            .ENDIF

            .IF EBX == 0
                NEG EAX
            .ENDIF
            
            MOV EDX, OFFSET txtVal      ; Imprimir el valor del consumo
            CALL WriteString
            CALL WriteInt

            INC ECX
            
            CALL CrLf
        .ENDIF

        INC EBX                         ; aumentar contadores
        ADD ESI, TYPE DWORD
    .ENDW

    PUSH dirRet2

    RET
ImprimirConsumos ENDP

END main