| Instrucción   | Descripción                       | Params                                                       | **Return**               |
| :------------ | :-------------------------------- | ------------------------------------------------------------ | ------------------------ |
| *DumpRegs*    | Despliega registros + banderas    | -                                                            |                          |
| *DumpMem*     | Despliega rango de memoria        | **ESI:** Dirección inicial<br />**ECX:** # elementos<br />**EBX:** tamaño de elementos (1B, 2B) |                          |
| *WriteInt*    | Escribe entero signado de 32 bits | **EAX:** Número a escribir                                   |                          |
| *WriteHex*    | Escribe entero no signado en hexa | **EAX:** Número                                              |                          |
| *ReadHex*     | Lee entero sin checar validez     | -                                                            | **EAX:** Número leído    |
| *WriteString* | Escribe cadena, terminada en 0    | **EDX:** Offset de la cadena                                 |                          |
| *ReadString*  | Lee cadena hasta el sig. enter    | **EDX:** Offset donde se va a guardar<br />**ECX:** max. # de caracteres (+1)<br /> | **EAX:** # de caracteres |
|               |                                   |                                                              |                          |

