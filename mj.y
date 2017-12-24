%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include <iostream>
#include <string>
#include <list>

#include "my.h"

using namespace std;

extern char yytext[];
extern int column;
extern int yylineno;
int cnt;

int yylex(void);
void yyerror(char *s);
%}

%token If Else While Class Extends Public Static Void
%token Boolean Integer String True False
%token This New Println Return ArrayLength Main
%token And

%right '='
%left '{'
%left '['
%left And
%left '+' '-'
%left '*'
%left '.'
%left '!'
%nonassoc '<'

%start Goal

%union {
    node *nd;
    nodes *ndl;
    char *id;
    float num;
}
%type <nd> MainClass Goal ClassDeclaration VarDeclaration MethodDeclaration Expression Type Statement Identifier
%type <ndl> ClassDeclarationList VarDeclarationList MethodDeclarationList StatementList ExpressionList ParameterList
%token <num> Number
%token <id> Id

%%
Goal
    :   MainClass ClassDeclarationList      { $$ = new node(++cnt, "Goal"); add_nn($$, $1); add_nl($$, $2); }
    ;

MainClass
    :   Class Identifier '{' Public Static Void Main '(' String '[' ']' Identifier ')' '{' Statement '}' '}'    { $$ = new node(++cnt, "MainClass"); add_nt($$, "Class"); add_nn($$, $2); add_nt($$, "{"); add_nt($$, "Public"); add_nt($$, "Static"); add_nt($$, "Void"); add_nt($$, "Main"); add_nt($$, "("); add_nt($$, "String"); add_nt($$, "["); add_nt($$, "]"); add_nn($$, $12); add_nt($$, ")"); add_nt($$, "{"); add_nn($$, $15); add_nt($$, "}"); add_nt($$, "}"); }
    ;

ClassDeclarationList
    :   ClassDeclaration ClassDeclarationList { $$ = $2; $2->push_front($1); }
    |   { $$ = new nodes(); } /* Empty */
    ;

ClassDeclaration
    :   Class Identifier '{' VarDeclarationList MethodDeclarationList '}'    { $$ = new node(++cnt, "ClassDeclaration"); add_nt($$, "Class"); add_nn($$, $2); add_nt($$, "{"); add_nl($$, $4); add_nl($$, $5); add_nt($$, "}"); }
    |   Class Identifier '{' MethodDeclarationList '}'    {$$ = new node(++cnt, "ClassDeclaration"); add_nt($$, "Class"); add_nn($$, $2); add_nt($$, "{"); add_nl($$, $4); add_nt($$, "}"); }
    |   Class Identifier Extends Identifier '{' VarDeclarationList MethodDeclarationList '}'    {$$ = new node(++cnt, "ClassDeclaration"); add_nt($$, "Class"); add_nn($$, $2); add_nt($$, "Extends"); add_nn($$, $4); add_nt($$, "{"); add_nl($$, $6); add_nl($$, $7); add_nt($$, "}"); }
    |   Class Identifier Extends Identifier '{' MethodDeclarationList '}'    {$$ = new node(++cnt, "ClassDeclaration"); add_nt($$, "Class"); add_nn($$, $2); add_nt($$, "Extends"); add_nn($$, $4); add_nt($$, "{"); add_nl($$, $6); add_nt($$, "}"); }
    ;

VarDeclarationList
    :   VarDeclaration {$$ = new nodes(); $$ -> push_back($1); }
    |   VarDeclaration VarDeclarationList  {$$ = $2; $2->push_front($1);}
    ;

VarDeclaration
    :   Type Identifier ';' {$$ = new node(++cnt, "VarDeclaration"); add_nn($$, $1); add_nn($$, $2); add_nt($$, ";");  }
    ;

MethodDeclarationList
    :   MethodDeclaration MethodDeclarationList {$$ = $2; $2->push_front($1);}
    |   {$$ = new nodes();} /* Empty */
    ;

MethodDeclaration
    :   Public Type Identifier '(' ParameterList ')' '{' VarDeclarationList StatementList Return Expression ';' '}'    {$$ = new node(++cnt, "MethodDeclaration"); add_nt($$, "Public"); add_nn($$, $2); add_nn($$, $3); add_nt($$, "("); add_nl($$, $5); add_nt($$, ")"); add_nt($$, "{"); add_nl($$, $8); add_nl($$, $9); add_nt($$, "Return"); add_nn($$, $11); add_nt($$, ";"); add_nt($$, "}"); }    
    |   Public Type Identifier '(' ParameterList ')' '{' StatementList Return Expression ';' '}'    {$$ = new node(++cnt, "MethodDeclaration");}    
    ;

ParameterList
    :   Type Identifier    {$$ = new nodes();$$->push_back($1); $$->push_back($2);}
    |   Type Identifier ',' ParameterList    {$$ = $4; $4->push_front($2); $4->push_front($1);} /* Missing the comma sign here */
    |       {$$ = new nodes();} /* Empty */
    ;

