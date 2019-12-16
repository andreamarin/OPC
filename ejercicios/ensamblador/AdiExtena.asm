; Ejemplo de Adicion Extendida           (AdiExtena.asm)

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

dirRet DWORD ? 

dirRet2 DWORD ?

.code
main PROC

; Calcula la adicion extendida
	PUSH OFFSET suma
	PUSH LENGTHOF op1
	PUSH OFFSET op2
	PUSH OFFSET op1
	call	AdicionExtendida

; Despliega la suma.

      PUSH LENGTHOF suma  	
      PUSH OFFSET suma
            
	call	DespliegaSuma
	call Crlf
	
	exit
main ENDP

;--------------------------------------------------------
AdicionExtendida PROC
; DESCRIPCION:
;   Calcula la suma de dos entero extendidos almacenados como arreglos de bytes.
; RECIBE:
; Por medio del stack,
;   los apuntadores a los dos enteros, colocandolos en ESI y EDI;
;   el numero de bytes a ser sumados se guardara en ECX;
;   el apuntador a la variable que guardara la suma, en EBX.
; REGRESA:
;   Nada.
;--------------------------------------------------------
	POP dirRet
	POP ESI						; apuntador op1
	POP EDI 					      ; apuntador op2
	POP ECX						; longitud operandos
	POP EBX						; apuntador resultado

      ;CLC
      
	MOV EDX, 0

	.WHILE EDX < ECX

            ;MOV EAX, 0
		MOV AL, BYTE PTR [ESI]

            .IF EDX == 0
                ADD AL, BYTE PTR [EDI]
            .ELSE
		  ADC AL, BYTE PTR [EDI]
            .ENDIF
		MOV BYTE PTR [EBX], AL

		INC EBX
		INC ESI
		INC EDI
		INC EDX
	.ENDW

      ;MOV EAX, OFFSET dirRet
      ;CALL WriteHex

      ;CALL CrLf

      ;MOV EAX, EBX
      ;CALL WriteHex

      ;PUSH dirRet

	MOV AL, 0
	ADC AL, 0
	MOV BYTE PTR [EBX], AL

      CALL WriteHexB
      

	PUSH dirRet

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
	POP dirRet2
	POP ESI					; apuntador resultado a imprimir
	POP ECX					; longitud del arreglo

	MOV EDX, ESI
	ADD EDX, ECX
	DEC EDX

      CALL CrLf
      MOV EBX, 1
        	
	.WHILE EDX >= ESI
		MOV AL, BYTE PTR [EDX]
            CALL WriteHexB	
		SUB EDX, 1
	.ENDW

	PUSH dirRet2

	ret

DespliegaSuma ENDP


END main