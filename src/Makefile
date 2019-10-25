
all: compilar

compilar: analex.c anasin.tab.c
	gcc -o compilar anasin.tab.c analex.c

analex.c: analex.l anasin.tab.h
	flex -o analex.c analex.l

anasin.tab.c: anasin.tab.h
anasin.tab.h: anasin.y
	bison -d anasin.y
