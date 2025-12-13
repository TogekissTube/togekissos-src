.code16

.global start

start:

	/* SETTING UP REGISTERS */

	xorw %ax, %ax
	movw %ax, %ds
	movw %ax, %es

	/* Setting up stack */

	movw %ax, %ss
	movw $0x7000,  %sp

	/* LOAD MESSAGE */
	movw $hello, %si

	/* CALLING READ FROM FLOPPY FUNCTION */

	call disk

.global disk

disk:

	/* READ FROM FLOPPY FUNCTION */

    movb $0x02, %ah
    movb $0x02, %al
    movb $0x00, %ch 
    movb $0x02, %cl
    movb $0x00, %dh
    movb $0x00, %dl


    movw $0x00, %bx
    movw %bx, %es
    movw $0x2000, %bx

    int $0x13
    jc disk_error
    ret

.global disk_error

disk_error:
    movw $error, %si
	call print
    int $0x16
    int $0x19

.global print

print:
	xorb %bh, %bh

	movb $0x0E, %ah
	lodsb

	/* PERFORMS NULL CHECK */

	cmpb $0, %al
	je done

	int $0x10;
	jmp print

hello:
	.asciz "HELLO WORLD!"

error:
	.asciz "ERROR, STAGE2 not found, FLOPPY IS CORRUPTED"

done:
	jmp .

/* MBR BOOT SIGNATURE */
.org 510
.word 0xAA55