Type
    :   Integer '[' ']'    {$$ = new node(++cnt, "Type"); add_nt($$, "Integer"); add_nt($$, "["); add_nt($$, "]"); }
    |   Boolean    {$$ = new node(++cnt, "Type"); add_nt($$, "Boolean"); }
    |   Integer    {$$ = new node(++cnt, "Type"); add_nt($$, "Integer"); }
    |   Identifier    {$$ = new node(++cnt, "Type"); add_nn($$, $1); }
    ;

StatementList
    :   Statement StatementList    { $$ = $2; $2->push_front($1); }
    |       {$$ = new nodes();}    /* Empty */
    ;

Statement
    :   '{' StatementList '}'    {$$ = new node(++cnt, "Statement"); add_nt($$, "{"); add_nl($$, $2); add_nt($$, "}"); }
    |   If '(' Expression ')' Statement Else Statement    {$$ = new node(++cnt, "Statement"); add_nt($$, "If"); add_nt($$, "(");  add_nn($$, $3); add_nt($$, ")"); add_nn($$, $5); add_nt($$, "Else");  add_nn($$, $7); }
    |   While '(' Expression ')' Statement    {$$ = new node(++cnt, "Statement"); add_nt($$, "While"); add_nt($$, "("); add_nn($$, $3); add_nt($$, ")"); add_nn($$, $5); }
    |   Println '(' Expression ')' ';'    {$$ = new node(++cnt, "Statement"); add_nt($$, "Println"); add_nt($$, "("); add_nn($$, $3); add_nt($$, ")"); add_nt($$, ";"); }
    |   Identifier '=' Expression ';'    {$$ = new node(++cnt, "Statement"); add_nn($$, $1); add_nt($$, "="); add_nn($$, $3); add_nt($$, ";"); }
    |   Identifier '[' Expression ']' '=' Expression ';'    {$$ = new node(++cnt, "Statement"); add_nn($$, $1); add_nt($$, "["); add_nn($$, $3); add_nt($$, "]"); add_nt($$, "="); add_nn($$, $6); add_nt($$, ";"); }
    ;

ExpressionList
    :   Expression    {$$ = new nodes(); $$ -> push_back($1); }
    |   Expression ',' ExpressionList    {$$ = $3; $3 -> push_front($1); }
    |       {$$ = new nodes();}/* Empty */
    ;

Expression
    :   Expression And Expression    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "And"); add_nn($$, $3);}
    |   Expression '<' Expression    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "<"); add_nn($$, $3);}
    |   Expression '+' Expression    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "+"); add_nn($$, $3);}
    |   Expression '-' Expression    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "-"); add_nn($$, $3); }
    |   Expression '*' Expression    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "*"); add_nn($$, $3);  }
    |   Expression '[' Expression ']'    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "["); add_nn($$, $3); add_nt($$, "]"); }
    |   Expression '.' ArrayLength    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "."); add_nt($$, "ArrayLength"); }
    |   Expression '.' Identifier '(' ExpressionList ')'    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); add_nt($$, "."); add_nn($$, $3); add_nt($$, "("); add_nl($$, $5); add_nt($$, ")"); }
    |   Number    {$$ = new node(++cnt, "Expression"); char tmpstr[20]; sprintf(tmpstr, "%g", $1); add_nt($$, string(tmpstr)); }
    |   True    {$$ = new node(++cnt, "Expression");  add_nt($$, "True"); }
    |   False    {$$ = new node(++cnt, "Expression"); add_nt($$, "False"); }
    |   Identifier    {$$ = new node(++cnt, "Expression"); add_nn($$, $1); }
    |   This    {$$ = new node(++cnt, "Expression"); add_nt($$, "This"); }
    |   New Integer '[' Expression ']'    {$$ = new node(++cnt, "Expression"); add_nt($$, "New"); add_nt($$, "Integer"); add_nt($$, "["); add_nn($$, $4); add_nt($$, "]");  }
    |   New Identifier '(' ')'    {$$ = new node(++cnt, "Expression"); add_nt($$, "New"); add_nn($$, $2); add_nt($$, "("); add_nt($$, ")"); }
    |   '!' Expression    {$$ = new node(++cnt, "Expression"); add_nt($$, "!"); add_nn($$, $2); }
    |   '(' Expression ')'    {$$ = new node(++cnt, "Expression"); add_nt($$, "("); add_nn($$, $2); add_nt($$, ")"); }
    ;

Identifier
    :   Id    {$$ = new node(++cnt, "Identifier"); add_nt($$, string($1)); }
    ;

%%
void yyerror(char *s) {
    /*fflush(stdout);*/
    /*printf("\n%*s\n%*s\n", column, "*", column, s);*/
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}

int main(void) {
    yyparse();
    return 0;
}
