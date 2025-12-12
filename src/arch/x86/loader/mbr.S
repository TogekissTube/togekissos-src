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

done:
	jmp .

/* MBR BOOT SIGNATURE */
.org 510
.word 0xAA55
