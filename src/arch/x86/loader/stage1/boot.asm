org 0x7C00
bits 16

main:

xor ax, ax
mov ds, ax
mov es, ax

; Setup stack

mov ss, ax
mov sp, 0x7C00

mov si, hello

call disk

jmp 0x000:0x2000

.loop:

    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

disk:   
    mov ah, 2
    mov al, 2
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0
    mov bx, 0
    mov es, bx
    mov bx, 0x2000
    int 0x13
    jc disk_error
    ret

disk_error:
    mov si, error
    int 0x16
    int 0x19

done:
	ret

jmp $

hello: db 'Loading!', 0x0D, 0x0A, 0
error: db 'Failure to launch stage2, floppy corruption?', 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0xAA55
