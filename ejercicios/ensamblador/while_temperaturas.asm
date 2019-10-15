TITLE Ejercicio encontrar mayor temperatura

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
titulo BYTE "Teclee el numero de temperaturas a introducir: ", mnul
espacio BYTE "]: ", mnul
impri01 BYTE "Temperatura [", mnul
impri02 BYTE "La mayor temperatura fue: ", mnul
impri03 BYTE "En la posicion: ", mnul
Adios BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul
N SDWORD ?
I SDWORD ?
Mayor SDWORD -10000

; Variables
char    BYTE ?
 
.CODE
; Procedimiento principal
main PROC
      mov edx,OFFSET titulo
    	call WriteString
    	call ReadInt
    	call CrLf
      mov N, EAX

      mov EBX, 1
      .WHILE EBX <= N
          ; Leer temperaturas
	    mov edx,OFFSET impri01
    	    call WriteString
          mov EAX, EBX
          call WriteInt
          mov edx, OFFSET espacio
          call WriteString
    	    call ReadInt
    	    call CrLf

          ; Ver cual es mayor
          .IF Mayor < EAX
            mov Mayor, EAX
            mov I, EBX
          .ENDIF
    
          inc EBX
      .ENDW

      mov edx,OFFSET impri02
    	call WriteString
      mov EAX, Mayor
      call WriteInt
      call CrLf

      mov edx,OFFSET impri03
    	call WriteString
      mov EAX, I
      call WriteInt
      call CrLf

      mov EDX, OFFSET Adios
      call WriteString
        

	
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main