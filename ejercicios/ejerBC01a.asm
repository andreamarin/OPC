TITLE ejerBC01a
  ; Primer Programa analizado
  ; 19-sep-19
  
; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
A	SDWORD 7
B 	SDWORD 11
D 	SDWORD -15
R 	SDWORD 10
msgr BYTE 0Dh, 0ah, "El Resultado R=, se encuentra en EAX ", 0

.CODE
main PROC
	; R = -A + 9 - B + D + 1
	
	mov EAX, A	; A
	neg EAX		; -A
	add EAX, 9	; -A+9
	sub EAX, B	; -A+9-B
	add EAX, D	; -A+9-B+D
	inc EAX		; -A+9-B+D+1
	mov R, EAX		; R = -A+9-B+D+1
	
	mov EDX, OFFSET msgr
	call WriteString        ; despliega el contenido de "msgr"

	call DumpRegs           ; despliega el contenido de los registros
	
	exit
main ENDP

END main