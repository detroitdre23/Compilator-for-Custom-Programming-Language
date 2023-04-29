%{
#include<stdio.h>
#include<string.h>
int yyparse();
int yylex();
int yyerror();
extern int line;
extern int col;
extern FILE* yyin ;
%}
%union{
int integer;
char* string;
char* chaine;
}
%token integer String Function FOR IF ELSE SCANF PRINTF RETURN '{' '}' '(' ')' ';' '"' ','
%token <integer> entier;
%token <string> idf;
%token <chaine> chaine;
%left '<' '>' '==' 
%left '/' '*'
%left '+' '-'

%%
S: idf {printf("Programme Correct\n");YYACCEPT;}
%%
int yyerror(char* msg)
{printf("\n\n%s line %d et column %d\n\n",msg,line,col);
return 0;
}
int main()  {  
yyin=fopen("Programme1.txt","r");
yyparse();  
return 0;  
} 

