TITLE ejerBC02a
  ; Segundo Programa Analizado
  ; 19-sep-19
  
; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
Uvector		WORD 2002h, 4004h, 6006h, 7007h
Svector		SWORD -1, -2, -3, -4
msgu		BYTE 0Dh, 0ah, "Uvector", 0
msgs		BYTE 0Dh, 0ah, "Svector", 0

.CODE
main PROC
	;Uvector
	mov EDX, OFFSET msgu
	call WriteString	; imprimiendo el string de "msgu"
      ; Impresion de los cuatro valores de Uvector por medio de DumpRegs
	movzx EAX, Uvector
	movzx EBX, Uvector+2
	movzx ECX, Uvector+4
	movzx EDX, Uvector+6 
	call DumpRegs        ; imprime el contenido de los Registros E?X

	;Svector
	mov EDX, OFFSET msgs
	call WriteString	; imprimiendo el string de "msgs"
      ; Impresion de los cuatro valores de Svector por medio de DumpRegs
	movsx EAX, Svector
	movsx EBX, Svector+2
	movsx ECX, Svector+4
	movsx EDX, Svector+6 
	call DumpRegs        ; imprime el contenido de los Registros E?X

	exit
main ENDP

END main