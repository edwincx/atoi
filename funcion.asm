section .data
	msje db "esta mal",10,0
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
	call read
	mov r15,rax
	sub r15,2
	call atoi
	call itoa

	;call imprimir
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
	mov r8,rax;tamano del numero
	sub r8,1
	xor r12,12
	mov r12,10;para dividir entre 10
	xor rcx,rcx
	mov rcx,-1;indice de los chats
	xor r11,r11
	xor r10,r10
	mov r10,0;respuesta
	xor r9,r9;recorrido total
	mov r9,r8
	
	.ciclo:
		inc rcx
		mov r11,r8
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

	mov rax,r10;respuesta
	
	;Prueba
	;sub rax,256
	;cmp rax,0
	;je salir
	;mov rsi,msje
	;mov rdx,8
	ret
itoa:
	
	;xor r12,r12
	;mov r12,10;para dividir y multiplicar entre 10
	;xor bl,bl
	;mov bl,0
	;xor r11,r11
	;mov r11,1
	;xor r13,r13
	;mov r13,rax;sostiene el numero
	
	;xor r14,r14
	;mov r14,0
	
	;.cicl:
	;inc bl
	;mov rax,r11
	;mul r12
	;mov r11,rax
	;mov rax,r13
	;div r11
	;cmp al,0

	;mov al,al

	;jne .cicl

	xor rbx,rbx
	xor rcx,rcx
	xor r10,r10
	xor r11,r11
	xor r13,r13
	mov rdi,numero
	mov rbx,10
	mov r11,r15

	.digito:
		div rbx
		mov rcx,rdx
		add rcx,'0'
		mov [rdi+r11],cl
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
	
	
	;add bl,'0'
	;mov byte[BufferPrimerByte+0],bl


	;mov rsi,BufferPrimerByte
	;mov rdx,lenBufferPrimerByte
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
	;ret

salir:
	mov rax,60 ; (sysExit)
	mov rdi, 0
	syscall
