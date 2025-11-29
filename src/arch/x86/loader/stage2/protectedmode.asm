
enable_a20:
	in al, 0x92
	or al, 2
	out 0x92, al

	mov cx, 0xFFFF

.delay:
    loop .delay

	ret

gdt_start:
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xffff    
    dw 0x0       
    db 0x0       
    db 10011010b 
    db 11001111b 
    db 0x0       

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b 
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 
    dd gdt_start 

enter_protected_mode:
    cli
    lgdt [gdt_descriptor]

    ; Setup CR0 register

    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE_SEGMENT:after

bits 32
after:
    mov ax, DATA_SEGMENT
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    hlt

CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start
