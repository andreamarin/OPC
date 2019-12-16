TITLE Creating a File              (readFromFileNum.asm)

Comment !
Use of File procedures.
!

INCLUDE myIrvine.inc

mCr=0dh
mLf=0ah
mNul=00h
totElemMax=100

.DATA
fHandle DWORD ?
fName BYTE "two.bin",mNul
arreglo DWORD totElemMax+1 DUP(?)
eleArre DWORD ?    ; Elements recovered, in the array

adios BYTE mCr,mLf, "ADIOS.",mNul
byLei BYTE mCr,mLf, "Bytes Leidos: ",mNul
eleRec BYTE mCr,mLf, "Elementos recuperados: ",mNul

; Procedimiento printValues
dirRet DWORD ?

.CODE
main PROC

; Create the file

; Read from the file

; Display the array of values

; Elements recovered in the arreglo
      
; Close the file

; Adios
      mov EDX, OFFSET adios
      call WriteString
      call CrLf

	EXIT
main ENDP

;------------------------------------------------------------
printValues PROC
;
; Print values from the array.
; Receives: pop ESI points to the array
; Returns: The amount of elements in the array
;------------------------------------------------------------

	RET
printValues ENDP

END main