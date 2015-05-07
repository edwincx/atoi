section .data
	msje db "Numero:",10,0
	lenMsje equ $ - msje
	numero db "                             ",10,0
	lenNumero equ $ - numero

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
	mov rsi,msje
	mov rdx,lenMsje
	call imprimir
	call read
	call atoi

	mov rax,r10
	call itoa

	;call imprimir
	call salir



atoi:
	xor r12,12
	mov r12,10;para dividir entre 10
	xor rcx,rcx
	mov rcx,-1;indice de los chats
	xor r11,r11
	xor r10,r10
	mov r10,0;respuesta
	xor r9,r9;recorrido total
	mov r9,r15
	dec r9
	
	.ciclo:
		inc rcx
		mov r11,r15
		dec r11
		sub r11,rcx
	
		mov bl, byte[BufferReader+rcx]
		sub bl,'0'
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

	;mov rax,r10;respuesta
	
	;Prueba
	;sub rax,256
	;cmp rax,0
	;je salir
	;mov rsi,msje
	;mov rdx,8
	ret
itoa:
	;xor r13,r13
	;mov r13,10
	;xor r12,r12
	;mov r12,1;para dividir y multiplicar entre 10
	;mov r10,rax
	;xor r14,r14
	;mov r14,0
	;xor bl,bl
	;mov bl,0
	
	;.cicl:
	;mov rax,r12
	;mul r13
	;mov r12,rax
	;inc r14
	;inc bl
	;mov rax,r10
	;div r12
	;cmp rax,r12
	;ja .cicl

	;add bl,'0'
	;mov byte[BufferPrimerByte+0],bl
	;mov rsi,BufferPrimerByte
	;mov rdx,lenBufferPrimerByte
	;call imprimir

	;mov rax,r10

	xor rcx,rcx;sostener el digito
	xor r11,r11
	mov r11,r15;indice
	sub r11,2

	.digito:
		div r12
		mov rcx,rdx
		add rcx,'0'
		mov [numero+r11],cl
		.prox:
			xor rdx,rdx
			xor rcx,rcx
			dec r11
			cmp r11,-1
			je .imp
			cmp rax,0
	jne .digito
	.imp:
		mov rsi,numero
		mov rdx,lenNumero
		call imprimir
		ret
	
	
	add bl,'0'
	mov byte[BufferPrimerByte+0],bl


	mov rsi,BufferPrimerByte
	mov rdx,lenBufferPrimerByte
	ret
read:
	mov rax, 0 ; (sysread)
	mov rdi, 0 ;(stdimp)
	mov rsi, BufferReader
	mov rdx, lenBufferReader
	syscall
	cmp rax, 1
	jz salir
	mov r15,rax
	ret

imprimir:
	mov rax,1
	mov rdi,1
	syscall
	ret

salir:
	mov rax,60 ; (sysExit)
	mov rdi, 0
	syscall
