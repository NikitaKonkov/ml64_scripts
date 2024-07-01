# 001 Tutorial 64 Bit Assembler deutsch Programmierumgebung einrichten
	##############################################################################################################################
	Microsoft Visual Studio Community Edition
	Links:
	Microsoft Visual Studio
	https://visualstudio.microsoft.com/de/downloads/
	
	Create new cpp project 
	
	Delete all header files

	Create Source.cpp and File.asm

	Project Built dependencies MASM

	File property/item type/ Microsoft Macro Assebler
	
	Press ok in Microsoft Macro Assebler
	##############################################################################################################################
# 024 Tutorial 64 Bit Assembler deutsch Windows Ausgabe
	##############################################################################################################################
	Kommunikation mit Windows z.B. Eingabe/Ausgabe

	calling convention

	Die ersten viert Werte an oder von Windows:
	RCX (Handle), RDX (AusgabeText), R8 (Textlänge), R9 (geschrieben)
	weitere Werte über Stack

	Stack für vier Werte reservieren "shadow space"
	Stack wieder aufräumen nicht vergessen

	Ein return Wert:
	RAX

	Windows kernel32 Funktionen (PROTO = imported function):
	GetStdHandle   PROTO
	WriteConsoleA  PROTO
	deviceCode EQU -11
	------------------------------------------------------------------------------------------------------------------------------
	INCLUDELIB kernel32.lib
	ExitProcess PROTO
	GetStdHandle PROTO      ;importiere Windows Funktion
	WriteConsoleA PROTO      ;importiere Windows Funktion
	deviceCode EQU -11       ;Windows Funktion -11 = Consolen Ausgabe 
	.data
		AusgabeText BYTE 10,' Hello World! ',10  ;10 ist Zeilenumbruch (ASCII LF line feed)
		Handle QWORD ?        ;Windows Variable für GetStdHandle
		geschrieben BYTE ?       ;Windows Variable für geschriebene Ausgaben

	.code
		main proc
		   
		xor rcx, rcx        ;vier Werte an Windows (Handle)
		xor rdx, rdx        ;vier Werte an Windows (AusgabeText)
		xor r8, r8         ;vier Werte an Windows (Textlänge)
		xor r9, r9         ;vier Werte an Windows (geschrieben)
		xor rax, rax        ;return Wert
		sub rsp, 32         ;Stack shadow space 4 * 8 Byte
		
		mov rcx, deviceCode       ;-11 Consolen Ausgabe
		call GetStdHandle       ;Empfange rax Handle und rcx deviceCode von Windows
		mov Handle, rax        ;rax Handle in Variable speichern
		
		MOV RCX, Handle        ;RCX (Handle) 
		LEA RDX, AusgabeText      ;RDX (AusgabeText)
		MOV R8, LENGTHOF AusgabeText    ;R8 (Textlänge) 
		LEA R9, geschrieben       ;R9 (geschrieben)
		CALL WriteConsoleA       ;Ausgabe in Console
		ADD RSP, 32         ;Aufräumen Stack shadow space
		
		CALL ExitProcess
	main ENDP
	end
	##############################################################################################################################
# 025 Tutorial 64 Bit Assembler deutsch Schriftzeichen ASCII sizeof stos lods
	##############################################################################################################################
	Schriftzeichen (Characters)

	ASCII American Standart Code for Information Interchange

	1 Schriftzeichen ist 1 Byte
	Texte (strings) sind Byte-Arrays

	Schriftzeichen   Hex   Dez
	'a'		 61    97
	'A'		 41    65

	Schriftzeichen byte 'abc'
	
	mov rax, sizeof Schriftzeichen
	------------------------------------------------------------------------------------------------------------------------------
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
	##############################################################################################################################
	Schriftzeichen im Speicher ablegen

	STOS storing string (speichern)

	stosb byte
	stosd word
	stosw double word
	stosq quad word

	direction flag 0(aufwärts) 1(abwärts)
	cld clear direction flag

	rep (reapeat) Anzahl in RCX (wie Array Kapitel 23)
	Quelle al, ax, eax, rax
	Zieladresse RDI

	cld
	rep stosb / stosb
	------------------------------------------------------------------------------------------------------------------------------
		.data
		Ziel byte 3 dup (?)

	.code
		main proc

		mov al, 'A'
		lea rdi, ziel
		mov rcx, sizeof Ziel

		cld
		rep stosb

		ret
	main endp
	end
	##############################################################################################################################
	Schriftzeichen im Speicher ablegen

	LODS loading string (laden)

	lodsb byte
	lodsd word
	lodsw double word
	lodsq quad word

	direction flag 0(aufwärts) 1(abwärts)
	cld clear direction flag

	rep (reapeat) Anzahl in RCX (wie Array Kapitel 23)
	Quelle al, ax, eax, rax
	Zieladresse RDI

	cld
	rep lodsb / lodsb
	------------------------------------------------------------------------------------------------------------------------------
		.data
		demo byte 'abc'

	.code
		main proc

		lea rsi, demo
		mov rdi, rsi
		mov rcx, sizeof demo
		cld

		l:
		lodsb
		sub al, 32
		stosb
		dec rcx
		jnz l

		ret
	main endp
	end
	##############################################################################################################################
