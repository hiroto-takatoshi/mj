%{
#include <iostream>
#include <cstdlib>
#include <string.h>
#include "my.h"
#include "y.tab.h"
void yyerror(const char *s);
using namespace std;
%}

        /* Basics */

alpha                             [A-Za-z]
digit                             [0-9]
alphanum                          ({alpha}|{digit})

%%
"if"                              {  return If; }
"else"                            {  return Else; }
"while"                           {  return While; }
"class"                           {  return Class; }
"extends"                         {  return Extends; }
"public"                          {  return Public; }
"static"                          {  return Static; }
"void"                            {  return Void; }
"boolean"                         {  return Boolean; }
"int"                             {  return Integer; }
"String"                          {  return String; }
"true"                            {  return True; }
"false"                           {  return False; }
"this"                            {  return This; }
"new"                             {  return New; }
"System.out.println"              {  return Println; }
"return"                          {  return Return; }
"length"                          {  return ArrayLength; }
"main"                            {  return Main; }

{alpha}({alphanum}|"_")*          {  yylval.id = strdup(yytext); return Id; }
{digit}+                          {  yylval.num = atof(yytext); return Number; }
    /*\"(.|"\n")*\"                     {  return Text; }*/

"&&"                              {  return And; }
"<"                               {  return '<'; }
"+"                               {  return '+'; }
"-"                               {  return '-'; }
"*"                               {  return '*'; }
"!"                               {  return '!'; }
"="                               {  return '='; }
"."                               {  return '.'; }

"("                               {  return '('; }
")"                               {  return ')'; }
"["                               {  return '['; }
"]"                               {  return ']'; }
"{"                               {  return '{'; }
"}"                               {  return '}'; }
","                               {  return ','; }
";"                               {  return ';'; }

"//".*"\n"                        { /* Comment */yylineno++; }
"/*"(.|"\n")*"*\\"                { /* Comment */yylineno++; }
[ \t\r]                           {  }
\n                                {  yylineno++; }
.                                 { yyerror("Unknown character"); }

%%
int yywrap()
{
    return 1;
}

void yyerror(const char *s) {
    /*fflush(stdout);*/
    /*printf("\n%*s\n%*s\n", column, "*", column, s);*/
    //fprintf(stderr, "lexical error on line %d: %s\n", yylineno, s);
    char sr[100];
    sprintf(sr,"error on line %d: %s\n", yylineno, s);
    throw logic_error(sr);
}

/*
int main(void) {
    yylex();
    return 0;
}
*/
