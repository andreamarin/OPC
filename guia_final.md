# Guía final

### Shifts

El bit que se pierde se guarda en CF

##### Logical

Mueve bits *n* lugares a la derecha/izquierda y rellena con cero

* SHR <destino> <n> == <destino> * $2^n$
* SHL <destino> <n> == <destino> / $2^n$

##### Arithmetic

Mueve los bits *n* lugares a la derecha/izquiera y copia el MSB (bit del signo) en la nueva posición 

* SAL <destino> <n> == SHL (llena de ceros)
* SAR <destino> <n>

##### Shift Double

Muevo los bits _n_ lugares izquierda/derecha y relleno con los _n_ MSB/LSB de la fuente

* SHLD <destino> <fuente> <n>
* SHRD <destino> <fuente> <n>

### Rotate

Muevo los bits _n_ lugares a la izquierda/derecha de manera cíclica

No pierdo bits! (El MSB/LSB se guarda en CF y se mueve al LSB/MSB)

* ROL <destino> <n>
* ROR <destino> <n>

##### Rotate Carry

Utilizo CF como extensión de mi operando 

* RCL <destino> <n>
  * CF $\rightarrow$ LSB
  * MSB  $\rightarrow$  CF
* RCR <destino> <n>
  * CF $\rightarrow$ MSB
  * LSB  $\rightarrow$  CF

**NOTA:** CLC == Clear CF, STC == Set CF

### Extended Precision Operations

* **Addition**: Sumo <destino> + <fuente> + CF 

  ADC <destino>, <fuente>

* **Substraction:** <destino> - <fuente> - CF

  SBB <destino> <fuente>

### FPU

* signo + mantissa (número) + exponente (e.g. $-38.75 \times 10^5$)
* para obtener exponente real le restamos 127

| Presición       | \# bits | signo | exponente | mantissa |
| --------------- | ------- | ----- | --------- | -------- |
| Simple          | 32      | 1     | 8         | 23       |
| Doble           | 64      | 1     | 11        | 52       |
| Doble Extendido | 80      | 1     | 16        | 63       |

* 8 registros (R0-R7) de 80 bits

##### Comparación

* FCOM == ST(0) vs ST(1)

* FCOM <op> (ST(0) vs <op>)

* No puedo usar macro directivas!

```assembly
FNSTSW AX							; mover banderas de FPU a AX
SAHF									; mover AH a las banderas de estado
```

* FCOMI ST(0), ST(i)
  * Activa las banderas de Zero, Parity y Carry directamente

#####  Operaciones

* FABS 					          (valor absoluto)
* FCHS                               (cambiar signo)
* FSQRT                             (raíz cuadrada)
* FLDZ                               (ST(0) == 0)
* FILD/ FIST <mem>          (guardar/convertir a entero) 

### Saltos condicionales

* CMP <leftOp> <rightOp> == <leftOp> - <rightOp>

##### Basados en una bandera

![image-20191216031746722](/Users/andreamarin/Library/Application Support/typora-user-images/image-20191216031746722.png)

#####  No signados

![image-20191216032016728](/Users/andreamarin/Library/Application Support/typora-user-images/image-20191216032016728.png)

##### Signados

![image-20191216032108536](/Users/andreamarin/Library/Application Support/typora-user-images/image-20191216032108536.png)

###  Macro directivas

| **Directive**      | **Description**                                              |
| ------------------ | ------------------------------------------------------------ |
| .BREAK             | Generates code to terminate a .WHILE or  .REPEAT block       |
| .CONTINUE          | Generates code to jump to the top of a  .WHILE or .REPEAT block |
| .ELSE              | Begins block of statements to execute  when the .IF condition is false |
| .ELSEIF condition  | Generates code that tests condition and  executes statements that follow, until an .ENDIF directive or another .ELSEIF  directive is found |
| .ENDIF             | Terminates a block of statements  following an .IF, .ELSE, or .ELSEIF directive |
| .ENDW              | Terminates a block of statements  following a .WHILE directive |
| .IF <condition>    | Generates code that executes the block  of statements if condition is true. |
| .REPEAT            | Generates code that repeats execution  of the block of statements until condition becomes true |
| .UNTIL <condition> | Generates code that repeats the block  of statements between .REPEAT and .UNTIL until condition becomes true |
| .WHILE <condition> | Generates code that executes the block  of statements between .WHILE and .ENDW as long as  condition is true |