# 026 Tutorial 64 Bit Assembler deutsch scas cmps
	##############################################################################################################################
	Schriftzeichen im Speicher einzeln vergleichen
	
	scas   scan string (untersuchen)

	scasb  byte
	scasw  word
	scasd  double
	scasq  quad

	direction flag 0(aufwärts) 1(abwärts)
	cld   clear direction flag

	repne  repeat if not equal (wiederhole wenn ungleich)

	Vergleiche al, ax, eax, rax
	Startadresse zu untersuchen RDI
	Zähler RCX wird runtergezählt und wird 0 wenn ungleich

	Zero Flag 1 wenn gefunden

	cld
	repne scasb

	------------------------------------------------------------------------------------------------------------------------------
		.data
		ZumTesten byte 'abc'

	.code
		main proc

		xor rax, rax
		mov al, 'x' ;      
		lea rdi, ZumTesten
		mov rcx, sizeof ZumTesten

		cld
		repne scasb  <- if char not found ZR = 0

		 ret
	main endp
	end
	##############################################################################################################################
	Schriftzeichen im Speicher mehrfach vergleichen

	cmps   scan string (untersuchen)

	cmpsb  byte
	cmpsw  word
	cmpsd  double
	cmpsq  quad
	
	direction flag 0(aufwärts) 1(abwärts)
	cld   clear direction flag
	
	repe  repeat if equal (wiederhole wenn gleich)
	
	Adresse VergleichsText1 RSI
	Adresse VergleichsText2 RDI
	Zähler RCX wird runtergezählt und wird 0 wenn gleich
	
	Zero Flag 1 wenn gleich
	
	cld
	repe cmpsb
	------------------------------------------------------------------------------------------------------------------------------
		.data 
		VergleichsText1 byte 'abcd'
		VergleichsText2 byte 'abce'

	.code
		main proc
		lea rsi,VergleichsText1 
		lea rdi,VergleichsText2
		mov rcx, sizeof VergleichsText2

		cld
		repe cmpsb  <- if text not equal ZR = 0

		ret
	main endp
	end
	##############################################################################################################################
