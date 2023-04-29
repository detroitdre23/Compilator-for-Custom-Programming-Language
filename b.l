%{
#include<stdio.h>
#include<string.h>
#include "b.tab.h"
int line=1;
int col=0;
extern YYSTYPE yylval;
%}
%option noyywrap
lettre[a-zA-Z]
integer 0|[1-9][0-9]*
IDF [a-zA-Z]([a-zA-Z]|[0-9])*
%%
int {return integer;col=col+yyleng;}
string {return String;col=col+yyleng;}
fonction {return Function;col=col+yyleng;}
for {return FOR;col=col+yyleng;}
if {return IF;col=col+yyleng;}
else {return ELSE;col=col+yyleng;}
scanf {return SCANF;col=col+yyleng;}
printf {return PRINTF;col=col+yyleng;}
Return {return RETURN;col=col+yyleng;}
"-" {return '-';col=col+yyleng;}
[={}();"><!:+*/,] {return yytext[0];col=col+yyleng;}
[ \t] {col=col+yyleng;}
\n {line++;col=col+yyleng;}
{integer} {yylval.integer=atoi(yytext);
if(yylval.integer>=0 && yylval.integer<=1622) {return entier;col=col+yyleng;}
else printf("Lexical Error line %d et column %d: not valid Number\n",line,col);
}
{IDF} { 
if(yyleng<=8) {yylval.string=strdup(yytext);return idf;col=col+yyleng;}
else printf("\n\nLexical Error line %d et column %d: IDF Too long\n\n",line,col);}
%%