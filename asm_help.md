# ``x64 Architecture Reference``
### [ `Jump Statements` ] Jump instructions are used to alter the flow of execution based on the status of flags in the EFLAGS register.
    - Signed/Unsigned Jump -
    JA   - Jump if above
    JAE  - Jump if above or equal
    JB   - Jump if below
    JBE  - Jump if below or equal
    JE   - Jump if equal
    JG   - Jump if greater 
    JGE  - Jump if greater or equal
    JL   - Jump if less
    JLE  - Jump if less or equal
    JNA  - Jump if not above
    JNAE - Jump if not above or equal
    JNB  - Jump if not below
    JNBE - Jump if not below or equal
    JNE  - Jump if not equal
    JNG  - Jump if not greater
    JNGE - Jump if not greater or equal
    JNL  - Jump if not less
    JNLE - Jump if not less or equal
    - Flag Jump -
    JNO  - Jump if not overflow
    JNP  - Jump if not parity
    JNS  - Jump if not sign
    JNZ  - Jump if not zero
    JO   - Jump if overflow
    JP   - Jump if parity
    JPE  - Jump if parity even
    JPO  - Jump if parity odd
    JS   - Jump if sign
    JZ   - Jump if zero
    JC   - Jump if carry
    JNC  - Jump if no carry
    - Adress Jump -
    JMP  - Standart jump can also use inderect addresing
### [ `Registers` ] General-purpose registers (GPRs) are used for various data manipulation tasks within the CPU.
    RAX  - Accumulator for operands and results data
    RBX  - Base pointer for memory addressing
    RCX  - Counter for loops and operations
    RDX  - Data register for I/O operations
    RSI  - Source index for string operations
    RDI  - Destination index for string operations
    R8   - General purpose register
    R9   - General purpose register
    R10  - General purpose register
    R11  - General purpose register
    R12  - General purpose register
    R13  - General purpose register
    R14  - General purpose register
    R15  - General purpose register
    RIP  - Instruction Pointer
    RSP  - Stack pointer for top of the stack
    RBP  - Base pointer for stack frame
### [ `Registers` ] List of all registers in bits
    64bit | 32bit  | 16bit | 8bit
    ------| -------|-------|-------
    rax   | eax    | ax    | al
    rcx   | ecx    | cx    | cl
    rdx   | edx    | dx    | dl
    rbx   | ebx    | bx    | bl
    rsi   | esi    | si    | sil
    rdi   | edi    | di    | dil
    rsp   | esp    | sp    | spl
    rbp   | ebp    | bp    | bpl
    r8    | r8d    | r8w   | r8b
    r9    | r9d    | r9w   | r9b
    r10   | r10d   | r10w  | r10b
    r11   | r11d   | r11w  | r11b
    r12   | r12d   | r12w  | r12b
    r13   | r13d   | r13w  | r13b
    r14   | r14d   | r14w  | r14b
    r15   | r15d   | r15w  | r15b
### [ `Operators` ] Operator instructions are used for performing arithmetic and logical operations.
    ADD  - Add
    SUB  - Subtract
    MUL  - [ mul rax, (A) ] 
    iMUL - Nagativ multiplication [ mul rax, (A) ] or [ mul rax, (A), 31 ]
    DIV  - [ div (A) -> rax = rax / (A) -> rdx = rax mod (A) ]
    iDiv - Negativ division
    MOD  - Modulos [ mov rax, A mod B ]
    INC  - Increment [ (A)++ ]
    DEC  - Decrement [ (A)-- ]
    NEG  - Negilate [ +(A) -> -(A) ]
    AND  - Bitwise AND [ (A)110110 & (B)101010 -> (A)100010 ]
    OR   - Bitwise OR  [ (A)111000 | (B)000101 -> (A)111101 ]
    XOR  - Bitwise XOR [ (A)111000 ! (B)111111 -> (A)000111 ]
    NOT  - Bitwise NOT [ (A)110011 -> (A)001100 ]
    SHL  - Shift left  [ (A)110101 -> (A)101010 ]
    SHR  - Shift right [ (A)110101 -> (A)011010 ]
    SAL  - signed shift left [  ]
    SAR  - signed shift right MSB stays
    ROL  - Rol left no carry  [ <- 101|00100101|00100 <- ] "rol (A), (cl)"
    ROR  - Rol right no carry [ -> 10100|10010100|100 -> ]
    RCL  - inclusive carry flag [ dont use in loop ]
    RCR  - inclusive carry flag [ same ]
    CMP  - Compare two operands [ cmp (A), (B) ]
    TEST - [ 111b -> (zr = 0 if test 111b == 011b == 001b) != (000b else zr = 1) ]
    XCHG - Exachange two values [ xchg (A), (B) -> (A) ⇆ (B) ]
    PUSH - Push data on stack
    POP  - Pop data from stack
    LEA  - Load effectiv Adress [ lea (A), data -> save adress in (A)]
    PTR  - Pointer [ mov qword ptr [ dereference/adress ], 123 ] or [ mov [rax], 123 ]
    STC  - Set CY flag true
    CLC  - Clear CY flag to false
    LOOP - Using RCX as counter for loop [ x: while (rcx > 0) { dec rcx; jmp (x)}]
    EQU  - Constant declaration [ var equ 3.14159 ]