# 027 Tutorial 64 Bit Assembler deutsch Macros
	##############################################################################################################################
	MacroName textequ <VeryLongTextWhichIsNotCool>

	MacroName Macro
		xor rax, rax
		xor rbx, rbx
		xor rcx, rcx
	endm

	use:
	name <- just the name
	------------------------------------------------------------------------------------------------------------------------------
	bit textequ <mov rax, 0ABCDEF9876543210h>

	fiver macro
		mov rax, 5
		mov rbx, 5
		mov rcx, 5
	endm
	
	.data
	.code
		main proc
		fiver
		bit
		ret
	main endp
	end
	##############################################################################################################################
	Einzelne Parameter

	name macro parameter
		xor parameter, parameter
	endm

	use:
	name rax <- rax is the parameter
	------------------------------------------------------------------------------------------------------------------------------
	reg0 macro param
		xor param, param
	endm
	
	.data
	.code
	main proc
		reg0 rax 
		ret
	main endp
	end
	##############################################################################################################################
	Mehrere Parameter
	
	name macro erforderlich:req, variabl1:=<Zahl1>, variable2:=<zahl2>
		mov erforderlich, variable1
		add erforderlich, variable2
	endm

	name erforderlich
	name erforderlich, 2
	name erforderlich, 2, 1
	------------------------------------------------------------------------------------------------------------------------------
	reg0 macro x:req, y:=<4>, z:=<5>
		mov x, y
		add x, z
	endm

	.data
	.code
	main proc
		reg0 rax
		reg0 rbx, 2
		reg0 rcx, 9, 6
		ret
	main endp
	end
	##############################################################################################################################
	Macro mit Bedingungen   (if / else)

	if Bedingung1 ? Bedingung2
	dann diese Zeile

	elseif Bedingung1 !? Bedingung2

	else
	eine Alternative

	endif

	------------------------------------------------------------------------------------------------------------------------------
		teste macro Zahl 
		if Zahl eq 5
			mov rax, 69
		elseif Zahl eq 10
			mov rax, 55
		else
			mov rax, 88
		endif
	endm

	.data
	.code
	main proc
		teste 5
		ret
	main endp
	end
	##############################################################################################################################
	Macro mit Schleife

	repeat Anzahl
	mach was so oft wie Anzahl
	endm

	while Bedingung1 ? Bedingung2
	mach was solange Bedingung passt
	endm

	local Variable  ; veränderbare Variable in while Schleide
	------------------------------------------------------------------------------------------------------------------------------
		m1 macro Anzahl
		repeat Anzahl
		inc rax
		endm
	endm

	m2 macro Wert
		local Zeahler  ; Local Variable
		Zeahler = Wert
		while Zeahler lt 10
			mov rbx, Zeahler
			Zeahler = Zeahler + 1
		endm
	endm
	
	.data
	.code
	main proc
		xor rax, rax
		xor rbx, rbx
		m1 5
		m2 1
		ret
	main endp
	end
	##############################################################################################################################
	Macro mit Rückgabewert

	name macro
	Rückgabewert = 1
	exit, <Rückgabewert>
	endm

	mov rax, Name(Rückgabewert)
	------------------------------------------------------------------------------------------------------------------------------
	m1 macro
		wert = 7
		exitm <wert>
	endm

	.data
	.code
		main proc
		mov rax, m1()
		ret
	main endp
	end
	##############################################################################################################################
	gt	greater then
	lt	less then
	eq	equal
	ne	not equal
	ge	greater or equal
	le	less or equal
	##############################################################################################################################

# 028 Tutorial 64 Bit Assembler deutsch proc ret endp
	##############################################################################################################################
	Eigene Prozedere (procedure)

	.data
	.code

	NameProc proc
		ret
	NameProc endp

	main proc    
		ret		
	main endp	 

	end
				call Name
	Rückkehradresse (ret) wird im Stack gespeichert
	------------------------------------------------------------------------------------------------------------------------------
		.data
	.code

	fiver proc
		mov rax, 5
		mov rbx, 5
		mov rcx, 5
		ret
	fiver endp
	
	main proc
		call fiver
		nop
		ret
	main endp
	end
	##############################################################################################################################
	Externe Prozedere (procedure)

	INTENRN		| EXTERN
	.data		| 
	.code		| .code
	main proc	| Name proc
	call Name	| 	ret
	ret		| Name endp
	main endp	| end
	end		|
	Rückkehradresse (ret) wird im Stack gespeichert
	------------------------------------------------------------------------------------------------------------------------------

	INTENRN    |EXTERN
	fiver proto|
	.data      |
	.code      | .code
	           | 
	main proc  |fiver proc
	call fiver |	mov rax, 5
	nop        |	mov rbx, 5
	ret        | 	ret
	main endp  |fiver endp
	end        |end
	##############################################################################################################################
