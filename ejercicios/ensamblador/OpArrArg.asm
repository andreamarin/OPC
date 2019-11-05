TITLE Program Template          (OpArrArg.asm)

; Este programa llama un procedimiento con pasaje por stack.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

;SIMBOLOS
mcr=0dh
mlf=0ah
mnul=0h

.DATA
; PROC main
arrayi SDWORD 40h, 20h, 30h, 50h, 10h
nuni DWORD LENGTHOF arrayi
suma SDWORD ?
arrayr SDWORD 5 DUP(?)

txti BYTE mcr,mlf,"DumpMem de arrayi.",mnul
txtr BYTE mcr,mlf,"DumpMem de arrayr.",mnul
adios BYTE mcr,mlf,"ADIOS.",mnul

; PROC sycArrdw, variables locales
arrd1 DWORD ?

.CODE
main PROC

    ; call sycArrdw(arrayi, nuni, arrayr)

    call sycArrdw


    ; Despliega un dump de memoria de arrayi.
    mov edx, OFFSET txti
    call WriteString
    mov ESI, OFFSET arrayi
    mov ECX, nuni
    mov EBX, TYPE arrayi
    call DumpMem
    call Crlf

    ; Despliega un dump de memoria de arrayr.
    mov edx, OFFSET txtr
    call WriteString
    mov ESI, OFFSET arrayr
    mov ECX, nuni
    mov EBX, TYPE arrayr
    call DumpMem
    call Crlf

    mov edx, OFFSET adios
    call WriteString
    call Crlf

    EXIT
main ENDP

sycArrdw PROC
; sycArrdw(arr1d, unidades, arr2d)
; Copia un arreglo dw en otro, restandole 30h a cada elemento del segundo arreglo,
; ademas suma todos los elementos del primer arreglo.
; Recibe
;     Stack:
; Regresa
;     Stack;	
; Varibles automaticas y locales

;   Argumentos o parametros pasados

    mov ebx, 2
    .WHILE ebx < 1
    
    .ENDW
	
    RET
sycArrdw ENDP

END main