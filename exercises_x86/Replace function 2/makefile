CC=g++
ASMBIN=nasm

all : asm cc link
asm :
	$(ASMBIN) -o 7f.o -f elf -g -l 7f.lst 7f.asm
cc :
	$(CC) -m32 -c -g -O0 main.cpp &> errors.txt
link :
	$(CC) -m32 -g -o test main.o 7f.o
clean :
	rm *.o
	rm test
	rm errors.txt
	rm 7f.lst
