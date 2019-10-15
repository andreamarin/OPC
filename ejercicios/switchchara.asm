TITLE Ejercicio switchchara

; Descripcion:
; Ejemplo de implementacion de la Estructura Algoritmica Switch.
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
; Textos para la Consola
mcr=0Dh
mlf=0Ah
mnul=0h
titulo BYTE mcr, mlf, "Ejemplo de Switch.", mcr, mlf, "Tecle el dato char: ", mnul
impri01 BYTE "Caracter: ", mnul
impri02 BYTE "Caracter default: ", mnul
Adios BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul

; Variables
char    BYTE ?
 
.CODE
; Procedimiento principal
main PROC
	mov edx,OFFSET titulo
	call WriteString
	call ReadChar
	; char = scan (+++)
	
	; SWITCH(char)
	mov bl, 'D'
	cmp al, bl
	je	casoD
		mov bl, 'G'
		cmp al, bl
		je casoG
			mov edx, OFFSET impri02
			call WriteString
			call WriteChar
			jmp endSwitch
		casoG:
			mov al, 'F'
			jmp imprimir
	casoD:
		mov al, 'E'
	imprimir:
		mov edx, OFFSET impri01
		call WriteString
		call WriteChar
	endSwitch:
		; ADIOS
		mov edx,OFFSET Adios
		call WriteString
	
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main