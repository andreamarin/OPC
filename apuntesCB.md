# Clase CB

## SHIFT & ROTATE

* Utilizan la bandera de *Carry* como un bit extra 

* **Rotate: ** Conserva bits 

  * e.g. AL = 0110 1011

  * ROR AL,1      AL = 0110 0101  CF = 1

  * ROL  AL,3    AL = 1010 1101.    CF = 1

  * ***Rotate Carry Left:*** 

    * Shift cada bit a la izquierda
    * CF $\rightarrow$ LSB
    * MSB $\rightarrow$ CF

    ***Rotate Carry Right:***

    * Shift cada bit a la derecha
    * CF $\rightarrow$ MSB
    * LSB $\rightarrow$ CF

    e.g.

    * AL = 6Bh = 0110 1011        CF  = 1
    * RCR AL, 1     AL = 1011 0101    CF = 1
    * RCL AL, 3.    AL  = 1010 1110   CF = 1

* **Shift:** Existe la posibilidad de perder bits

  * Si sólo se hace 1 shift, no se pierden bits, se guarda en la *Carry Flag*
  * ***Logical Shift:*** El bit nuevo lo rellena con 0
    * SHL *n* == $\times 2^n$
    * SHR *n* == ÷$2^n$
  * ***Arithmetic Shift:*** En la nueva posición se copia el MSB
    * Conserva signo (sólo con SAR)
    * SAL == SHL
    * SAR

  