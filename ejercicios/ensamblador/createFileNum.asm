TITLE Creating a File              (createFileNum.asm)

Comment !
Use of File procedures.
!

INCLUDE myIrvine.inc

mCr=0dh
mLf=0ah
mNul=00h
totElem=50

.DATA
fHandle DWORD ?
fName BYTE "two.bin",mNul
arreglo DWORD totElem+1 DUP(?)

adios BYTE mCr,mLf, "ADIOS.",mNul
byEscri BYTE mCr,mLf, "Bytes Escritos: ",mNul

; Procedimiento GenerateValues
dirRet DWORD ?

.CODE
main PROC

; Create the file

; Generate the array of values
      
; Write into the file

; Close the file

; Adios
      mov EDX, OFFSET adios
      call WriteString
      call CrLf

	EXIT
main ENDP

;------------------------------------------------------------
generateValues PROC
;
; Generates values from -1,-2,-3,... and stores in an array.
; Receives: pop ECX = number of elements, pop ESI points to the array
; Returns: nothing, the result is intrinsec in the array
;------------------------------------------------------------

	RET
generateValues ENDP

END main