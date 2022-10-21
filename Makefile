# Build the lexyacc-code_lab3 folder,
# .exe files are output to ./bin

DIR_lex += ./lexyacc-code_lab3
DIR_bin += ./bin

all: compile build

compile:
	bison -y -d $(DIR_lex)/calc3.y -o $(DIR_lex)/y.tab.c
	flex --outfile="$(DIR_lex)/lex.yy.c" $(DIR_lex)/calc3.l
	gcc -c $(DIR_lex)/y.tab.c -o $(DIR_lex)/y.tab.o 
	gcc -c $(DIR_lex)/lex.yy.c -o $(DIR_lex)/lex.yy.o

build:
	gcc $(DIR_lex)/y.tab.o $(DIR_lex)/lex.yy.o $(DIR_lex)/calc3a.c -o $(DIR_bin)/calc3a.exe
	gcc $(DIR_lex)/y.tab.o lex.yy.o $(DIR_lex)/calc3b.c -o $(DIR_bin)/calc3b.exe
	gcc $(DIR_lex)/y.tab.o $(DIR_lex)/lex.yy.o $(DIR_lex)/calc3g.c -o $(DIR_bin)/calc3g.exe

clean:
	rm $(DIR_bin)/calc3*
