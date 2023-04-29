%{
#include<stdio.h>
#include<string.h>
#include "a.tab.h"
int line=1;
int col=0;
extern YYSTYPE yylval;
%}
%option noyywrap
string "@define"              
lettre [a-zA-Z]
lettreminiscule [a-z]
Integer 0|[1-9][0-9]*
int {Integer}
float {Integer}"."{Integer}
IDF {lettreminiscule}({lettreminiscule}|[0-9]|_)*
%%
Program {return program;col=col+yyleng;}
Begin {return begin;col=col+yyleng;}
End {return end;col=col+yyleng;}
FOR {return FOR;col=col+yyleng;}
DO {return DO;col=col+yyleng;}
WHILE {return WHILE;col=col+yyleng;}
ENDFOR {return endfor;col=col+yyleng;}
IF {return IF;col=col+yyleng;}
ELSE {return ELSE;col=col+yyleng;}
ENDIF {return ENDIF;col=col+yyleng;}
PDEC {return pdec;col=col+yyleng;}
PINST {return pinst;col=col+yyleng;}
Pint {return integer;col=col+yyleng;}
Pfloat {return real;col=col+yyleng;}
"|" {return '|';col=col+yyleng;}
"-" {return '-';col=col+yyleng;}
[={}();"><!:&+*/] {return yytext[0];col=col+yyleng;}
[ \t] {col=col+yyleng;}
\n {line++;col=col+yyleng;}
{int} {yylval.integer=atoi(yytext);
         if(yylval.integer>-32768 && yylval.integer<32767) {return pint;col=col+yyleng;}
		 else printf("Lexical Error line %d et column %d: not valid Number\n",line,col);
		 }
{float} {yylval.real=atof(yytext);
          
         return pfloat;col=col+yyleng;}
{IDF}  {if (yyleng<=12) {
if(strcmp(&yytext[yyleng-1],"_")==0) printf("\n\nLexical Error line %d et colonne %d: IDF ending with '_'\n\n",line,col);
else {yylval.string=strdup(yytext);
                                           return idf;col=col+yyleng;}
										   }
    else printf("\n\nLexical Error line %d et column %d: IDF Too long\n\n",line,col);

        }
{string}  {yylval.string=strdup(yytext);
                                          
                              return string;col=col+yyleng;}							  
. {printf ("\n\nLexical Error line %d et column %d\n\n",line,col);exit(0);}
%%