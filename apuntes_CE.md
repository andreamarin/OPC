# Floating Point Unit

Tenemos un stack de 8 registros (R0-R7),  que funciona como una pila circular. El apuntador TOP contiene la dirección de la punta del stack, es decir ST(0).

Hay dos operaciones básicas:

* **POP: ** Devuelve el valor de ST(0) y hace TOP ++

* **PUSH:** Hace TOP-- e inserta un valor en ST(0)

*NOTA* 

​	Como la pila es circular si ST(0) está en R1 y se hace un PUSH, ST(0) se mueve a R7

*Instrucciones*

* ReadFloat: PUSH *ST(0)*
* FST <var>: Lee ST(0) y lo guarda en la variable
* FSTP <var>: POP ST(0) $\rightarrow$ var
* FLD <var>: PUSH var $\rightarrow$ ST(0)
* FADD: ST(0) = ST(0) + ST(1)

*Saltos condicionales*

No se pueden utlizar JMP condicionales para operaciones con el FPU, pero se pueden utilizar JA, JB, etc si hacemos:

1. FNSTSW AX (FPU Status Words $\rightarrow $ AX )
2. SHL AX 8 (AX $\rightarrow$  AH) 
3. STFAH (AH $\rightarrow$ FLAGS)