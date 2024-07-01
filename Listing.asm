.data
    AusgabeText BYTE 'ABCDEFGH Hallo Welt Was geht heute lasst unss Kinder fressen'
	psw BYTE         '253813231997Monster25Monster25ter253813231997Monster25efewff'
    Handle QWORD ?
    geschrieben BYTE ?
    len equ lengthof AusgabeText

.code
    main proc

	mov rax, len
    mov rcx, len
    x:;first decoding level		
    	ror byte ptr [ AusgabeText + rcx - 1 ], cl 
        loop x
    
    xs:;second decoding level		
    	mov cl, byte ptr [ psw + rax ] 
    	ror byte ptr [ AusgabeText + rax - 1 ], cl 
    	dec rax
    	cmp rax, 0
    	jne xs

	mov rcx, len
	xm:;third decoding level                                            
		xor rdx, rdx
		mov al, byte ptr [ psw + rcx ]  
		mov rbx, len           
		div rbx                 
		mov al, byte ptr [ AusgabeText + rdx ]
		mov bl, byte ptr [ AusgabeText + rcx - 1 ]
		mov byte ptr [ AusgabeText + rcx - 1 ], al
		mov byte ptr [ AusgabeText + rdx ], bl
	loop xm

	mov rcx, len
	mov r8,1
	ym:;third encoding level
		xor rdx, rdx
		mov al, byte ptr [ psw + r8 ]  
		mov rbx, len           
		div rbx                 
		mov al, byte ptr [ AusgabeText + rdx ]
		mov bl, byte ptr [ AusgabeText + r8 - 1 ]
		mov byte ptr [ AusgabeText + rdx ], bl
		mov byte ptr [ AusgabeText + r8 - 1 ], al
		inc r8
	loop ym

	mov rax, len
	ys:;second encoding level
		mov cl, byte ptr [ psw + rax ] 
		rol byte ptr [ AusgabeText + rax - 1 ], cl 
		dec rax
		cmp rax, 0
		jne ys

    mov rcx, len
    y:;first encoding level
		rol byte ptr [ AusgabeText + rcx - 1], cl 
        loop y

    ret
main ENDP
end