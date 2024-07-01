### 001 Tutorial 64 Bit Assembler deutsch Programmierumgebung einrichten
    Links:
    Microsoft Visual Studio
    https://visualstudio.microsoft.com/de...
    
    includelib legacy_stdio_definitions.lib
            .386
            .model flat, c
            .stack 100h
    printf  PROTO arg1:Ptr Byte
    
    .data
    msg1    byte "Hello World", 0Ah, 0
    
    .code
    main    proc
            INVOKE printf, ADDR msg1
            ret
    
    main    endp
            end
### 002 Tutorial 64 Bit Assembler deutsch Grundgerüst und Debugfenster
    .data
    Variable dq 255
    
    .code
    main proc
     
     mov rax, Variable
    
     ret
    main endp
    end
### 003 Tutorial 64 Bit Assembler deutsch Zahlensysteme
    HEX 0123456789ABCDEFG
    DEC 0123456789
    BIN 01
### 004 Tutorial 64 Bit Assembler deutsch Register
    .data
    VARIABLE dq 255
    .code
    main proc
     mov rax, variable
     
     MOV RAX, 0    ; RAX 0000 0000 0000 0000
     
     mov rax, -1    ; RAX FFFF FFFF FFFF FFFF
     
     mov eax, 011111111h ; RAX                    1111 1111
     mov rax, -1    ; RAX FFFF FFFF FFFF FFFF
    
     mov ax, 01111h   ; RAX                              1111
     mov rax, -1    ; RAX FFFF FFFF FFFF FFFF
    
     mov al, 0    ; RAX                                   00
     mov rax, -1    ; RAX FFFF FFFF FFFF FFFF
    
     mov ah, 0    ; RAX                               00
     mov eax, -1    ; RAX                     FFFF FFFF
      ret
    main endp
    end
### 005 Tutorial 64 Bit Assembler deutsch Datentypen
    .data
    Ganz0 db ?
    Ganz1 db 255
    Ganz2 word 65535
    Ganz3 dd 076543210h
    Ganz4 dq 0FEDCBA9876543210h
    
    Komma1 real4 1.0
    Komma2 real8 3.14
    
    .code
    main proc
     
     mov al, Ganz1
     mov bx, Ganz2
     mov ecx, Ganz3
     mov rdx, Ganz4
    
     movss xmm0, Komma1
     movsd xmm1, Komma2
    
     ret
    main endp
    end
### 006 Tutorial 64 Bit Assembler deutsch Variablen und Konstanten
    .data 
    Variable dq 255   ; Hex FF
    Konstante equ 123  ; Hex 7B
    
    .code
    main proc
      
     mov rax, Variable
     mov rbx, Konstante
    
     ret
    main endp
    end
### 007 Tutorial 64 Bit Assembler deutsch mov nop opcode
    .data 
    Variable dq 255   
    
    .code
    main proc
      
     ;mov rax, variable
     ;nop
     db 048h, 08Bh, 0C0h
    
     ret
    main endp
    end
### 008 Tutorial 64 Bit Assembler deutsch add sub mul div 
    .data
    Variable1 dq 5
    Variable2 dq 1
    Komma1 real4 0.5
    Komma2 real4 0.1
    Komma3 real4 ?
    
    .code
    main proc
     
     ; Addition
     mov rax, Variable1   
     mov rbx, 1   
     add rax, rbx     
    
     movss xmm0, Komma1   
     movss xmm1, Komma2   
     addss xmm1, xmm0   
     movss Komma3, xmm1
    
     ret
    main endp
    end
### 009 Tutorial 64 Bit Assembler deutsch RIP RSP
    .data
    variable dq 4294967295  ; FFFF FFFF   
    
    .code
    main proc
     
     mov rax, 5   
    
     push rax  ;rax (5) auf den Stack legen
     mov rax, 3   
    
     push variable  ;variable (FFFF FFFF) auf den Stack legen 
     mov variable, 170 
    
     pop variable  ;variable (FFFF FFFF) vom Stack holen
     pop rbx   ;ehemals rax (5) vom Stack holen aber in rbx schreiben
     
    
     ret
    main endp
    end
