; Ejemplo de Adicion Extendida           (AdiExten1.asm)

; Este programa calcula la suma de dos enteros de 9 bytes.
; Estos enteros estan almacenados como arreglos ("op1" y "op2"),
; con el byte menos significativo almacenado en la direccion mas baja.
; El resultado quedara en el arreglo "suma". 

INCLUDE myIrvine.inc

.DATA
op1 BYTE 20h,34h,12h,98h,74h,06h,0A4h,0B2h,0A2h
op2 BYTE 30h,02h,45h,23h,00h,00h,87h,10h,80h

suma BYTE 10 dup(0) 	; = 0122C32B0674BB573650h
; El almacenamiento para esta variable "suma" debe ser de un
; byte mas largo que el de los operandos "op1" y "op2"

mmm BYTE "++", 0
adios BYTE "ADIOS", 0

; DATA del procedimiento Adicion Extendida
dirRetAE DWORD ?
grdacrry BYTE ?    ; para guardar el carry flag momentaneamente

; DATA del procedimiento Despliega Suma
dirRetDS DWORD ?

.code
main PROC

; Calcula la adicion extendida
	push OFFSET op1		; primer operando
	push OFFSET op2		; segundo operando
	push OFFSET suma		; suma operando
	push LENGTHOF op1   	; numero de bytes
	call	AdicionExtendida

; Despliega los dos operandos
	mov EDX, OFFSET mmm
	call WriteString
	push OFFSET op1
	push LENGTHOF op1
	call	DespliegaSuma
	call Crlf

	mov EDX, OFFSET mmm
	call WriteString
	push OFFSET op2
	push LENGTHOF op2
	call	DespliegaSuma
	call Crlf

; Despliega la suma.	
	push OFFSET suma
	push LENGTHOF suma
	call	DespliegaSuma
	call Crlf
	
	exit
main ENDP

;--------------------------------------------------------
AdicionExtendida PROC
; DESCRIPCION:
;   Calcula la suma de dos entero extendidos almacenados como arreglos de bytes.
;   Recuerde que sumara cada par de enteros byte desde el LSB hasta el MSB, o sea
;   de los offsets de arreglo mas bajo al mas alto; de menor a mayor direccion.
; RECIBE:
; Por medio del stack,
;   los apuntadores a los dos enteros, colocandolos en ESI y EDI;
;   el numero de bytes a ser sumados se guardara en ECX;
;   el apuntador a la variable que guardara la suma, en EBX.
; REGRESA:
;   Nada.
;--------------------------------------------------------
      pop dirRetAE
      pop ECX    ; longitud de los arreglos operando
      pop EBX    ; offset del arreglo resultado
      pop EDI    ; offset del segundo arreglo operando
      pop ESI    ; offset del primer arreglo operando

	CLC                	; limpia el Carry flag
      mov grdacrry, 0
      RCL grdacrry, 1                 	; respalda el Carry flag en LSBit, o pushfd
      .WHILE ECX > 0
          RCR grdacrry, 1              	; recupera el Carry flag del LSBit, o popad
          mov AL, [ESI]      			; primer entero byte
          adc AL, [EDI]      			; segundo entero byte + el carry flag
          RCL grdacrry, 1                  	; respalda el Carry flag, 
          mov [EBX], AL   		; almacena la suma en el arreglo de la suma
          add ESI, TYPE BYTE        ; incrementan los 3 apuntadores
          add EDI, TYPE BYTE
          add EBX, TYPE BYTE
          dec ECX
	.ENDW

	RCR grdacrry, 1
      mov	BYTE PTR [EBX], 0		; limpia el byte mas alto del arreglo de la suma
	adc	BYTE PTR [EBX], 0		; agrega el carry flag resultado de las ultima suma de enteros byte

      push dirRetAE
	RET
AdicionExtendida ENDP

;-----------------------------------------------------------
DespliegaSuma PROC
; DESCRIPCION:
;   Despliega un entero largo que esta almacenado en orden
;   little endian (LSB to MSB).
;   La salida despliega el arreglo, con el resultado, en
;   hexadecimal, empezando con el MSB.
; RECIBE:
;   Por medio del stack,
;   el apuntador al arreglo con el resultado, en ESI;
;   el numero de bytes del arreglo, en ECX
; REGRESA:
;   Nada.
;-----------------------------------------------------------
      pop dirRetDS
      pop ECX
      pop ESI
	
	; apunta al ultimo elemento del arreglo; el offset mas bajo
	add ESI, ECX
	sub ESI, TYPE BYTE
	mov EBX, TYPE BYTE    ; 1, para formato de BYTE en WriteHexB
	
      .WHILE ECX > 0
          mov  AL, [ESI]			; get an array byte
          call WriteHexB			; display it
          sub  ESI, TYPE BYTE		      ; point to previous byte
          dec ECX
      .ENDW

      push dirRetDS
	RET
DespliegaSuma ENDP


END main