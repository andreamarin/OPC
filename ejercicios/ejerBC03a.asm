TITLE ejerBC03a

; Uso de instrucciones, Directivas data y operadores.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine


.DATA

; Etiqueta
rever1  DWORD 2, 11h, 18

miCr = 0Dh	; Carriage return symbol
miLf = 0Ah	; Line feed symbol

txtr11	BYTE miCr, miLf, "Contenido de rever1: ", 0 
txtr12	BYTE miCr, miLf, "Caracteristicas de rever1: ", 0 

.CODE
main PROC
; Escriba comentarios
	
	; rever1, elementos del arreglo
	mov EDX, OFFSET txtr11
	call WriteString
	mov EAX, rever1
	mov EBX, rever1+4
	mov ECX, rever1+8
	call DumpRegs
	
	; rever1, algunas caracteristicas del arreglo
	mov EDX, OFFSET txtr12
	call WriteString
	mov ESI, OFFSET rever1
	mov EAX, TYPE rever1 ; = 4 (DWORD son 4B)
	mov EBX, LENGTHOF rever1 ; = 3
	mov ECX, SIZEOF rever1 ; = 12 (cada elemento es de 4B)
	call DumpRegs

	exit
main ENDP

END main