# 029 Tutorial 64 Bit Assembler deutsch Windows Eingabe
	##############################################################################################################################
	Kommunikation mit Windows z.B Eingabe

	calling convention (Aufrufkonvention)

	Die ersten vier Werte an oder von Windows
	RCX (Handle), RDX (EingabeText), R8(Textlänge), R9(eingelesen)
	weitere werte über das Stack

	Stack für viert Werte reservieren "shadow space" 
	Stack wieder aufräumen nicht vergessen!

	Ein return Wert:
	RAX = 1 wenn einlesung erfolgreich, ansonnsten RAX = 0

	Windows kernel32 Funktionen (PROTO = importieren):
	GetStdHandle	PROTO
	REadConsoleA	PROTO	statt WriteConsoleA
	deviceCode EQU -10		statt -11
	------------------------------------------------------------------------------------------------------------------------------
	includelib kernel32.lib
	ExitProcess proto
	
	GetStdHandle proto
	ReadConsoleA proto   ; statt WriteConsoleA
	deviceCode equ -10   ; statt -11 jetzt input

	.data
		Eingabe byte 20 dup (?)  ; statt AusgabeText jetzt Array für Eingabe
		Handle qword ?   
		Textlaenge byte ?   ; statt geschrieben jetzt erwartet
	
	.code
		main PROC
		xor rcx, rcx
		xor rdx, rdx
		xor r8, r8
		xor r9, r9
		xor rax, rax
		sub rsp, 32    
		
		mov rcx, deviceCode   ; -10 Consolen Eingabe
		call GetStdHandle  
		mov Handle, rax   
		
		mov rcx, Handle   
		lea rdx, Eingabe
		mov r8, lengthof Eingabe
		lea r9, Textlaenge
		call ReadConsoleA   ; Eingabe angefordert
		add rsp, 32    
		lea r10, Eingabe   ; Speicherstelle der Eingabe
		nop       ; nix
		
		call ExitProcess
	main endp
	end
	##############################################################################################################################
# Output Input Windows
	Handlin Input and Output with Windows
	------------------------------------------------------------------------------------------------------------------------------
	INCLUDELIB kernel32.lib
	ExitProcess PROTO
	GetStdHandle PROTO
	ReadConsoleA PROTO
	WriteConsoleA PROTO
	
	deviceCodeInput EQU -10   ; Windows Funktion -10 = Consolen Eingabe
	deviceCodeOutput EQU -11  ; Windows Funktion -11 = Consolen Ausgabe
	
	.data
	    Eingabe BYTE 256 DUP (?)  ; Buffer for input
	    Textlaenge DWORD ?        ; Length of the input text
	    geschrieben DWORD ?       ; Windows Variable for written output
	
	.code
	main proc
	    ; Clear registers
	    xor rcx, rcx
	    xor rdx, rdx
	    xor r8, r8
	    xor r9, r9
	    xor rax, rax
	    sub rsp, 32         ; Stack shadow space 4 * 8 Byte
	
	    ; Get handle for console input
	    mov rcx, deviceCodeInput
	    call GetStdHandle
	    mov rcx, rax        ; RCX (Handle for input)
	
	    ; Read input from console
	    lea rdx, Eingabe    ; RDX (Buffer for input)
	    mov r8d, 256        ; R8D (Buffer size, 32-bit)
	    lea r9, Textlaenge  ; R9 (Length of input text)
	    call ReadConsoleA
	
	    ; Get handle for console output
	    mov rcx, deviceCodeOutput
	    call GetStdHandle
	    mov rcx, rax        ; RCX (Handle for output)
	
	    ; Write input to console
	    lea rdx, Eingabe    ; RDX (Buffer for input)
	    mov r8d, Textlaenge ; R8D (Length of input text, 32-bit)
	    lea r9, geschrieben ; R9 (Written output length)
	    call WriteConsoleA
	
	    add rsp, 32         ; Clean up stack shadow space
	    call ExitProcess
	main endp
	end
	
# 030 Tutorial 64 Bit Assembler deutsch Windows Fenster, API Grundlagen am Beispiel einer Message Box
	##############################################################################################################################
	includelib kernel32.lib
	ExitProcess proto   ; Achtung Groß- und Kleinschreibung
	includelib user32.lib
	MessageBoxA proto   ; Achtung Groß- und Kleinschreibung
	.data
		msg byte "Eine Nachricht",0
		ttl byte "Eigene MessageBoxA",0
	.code
		main proc
		xor rax, rax
		and rsp, -16  ; Stack ausrichten
		sub rsp, 32   ; Shadow space
		mov rcx, 0   ; Argument1
		lea rdx, msg  ; Argument2 Dialog
		lea r8, ttl   ; Argument3 Fenstertitel
		mov r9, 35   ; Argument4 Buttons
		call MessageBoxA
		call ExitProcess
		add rsp, 32   ; Stack aufräumen (Shadow space)
	main endp
	end