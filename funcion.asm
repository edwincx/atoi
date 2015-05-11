section .data
	msje db "esta mal",10,0
	;numero db "               ",10,0
	;lenNumero equ $ - numero

section .bss

	BufferReader 	 resb 2048
	lenBufferReader equ $ - BufferReader ; 
	numero 	 resb 2000
	lenBufferPrimerByte equ $ - numero ; 

	Operacion  resb 1024; aqui va a ir guardada la expresion separada de las variables
	lenOperacion equ $ - Operacion;



section .text
	global _start
_start:
main:
	call read
	call atoi
	xor r14,r14
	mov r14,r15
	xor r13,13
	mov r13,r10

	call read
	call atoi

	
	;cmp r15,14
	;ja .listo
	

	;inc r15

	;.listo:
	;mov r15,r14
	;inc r15
	add r10,r13
	;xor rax,rax
	mov rax,r10
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

	mov rax,r10

	xor r12,r12
	mov r12,10
	;xor rcx,rcx;sostener el digito
	xor r11,r11
	mov r11,-1;indice
	xor r8,r8
	mov r8,-1
	.digito:

		div r12
		;xor rcx,rcx
		;mov rcx,rdx
		add rdx,'0'
		push rdx
		.prox:
			xor rdx,rdx
			;xor rcx,rcx
			inc r11
			cmp rax,0
	jne .digito
	.imp:
		.l:
		inc r8
		pop rdx
		mov [numero+r8],dl
		cmp r8,r11
		jne .l

		inc r11
		mov rsi,numero
		mov rdx,r11
		call imprimir

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
