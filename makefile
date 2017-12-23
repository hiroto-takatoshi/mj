mj: 
	/bin/rm -f lex.yy.* y.tab.* mj *.o *.o
	bison -d -t -y mj.y
	g++ -O2 y.tab.c -c -Wno-write-strings
	flex -8 mj.l
	g++ -O2 lex.yy.c -c -Wno-write-strings
	g++ -c my.cpp
	g++ y.tab.c lex.yy.c my.o -o mj -lfl -ly -Wno-write-strings

clean:
	/bin/rm -f lex.yy.* y.tab.* mj *.o *.gch
