TITLE Displaying Binary Bits                (WriteBin.asm)

; Display a 32-bit integer in binary.

INCLUDE myIrvine.inc

.DATA
binValue DWORD 1234ABCDh		; sample binary value
buffer BYTE 32 dup('x'),"..",0

.CODE
main PROC
    mov EAX, binValue		; number to display
    mov ECX, 0          ; counter
    mov EDX, 32 		; number of bits in EAX
    mov ESI, offset buffer

    .WHILE (ECX < EDX )
        mov BYTE PTR [ESI], '0'     ; choose char 0 as default digit;
        shl EAX, 1          ; shift high bit into Carry flag
        .IF ( CARRY? )
            mov BYTE PTR [ESI], '1'     ; else move char 1 to buffer
        .ENDIF
        inc ESI     ; next buffer position
        inc ECX     ; shift another bit to left
    .ENDW       

    mov EDX, OFFSET buffer		; display the buffer
    call WriteString
    call Crlf
    
    EXIT
main ENDP

END main