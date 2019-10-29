TITLE Program Template          (TareaBL.asm)

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
suma SDWORD ?

txtRes BYTE mcr,mlf,"Resultado",mnul
txtN BYTE mcr,mlf,"Teclee el dato n: ",mnul
adios BYTE mcr,mlf,"ADIOS.",mnul

; PROC Salarios
num SDWORD ?
total SDWORD 0
dirRet DWORD ? 

; PROC Possal
txtSal BYTE mcr,mlf,"Teclee el ",mnul
txtSal2 BYTE mcr,mlf," salario: ",mnul
n SDWORD ?
dirRet2 DWORD ?

.CODE

main PROC 
    ;pide el dato n 
    mov EDX, OFFSET txtN
    call WriteString
    call ReadInt
    call CrLf

    push eax
    CALL Salarios

    pop suma

    mov edx, offset txtRes
    call WriteString
    mov eax, suma
    call WriteInt
    
main ENDP

Salarios PROC
    pop dirRet
    pop num
    
    mov ebx, 1
    ;mov ecx, 0
    
    .WHILE ebx <= num
        push ebx
        call Possal
        
        call ReadInt
        add total, eax

        inc ebx
    .ENDW

    push total
    push dirRet

    RET
Salarios ENDP

Possal PROC
    pop dirRet2
    pop n
    
    mov edx, offset txtSal
    call WriteString

    mov eax, n
    call WriteInt

    mov edx, offset txtSal2
    call WriteString

    push dirRet2

    RET
Possal ENDP

END main
