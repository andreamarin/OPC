TITLE *MASM Template	(ejerBj)*

; Descripcion:
; 
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

N DWORD ?
textoLec BYTE "Ingrese un n�mero de temperaturas a leer entre 1 y 10",0
textoError1 BYTE "Error por N < 1 o N > 10",0

textoLectura1 BYTE "Teclee la ",0
textoLectura2 BYTE " temperatura: ",0

min SDWORD 300000
pos DWORD 0

textoMin BYTE "Minimo de las temperaturas: ",0

textoFin1 BYTE "Temperatura ",0
textoFin2 BYTE ": ",0

textoNumInt BYTE "Numero de intercambios: ",0
adios BYTE "ADIOS", 0

temperaturas SDWORD 10 DUP(?)
numIntercambios SDWORD ?

; Variables procedimiento
dirRet DWORD ?
typeArr DWORD ?
lenArr SDWORD ?
M SDWORD ?
signed DWORD ?

.CODE
; Procedimiento principal
main PROC

    MOV ESI, OFFSET temperaturas               ; Ubicamos en ESI el lugar de memoria del arreglo de temperaturas
    
    MOV EDX, OFFSET textoLec                   ; Leemos el n�mero de temperaturas que se van a ingresar
    CALL WriteString
    CALL CrLf
    CALL ReadInt
    
    MOV N, EAX                                 ; Almacenamos el total de temperaturas a leer
    .IF N < 1 || N > 10                        ; Si el n�mero de temperaturas es menor a 1 o mayor
        MOV EDX, OFFSET textoError1            ; a 10 se emite un error
        CALL WriteString
        CALL CrLf
    .ELSE
        MOV EBX, 1                             ; Iniciamos un contador en 1
        .WHILE EBX <= N                        ; Leemos las N temperaturas
            MOV EDX, OFFSET textoLectura1
            CALL WriteString
            MOV EAX, EBX
            CALL WriteInt
            MOV EDX, OFFSET textoLectura2
            CALL WriteString
            CALL ReadInt
            CALL CrLf

            MOV [ESI], EAX                     ; Almacenamos la temperatura en el arreglo de temperaturas
            ADD ESI, TYPE temperaturas         ; Incrementamos la direcci�n de memoria almacenada en ESI por 4

            .IF EAX < min                      ; Si la temperatura ingresada es menor a la temperatura m�nima
                MOV min, EAX                   ; se almacena como la nueva temperatura m�nima
                MOV pos, EBX
            .ENDIF
            INC EBX                            ; Se incrementa el contador
        .ENDW
        
        MOV EDX, OFFSET textoMin
        CALL WriteString
        MOV EAX, min
        CALL WriteInt
        CALL CrLf

        PUSH 1
        PUSH N
        PUSH TYPE temperaturas
        PUSH OFFSET temperaturas
        CALL VecSelDir

        POP numIntercambios

        CALL CrLf
        
        MOV EAX, numIntercambios
        MOV EDX, OFFSET textoNumInt
        CALL WriteString
        CALL WriteInt
        CALL CrLf            

        MOV EBX, 1
        MOV ESI, OFFSET temperaturas
        .WHILE EBX <= N
            MOV EDX, OFFSET textoFin1
            CALL WriteString
            MOV EAX, EBX
            CALL WriteInt
            MOV EDX, OFFSET textoFin2
            CALL WriteString
            
            MOV EAX, SDWORD PTR [ESI]
            CALL WriteInt
            
            ADD ESI, TYPE temperaturas         ; Decrementamos la direcci�n de memoria contenida en ESI
            INC EBX                            ; Decrementamos el contador
    
            CALL CrLf
    
        .ENDW
    
    .ENDIF

    ;MOV EAX, [temperaturas + 8]
    ;CALL WriteInt

    CALL CrLf
    MOV EDX, OFFSET adios
    CALL WriteString

    EXIT

; Termina el procedimiento principal
main ENDP

; Procedimiento Seleccion Directa 
VecSelDir PROC
        POP dirRet
        POP ESI                                ; direccion de memoria del arreglo
        POP typeArr                            ; tipo
        POP lenArr
        POP signed

        MOV ECX, lenArr
        DEC ECX
        MOV M, ECX

        MOV ECX, 0                             ; Contador de intercambios
        MOV EBX, 0                             ; Contador 1
        
        .WHILE EBX < M

            MOV EDI, ESI
            ADD EDI, typeArr                   ; Apuntador 2

            MOV EDX, EBX                       ; Contador 2
            INC EDX
            
            .WHILE EDX < lenArr
                .IF signed == 1
                    MOV EAX, SDWORD PTR [ESI]
                    .IF EAX > SDWORD PTR [EDI]                 
                      XCHG [EDI], EAX            ; intercambiamos
                      MOV [ESI], EAX
                      INC ECX
                    .ENDIF
  
                .ELSE
                   MOV EAX, DWORD PTR [ESI]

                   .IF EAX > DWORD PTR [EDI]                 
                      XCHG [EDI], EAX            ; intercambiamos
                      MOV [ESI], EAX
                      INC ECX
                  .ENDIF
                
                .ENDIF

                INC EDX                        ; incrementa contador
                ADD EDI, typeArr
               
            .ENDW

            INC EBX
            ADD ESI, typeArr

        .ENDW 

        PUSH ECX
        PUSH dirRet

        RET
VecSelDir ENDP

; Termina el area de Ensamble
END main