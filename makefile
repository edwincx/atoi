
funcion: funcion.o
	ld -o funcion funcion.o

funcion.o: funcion.asm
	yasm -f elf64 funcion.asm
