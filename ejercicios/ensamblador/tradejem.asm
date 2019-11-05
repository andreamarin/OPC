TITLE Ejercicio tradejem

; Descripcion:
; Ejemplo de implementacion de Estructuras Algoritmicas.
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
titulo BYTE mcr, mlf, "Traduccion de Estructuras algoritmicas.", mcr, mlf, mnul
prompt01 BYTE "IF-THEN sin signo.", mnul
prompt02 BYTE "IF-THEN-ELSE con signo.", mnul
prompt03 BYTE "WHILE.", mnul
prompt04 BYTE "DO-WHILE.", mnul
prompt05 BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul

; Variables
cinco  DWORD 5
seis   DWORD 3
uno    SDWORD 8
dos    SDWORD 9
tres   SDWORD ?
cuatro SDWORD ?
 
.CODE
; Procedimiento principal
main PROC
	mov edx,OFFSET titulo
	call WriteString
	call Crlf

	
	; IF-THEN cinco y seis sin signo
	mov edx,OFFSET prompt01
	call WriteString
	call Crlf	

	mov eax, cinco
	cmp eax, seis
	jbe finSi1    ; <=
	    mov eax, cinco
	    mov seis, eax
finSi1:
	
	mov eax, seis
	call WriteInt  ; de eax
	call Crlf
	call Crlf

	
	; IF-THEN-ELSE uno y dos con signo
	mov edx,OFFSET prompt02
	call WriteString
	call Crlf

	MOV  EAX, dos
	add eax, 3
	CMP  uno, EAX
	JLE  else1    ; <=
          mov eax, uno
          MOV  dos, EAX
	JMP finSI2
else1:
	    MOV  EAX, dos
		MOV  uno, EAX
finSi2:
	
	mov eax, uno
	call WriteInt  ; de eax
	call Crlf
	call Crlf

	
	; WHILE con signo
	mov edx,OFFSET prompt03
	call WriteString
	call Crlf
	mov uno, 3
	mov dos, 9

iniWh1:
	MOV EAX, uno
	ADD EAX, 3
	CMP EAX, dos
	JG finWh1    ; >
	    MOV EBX, uno
	    ADD EBX, 5
	    MOV tres, EBX
	    INC uno
	JMP iniWh1
finWh1:
	
	mov eax, uno
	call WriteInt  ; de eax
	call Crlf
	call Crlf

	
	; DO-WHILE con signo
	mov edx,OFFSET prompt04
	call WriteString
	call Crlf
	mov uno, 8
	mov dos, 9

iniDo1:
	    MOV EAX, uno
	    SUB EAX, 7
	    MOV cuatro, EAX
	    INC uno
	MOV EBX, uno
	ADD EBX, 3
	CMP EBX, dos
	JLE iniDo1    ; <=

	mov eax, uno
	call WriteInt  ; de eax
	call Crlf

	
	; ADIOS
	mov edx,OFFSET prompt05
	call WriteString
	call Crlf
	call Crlf
	
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main