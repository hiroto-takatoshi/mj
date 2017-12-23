mj: y.tab.c lex.yy.c 
	cc y.tab.c lex.yy.c -o mj

y.tab.c: mj.y
	yacc -d mj.y

lex.yy.c: mj.l
	lex mj.l

clean:
	/bin/rm -f lex.yy.* y.tab.* mj
