global start

section .text
bits 32
start:
    lgdt [gdt_descriptor]
    
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov gs, ax
    mov fs, ax
    jmp 0x8:new_protect
new_protect:
    ; mov eax, 0x3333
    ; print `OK` to screen
    mov dword [0xb8000], 0x2f4b2f4f
    mov dword [0x10000], 0x1234
    hlt



gdt_start:

gdt_null:
    dq 0x0000000000000000

gdt_code:
    dq 0x00cf9a000000ffff
  
gdt_data:
    dq 0x00cf92000000ffff

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start   ; gdt length
    dd gdt_start                ;gdt line addreess

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start