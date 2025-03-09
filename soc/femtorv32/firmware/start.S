.equ MEM_SIZE, 0x400  
.section .text
.globl start
start:
	li   sp, MEM_SIZE
	call main
	ebreak
	