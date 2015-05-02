section .data
	msje db "esta mal",10,0

section .bss

	BufferReader 	 resb 2048
	lenBufferReader equ $ - BufferReader ; 
	BufferPrimerByte 	 resb 1024
	lenBufferPrimerByte equ $ - BufferPrimerByte ; 

	Operacion  resb 1024; aqui va a ir guardada la expresion separada de las variables
	lenOperacion equ $ - Operacion;



section .text
	global _start
_start:
main:
	call read
	
	call atoi

	call imprimir
	call salir

prueba:
	xor r14,14
	mov r14,rax
	sub r14,2
	mov rcx,r14
	dec rcx
	mov bl,[BufferReader+r14]
	sub bl,'0'
	mov rax,rbx
	sub rax,3
	cmp rax,0
	je salir
	mov rsi,msje
	mov rdx,9
	ret


atoi:
	xor r8,r8
	mov r8,rax
	sub r8,1
	xor r12,12
	mov r12,10
	xor rcx,rcx
	mov rcx,-1
	xor r11,r11
	xor r10,r10
	mov r10,0;respuesta
	xor r9,r9
	mov r9,r8
	;add r9,1
	
	;xor r8,r8
	;mov r8,-1
	.ciclo:
	;inc r8
	inc rcx
	mov r11,r8
	sub r11,rcx
	
	mov bl, byte[BufferReader+rcx]
	sub bl,'0'
	;xor rax,rax
	mov rax,rbx
	.ciclo2:
	mul r12
	dec r11
	cmp r11,0
	ja .ciclo2
	div r12
	add r10,rax
	dec r9
	cmp r9,0
	ja .ciclo

	mov rax,r10
	;div r12
	
	;Prueba
	sub rax,1024
	cmp rax,0
	je salir
	mov rsi,msje
	mov rdx,8
	ret


read:
	mov rax, 0 ; (sysread)
	mov rdi, 0 ;(stdimp)
	mov rsi, BufferReader
	mov rdx, lenBufferReader
	syscall
	cmp rax, 1
	jz salir
	ret

imprimir:
	mov rax,1
	mov rdi,1
	syscall

salir:
	mov rax,60 ; (sysExit)
	mov rdi, 0
	syscall
