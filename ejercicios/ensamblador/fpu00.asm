TITLE fpu00						(fpu00.asm)

; Floating point unit use

INCLUDE myIrvine.inc

.data
alfa REAL8 ?
beta REAL8 ?
txtAlfa BYTE "Enter the value of Alfa: ",0
txtBeta BYTE "Enter the value of Beta: ",0
resultXY BYTE "Result Alfa+Beta: ",0

.code
main PROC
	finit   ; starts up the FPU

	EXIT
main ENDP

END main