# `x64 Assembly Data Definitions`
   
### Data Definition Directives
### Data definition directives are used to declare initialized data in the data segment. Byte, Word, Doubleword, Quadword, and Ten Bytes
    DB   - Define Byte (8 bits)
    DW   - Define Word (16 bits)
    DD   - Define Doubleword (32 bits)
    DQ   - Define Quadword (64 bits)
    DT   - Define Ten Bytes (floating point)

    byteVal     DB      0x55              ; Define a single byte
    wordVal     DW      0x1234            ; Define a word (2 bytes)
    dwordVal    DD      0x12345678        ; Define a doubleword (4 bytes)
    qwordVal    DQ      0x123456789ABCDEF ; Define a quadword (8 bytes)
    tenBytes    DT      1.234567e20       ; Define ten bytes (floating point)
### Arrays movs rep cld std
    array qword 10 DUP(0) [ 0,0,0... 0 ]  ; Define an array of 10 words, all initialized to 0 
    array qword 123,11 [ array[1] == 11 ] ; Acces to array
    mov rax, lengthof array [          ]  ; Get the length of the array

    movsb  Byte  *
    movesw Word  *
    movesd DWord *
    movesq QWord [ RSI -> RDI ] source -> destination

    REP  - Repeat RCX (count)
    CLD  - Clear direct Flag [ UP = 0 ]
    STD  - Set direction flag [ UP = 1 ]

    EXAMPLE:
    lea rsi, arr0          ; Source to RSI
    lea rdi, arr1          ; Destination to RDI
    mov rcx, lengthof arr0 ; Length to RCX
    cld                    ; Clear Direction flag
    rep movsb              ; Copy source to destination
### ASCII and Strings
    Schriftzeichen im Speicher ablegen
    STOS storing string (speichern)
    
    stosb byte
    stosw
    stosd
    stosq
    
    direction flag 0(aufwärts) 1(abwärts)
    cld     clear direction flag
    
    rep (repeat) Anzahl in RCX
    Quelle al - rax
    Zieladresse rdi

    cld
    (mehrere)rep stosb / (1)stosb

### Floating Point Data Types
### For floating point numbers, specific directives ensure correct storage and representation.
    REAL4 - Single Precision Floating Point (32 bits)
    REAL8 - Double Precision Floating Point (64 bits)
    REAL10 - Extended Precision Floating Point (80 bits)

    single      REAL4   3.14159           ; Define a single precision floating point
    double      REAL8   2.718281828459    ; Define a double precision floating point
    extended    REAL10  1.618033          ; Define an extended precision floating point
    
### Uninitialized Data
### To declare uninitialized data, use the RES directives, which reserve space without initializing it.
    RESB - Reserve Byte
    RESW - Reserve Word
    RESD - Reserve Doubleword
    RESQ - Reserve Quadword
    REST - Reserve Ten Bytes

    .bss
    buffer  RESB    64                    ; Reserve 64 bytes
    
### Flags
    Carry Flag		CY   true wenn ergebniss ov
    Overflow Flag	        OV   true wenn bit ov
    Sign Flag		PL   true Negatives ergebniss
    Zero Flag		ZR   true ergebniss zero

### Integers
    | unsigned int  | signed int |
    |---------------+------------|
    | Byte          | SByte      |
    | Word          | SWord      |
    | DWord         | SDWord     |
    | QWord         | SQWord     |

### Additional Notes
* Use hexadecimal notation (0x) for clarity in defining numeric constants. 
* Character constants ('a', 'hello') and string constants ("Hello, world!") are also supported. 
* Floating point constants can be declared using scientific notation for clarity and precision.