### 010 Tutorial 64 Bit Assembler deutsch Flag 
    .data
    
    .code
    
    main proc
    
     mov rax, 0
    
     mov al, 255   ; Maximum AL Register  255 = FF = 1111 1111
     add al, 1   ; Maximum AL Register + 1 setzt CY Carry Flag und ZR Zero Flag
    
     sub al, 1   ; 0 - 1 = -1 setzt PL Sign Flag
    
     mov al, 127   ; größte positive 8 Bit Zahl 0111 1111 
     add al, 1   ; 128 = binär 1000 000 
    
    
     ret
    main endp
    end
### 011 Tutorial 64 Bit Assembler deutsch inc dec neg 
    .data
    Variable dq 3
    
    .code
    
    main proc
     mov rax, Variable
     inc Variable
     dec rax
     neg rax
    
     ret
    main endp
    end
### 012 Tutorial 64 Bit Assembler deutsch and or xor not
    .data
    
    .code
    main proc
    
     mov rax, 0
     mov rbx, 0
     mov rax, 1010b
     mov rbx, 0110b
    
     ; AND
     and rax, rbx
     mov rax, 1010b
    
     ; OR
     or rax, rbx
     mov rax, 1010b
    
     ;XOR
     xor rax, rbx
     mov rax, 1010b
     
     ; NOT
     not rax
     
     ret
    main endp
    end
### 013 Tutorial 64 Bit Assembler deutsch Negative Zahlen Zweierkomplement 
    .data
    MinusDrei sqword -3
    MinusZwei sqword -2
    Ergebnis sqword ?
    
    .code
    main proc
    
     mov rax, MinusDrei
     add rax, MinusZwei ; -3 + -2 = -5
     mov Ergebnis, rax
    
     ret
    main endp
    end
### 014 Tutorial 64 Bit Assembler deutsch imul idiv
    .data
    MinusVier sqword -4
    MinusZwei sqword -2
    Ergebnis sqword ?
    
    .code
    main proc
    
    ; imul Multiplikator
    xor rax, rax    ; setzt rax auf 0
    mov rax, MinusZwei
    imul MinusVier    ; -2 * -4 = 8
    mov Ergebnis, rax
    
    ; imul Multiplikant, Multiplikator
    xor rax, rax    ; setzt rax auf 0
    mov Ergebnis, 0    ; setzt Ergebnis auf 0
    mov rax, MinusZwei
    imul rax, MinusVier   ; -2 * -4 = 8
    mov Ergebnis, rax
    
    ;imul Ziel, Multiplikant, Multiplikator
    xor rax, rax    ; setzt rax auf 0
    xor rbx, rbx    ; setzt rbx auf 0
    mov Ergebnis, 0    ; setzt Ergebnis auf 0
    mov rbx, MinusZwei
    imul rax, rbx, -4   ; -2 * -4 = 8
    mov Ergebnis, rax
    
     ret
    main endp
    end
### 015 Tutorial 64 Bit Assembler deutsch shl shr sal sar
    .data
    VerschiebeMich byte  10011001b ; Dezimal 153    
    
    .code
    main proc
     xor rax, rax   ; RAX auf 0 setzen
     mov aL, VerschiebeMich  ; Variable        10011001
     shr al, 1   ; SHift Right um 1 Bit 01001100
     shl al, 1   ; SHift Left um 1 Bit  10011000 
     shl al, 2   ; SHift Left um 2 Bit  01100000 
    
     ret
    main endp
    end
### 025 Tutorial 64 Bit Assembler deutsch Schriftzeichen ASCII sizeof stos lods
    .data
    Buchstabe byte 'a'  ; 1 Zeichen
    Wort byte 'Assembler' ; 9 Zeichen
    
    .code
    main proc
    
    mov al, Buchstabe
    lea rbx, Buchstabe
    
    mov rcx, sizeof Wort ;lengthof für Schriftzeichen
    mov rdx, lengthof Wort
    
     ret
    main endp
    end