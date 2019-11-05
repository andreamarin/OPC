TITLE Ejercicio 1 de Tarea BJ

; Descripcion:
; Ejemplo de empleo de Macro Directivas que implementan Estructuras Algoritmicas. 
; Empleo de direccionamiento indirecto con operandos indirectos.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; Textos para la Consola
prompt01 BYTE "Dato n: ",0
prompt02 BYTE "Teclee la ",0
prompt03 BYTE " temperatura: ",0
prompt04 BYTE "Minimo de las temperaturas: ",0
prompt04a BYTE ", posicion: ",0
prompt05 BYTE "Temperatura ",0
prompt05a BYTE ": ",0
prompt05p BYTE ", P",0
prompt05i BYTE ", I",0
prompt07 BYTE "ADIOS.",0
prompt08 BYTE "ERROR por n<0 o n>10. ADIOS.",0

; Variables
n      SDWORD ?
min    SDWORD ?
posmin    SDWORD ?
arrTmp SDWORD 10 DUP(?)
 
.CODE
; Procedimiento principal
main PROC
	call Clrscr
	
	; Lectura del dato n
	call Crlf
	mov EDX, OFFSET prompt01
	call WriteString
	call ReadInt   ; valor leido en EAX
	mov n, EAX
	call Crlf
	
	;if(n<=0) checando
	.IF ( (n < 1) || (n >10 ) ) 
		mov EDX, OFFSET prompt08
		call WriteString
		call Crlf
		exit
	.ENDIF

	; Lectura de la primer temperatura
	mov EBX, 1    ; contador
	mov EDX, OFFSET prompt02
	call WriteString
	mov EAX, EBX
	call WriteInt
	mov EDX, OFFSET prompt03
	call WriteString
	call ReadInt   ; valor leido en eax
	mov min, EAX    ; la primer temperatura es la menor
      mov posmin, EBX
	inc EBX    ; incremento por temperatura leida

	mov ESI, offset arrTmp    ;direccion inicial del arreglo
	mov [ESI], EAX   ; guardando la primer temperatura en el arreglo
	add ESI, TYPE arrTmp    ; moviendo el apuntador al segundo elemento del arreglo
	
	; Lectura del resto de las temperaturas y almacenamiento en arreglo	
	.WHILE (EBX <= n)
		; Lectura de al siguiente temperatura
		mov EDX, OFFSET prompt02
		call WriteString
		mov EAX, EBX
		call WriteInt
		mov EDX, OFFSET prompt03
		call WriteString
		call ReadInt   ; valor leido en eax
		mov [ESI], EAX   ; guardando la siguiente temperatura, op indirecto
		add ESI, TYPE arrTmp    ; moviendo el apuntador al siguiente elemento del arreglo

		; Es la nueva temperatura leida menor que la menor temperatura anterior?
		.IF EAX < min
		    mov min, EAX
                mov posmin, EBX
		.ENDIF

		INC EBX
	.ENDW
	
	; Imprimiendo el Minimo de las temperaturas
	call Crlf
	mov EDX, OFFSET prompt04
	call WriteString
	mov EAX, min
	call WriteInt
	mov EDX, OFFSET prompt04a
	call WriteString
	mov EAX, posmin
	call WriteInt
	call Crlf
	call Crlf
	
	; IMPRIMIENDO el arreglo de temperaturas en sentido inverso
	; con operandos indirectos
	mov EBX, n    ; contador
	mov ESI, EBX
	imul ESI, TYPE arrTmp ; indicando a n*4
      add ESI, OFFSET arrTmp

      .WHILE( EBX >= 1 )
		; Impresion de la siguiente temperatura
		mov EDX, OFFSET prompt05
		call WriteString
		mov EAX, EBX
		call WriteInt
		mov EDX, OFFSET prompt05a
		call WriteString
		sub esi, TYPE arrTmp    ; moviendo el apuntador al anterior elemento del arreglo	
		mov EAX, [esi]   ; tomando la siguiente temperatura, operando indirecto
		call WriteInt   ; imprimiendo la siguiente temperatura
            ; Par o Impar
            and EAX, 1
            .IF ( EAX == 0 )
                mov EDX, OFFSET prompt05p
            .ELSE
                mov EDX, OFFSET prompt05i
            .ENDIF
		call WriteString
		call Crlf
		DEC EBX    ; decrementando el contador
      .ENDW
		
	; ADIOS
    	call Crlf
	mov edx,OFFSET prompt07
	call WriteString
	call Crlf

	exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main