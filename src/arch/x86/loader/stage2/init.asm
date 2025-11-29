org 0x2000
bits 16

main:

xor ax, ax
mov ds, ax
mov es, ax

mov ss, ax
mov sp, 0x9000

call enable_a20 
call enter_protected_mode

mov si, hello

.loop:

    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

done:
    hlt
    jmp $

%include "protectedmode.asm"

hello: db 'Hello world from stage2!!!', 0x0D, 0x0A, 0

times 510-($-$$) db 0
