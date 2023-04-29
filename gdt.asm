; Creación de GDT (Global Descriptor Table)
; Se configura el segmento nulo, el segmento de código, y el segmento de datos (solapados).

gdt_start:

    ; Null descriptor : 64 bits en 0
    gdt_null:       
        dd 0x0          ; 32 bits en 0
        dd 0x0          ; 32 bits en 0

    ; Code descriptor
    gdt_code:
        dw 0xffff       ; Segment limiter Bits 15-0 (Size of GDT in bytes)
        dw 0x0          ; Base address Bits 15-0
        db 0x0          ; Base address Bits 23-16
        db 10011010b    ; Bit 8:     A (Accessed) = 0
                        ; Bit 9:     Readable = 1
                        ; Bit 10:    Conforming = 0
                        ; Bit 11:    Code = 1
                        ; Bit 12:    S (Segment Type) = 1 
                        ; Bit 14-13: DPL (Descriptor Privilege Level) = 00 (Highest privilege)
                        ; Bit 15:    P (Present flag) = 1 (segment present)
        db  11001111b   ; Segment limiter (Bits 19-16)
                        ; Bit 20     AVL (Available to System Programmers) = 0
                        ; Bit 21:    Reserved bit = 0 
                        ; Bit 22:    D/B = 1  
                        ; Bit 23:    G (Granularity) = 1 (limit *= 0x1000)
        db  0x0         ; Base addres (Bits 24-31)
    
    ; Data descriptor
    gdt_data:
        dw 0xffff       ; Segment limiter Bits 15-0 
        dw 0x0          ; Base address Bits 15-0
        db 0x0          ; Base address Bits 23-16
        db 10010010b    ; Bit 8:     A (Accessed) = 0
                        ; Bit 9:     Writable  = 1 (Read only)
                        ; Bit 10:    Direction = 0 (expand down segment)
                        ; Bit 11:    Code = 0 (Data segment)
                        ; Bit 12:    S (Segment Type) = 1 
                        ; Bit 14-13: DPL (Descriptor Privilege Level) = 00 (Highest priviege)
                        ; Bit 15:    P (Present flag) = 1 (segment present)
        db  11001111b   ; Segment limiter Bits 19-16
                        ; Bit 20     AVL (Available to System Programmers) = 0
                        ; Bit 21:    Reserved bit = 0 
                        ; Bit 22:    D/B = 1  
                        ; Bit 23:    G (Granularity) = 1 (limit *= 0x1000)
        db  0x0         ; Base addres Bits 24-31
gdt_end:

gdt_descriptor:
    dw  gdt_end - gdt_start - 1     ; Size of GDT (16 bits)
    dd  gdt_start                   ; Start (32 bits)

; Definición de constantes
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
                        