##### Condiciones

![image-20191216032548977](/Users/andreamarin/Library/Application Support/typora-user-images/image-20191216032548977.png)

### Direccionamiento Indirecto

* Operando Indirecto: Es mejor para procedimientos!

  ```assembly
  .DATA
  array SDWORD 2,3,5,6
  
  .CODE
  MOV ESI, OFFSET array
  
  MOV EAX, [ESI]
  ADD ESI, TYPE array				
  ```

* Operando Indexado

  * Normal

  * ```assembly
    .DATA
    array SDWORD 2,3,5,6
    
    .CODE
    MOV ESI, 0										; indice = 0, 4, 8, ...
    
    MOV EAX array[ESI]						; opcion 1
    ADD ESI, TYPE array
    
    MOV EAX [array + ESI]					; opcion 2
    ```

  * Escalado

  * ```assembly
    .DATA
    array SDWORD 2,3,5,6
    
    .CODE
    
    
    MOV ESI, OFFSET array						; dirección del arreglo
    MOV EBX, 0											; indice = 0, 1, 2, 3, ...
    
    MOV EAX [ESI+EBX*TYPE array]
    
    INC EBX													; aumento indice
    ```

  * Desplazamiento

    ```assembly
    .DATA
    array SDWORD 2,3,5,6
    
    .CODE
    
    MOV ESI, OFFSET array						; dirección del arreglo
    MOV EBX, 0											; indice = 0, 4, 8, ...
    
    MOV EAX [ESI+EBX]
    
    ADD EBX, TYPE array
    ```

### Instrucciones Irvine

| Instrucción   | Descripción                                   | Params                                                       | **Return**               |
| :------------ | :-------------------------------------------- | ------------------------------------------------------------ | ------------------------ |
| *DumpRegs*    | Despliega registros y banderas                | -                                                            | -                        |
| *DumpMem*     | Despliega rango de memoria                    | **ESI:** Dirección inicial<br />**ECX:** # elementos<br />**EBX:** tamaño de elementos (1B, 2B) | -                        |
| *WriteInt*    | Escribe entero signado de 32 bits             | **EAX:** Número a escribir                                   | -                        |
| *WriteHex*    | Escribe entero no signado en hexa             | **EAX:** Número                                              | -                        |
| *WriteHexB*   | Escribe entero no signado de _n_ bits en hexa | **EAX:** Número<br />**EBX:** # bytes a escribir (1 == AL, 2 == AX, 4 == EAX) |                          |
| *ReadHex*     | Lee entero sin checar validez                 | -                                                            | **EAX:** Número leído    |
| *WriteString* | Escribe cadena, terminada en 0                | **EDX:** Offset de la cadena                                 | -                        |
| *ReadString*  | Lee cadena hasta el sig. enter                | **EDX:** Offset donde se va a guardar<br />**ECX:** max. # de caracteres (+1)<br /> | **EAX:** # de caracteres |
| *Gotoxy*      | Coloca el cursor en la posición x,y           | **DH:** x (renglón)<br />**DL:** y (columna)                 | -                        |
| *WriteChar*   | Escribe el caracter                           | **AL:** caracter a escribir                                  | -                        |

### Notas

* **LENGTHOF** = # de elementos
* **SIZEOF** = # bytes
* **MOVZX** = zero extend
* **MOVSX** = sign extend

### Esqueleto básico

```assembly
TITLE Program Template          (OpArrArg.asm)

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

;SIMBOLOS
mcr=0dh
mlf=0ah
mnul=0h

.DATA
; PROC main


; PROC sycArrdw, variables locales


.CODE
main PROC

	EXIT
main ENDP

sycArrdw PROC

	RET             
sycArrdw ENDP

END main
```



## Presentaciones

* Leer de archivos $\rightarrow$ CA
* Shifts múltiples DWORDS $\rightarrow$ CBb (_MultiShf.asm_)