12/09/2019

###Ejercicio

En operaciones binarias el - tiene precedencia sobre el +

1. Rval = -Xval + (Yval - Zval)	

   ```assembly
   .DATA
   Rval DWORD ?
   Xval DWORD 26
   Yval DWORD 30
   Zval DWORD 40
   .CODE 
   MOV EAX Xval
   NEG EAX
   MOV EBX Yval
   SUB EBX Zval
   ADD EAX EBX
   MOV Rval EAX
   ```

2. Rval = Xval -(-Yval + Zval)

3. ```assembly
   .DATA
   Rval DWORD ?
   Xval DWORD 26
   Yval DWORD 30
   Zval DWORD 40
   .CODE 
   MOV EAX Yval
   NEG EAX
   ADD EAX Zval
   MOV EBX Xval
   SUB EAX EBX
   MOV Rval EAX
   
   
   ```

### High Level Language

* MOV no afecta ninguna bandera porque no utiliza el ALU
* Banderas:
  * Zero
  * Carry
  * Sign: Si la operación es un resultado negativo (MSB = 1)
  * Overflow
  * Auxiliary Carry: si se hizo un carry del bit 3 al bit 4 en un byte (e.g del AL al AH hubo carry)
  * Parity: para transmisión serial
* Saltos condicionales: saltan si se cumple la condición 
  * Tenemos que tomar en cuenta si se trabaja con números con signo o sin signo
* Procesadores 16 bits --> 3 tipos de banderas
  1. **Control**: 
  2. **Estatus**: OF, SF, ZF, AF, PF, CF (son las únicas que podemos usar)
  3. **Sistema**
* Procesadores de 32 bits
  * Primeros 16 bits es el mismo registro de banderas que los procesadores de 16
  * En las otras 16 hay banderas de control y sistema
  * La mayoría de las banderas extra están vacías
* Procesadores 64 bits
  * Hereda el registro de 32 bits
  * Todos los demás bits están en 0

* Jearquía
  1. CPU
     1. ALU 
        1. Banderas de estado
* Operaciones:
  * CPU -- *ejecuta* --> saltos condicionales -- *provee* --> lógica para cambiar de rama
  * ALU -- *ejecuta* -->operaciones aritméticas y bit a bit -- *afecta*--> banderas de estatus -- *son utilizadas* --> salto condicional
* Para operaciones con signo podemos checar si el resultado es negativo con las banderas Z y C.  También podemos checar la bandera de singo (S) y overflow (O), estas se agregaron justo para manejar signos
* BCD: 1B por dígito, no hay acarreos, e.g. 4384.56 utiliza 6B
* *Regla de dedo:* Sean a y b dos operandos
  * Si $a,b > 0, a+b < 0$ 	o 	$a,b < 0, a+b>0$ 	$\implies$ overflow
  * e.o.c no hay overflow

* LAHF: para guardar las banderas de estatus en el registro AH 
  * S, Z, 0, A, 0, P, 1, C
  * A = auxiliary carry
* SAHF: guarda AH en las banderas de estatus
  * Sólo guarda las posiciones de las banderas (los bits que tienen que ser 0 y 1 se quedan = )
* Instrucciones para banderas:
  * STC (Set Carry Flag)
  * CLC (Clear Carry Flag)
  * CMC (Complement Carry Flag)
  * ADD op1 op2 (Add Carry Flag): op1 + op2 + C