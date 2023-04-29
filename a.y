%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"Routine.h"
int yyparse();
int yylex();
int yyerror();
extern int line;
extern int col;
extern FILE* yyin ;
int typeidf;
liste table;
int n=0;
int posdeb=1;
%}

%union {
int integer;
float real;
char* string;
}   
                 
%token begin end program FOR WHILE DO endfor IF ELSE ENDIF pinst pdec integer real ';' '(' ')' ':' '-'
%token <string>idf
%token <integer>pint
%token <real>pfloat
%token <string>string
%left '|' 
%left '&'
%left '!'
%left '<' '>' '==' 
%left '+' '-'
%left '*' '/'

%type <real> exp exp2 valcst
%%

S: entete pdec declaration pinst begin body end {printf ("\n\nCorrect Syntax\n\n");YYACCEPT ;}
;

entete: program idf
;
declaration: decla declaration
           |decla
;
decla: declarationVar
|declarationCst
;
declarationVar: listeparam Type ';' {InsertType(table,typeidf,posdeb);posdeb=posdeb+n;n=0;}
declarationCst: string Type idf '=' valcst ';' {if(Insert(&table,$3,typeidf,1) == 2) {printf("Semantic Error : %s double declared . line : %d, column %d\n",$3,line,col);}
else if((GetType(table,$3)==0) && (GetType(table,$3)!=TypeVal($5))) {if((GetNature(table,$3))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$3,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$3,line,col);}
else {InsertVal(table,$3,$5);}
posdeb++;
}
listeparam: listeparam '|' idf {
if(Insert(&table,$3,typeidf,0) == 2) {printf("Semantic Error : %s double declared . line : %d, column %d\n",$3,line,col);}

n++;
} 
| idf {
if(Insert(&table,$1,typeidf,0) == 2) {printf("Semantic Error : %s double declared . line : %d, column %d\n",$1,line,col);}

n++;
}
;

Type: integer {typeidf=0; } | real {typeidf=1;}
;

body: body inst | inst 
;

inst : aff ';'
     | loop 
	 | condition 
;

aff: idf '<' '-' '-' exp{if (Search(table,$1)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);}
else if(GetCst(table,$1)==1) {printf("Semantic Error : modification of the Constant %s . line : %d, column %d\n",$1,line,col);}
else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($5))) {{if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);}}
else {InsertVal(table,$1,$5);}
}
;
affloop: idf '<' '-' '-' pint{if (Search(table,$1)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);}
else if(GetCst(table,$1)==1) {printf("Semantic Error : modification of the Constant %s . line : %d, column %d\n",$1,line,col);}
else {InsertVal(table,$1,$5);}
}
;

valcst: pint {$$=$1;}
| '-' pint {$$=-1*$2;}
| pfloat {$$=$1;}
| '-' pfloat {$$=-1*$2;}
;
exp : exp '+' exp2 {$$=$1+$3;}
| exp '-' exp2 {$$=$1+(-1*$3);}
| exp2 {$$=$1}
;
exp2 : exp2 '*' pint {$$=$1*$3;}
| exp2 '*' idf {if (Search(table,$3)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$3,line,col);}
else $$=$1*GetVal(table,$3)}
| exp2 '/' pint {if ($3==0) {printf("Semantic Error : Division by 0 . line : %d, column %d\n",line,col);}
else {$$=$1/$3;}}
| exp2 '*' pfloat {$$=$1*$3;}
| exp2 '/' pfloat {if ($3==0) {printf("Semantic Error : Division by 0 . line : %d, column %d\n",line,col);} 
else {$$=$1/$3;}}
| exp2 '/' idf {if (Search(table,$3)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$3,line,col);}
else if(GetVal(table,$3)==0) {printf("Semantic Error : Division by 0 . line : %d, column %d\n",line,col);} 
else {$$=$1/GetVal(table,$3);}}
| pint{$$=$1;}
| pfloat{$$=$1;}
| idf {if (Search(table,$1)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);}
else {$$=GetVal(table,$1);}}
| '-' pint{$$=-1*$2;}
| '-' pfloat{$$=-1*$2;}
| '-' idf {if (Search(table,$2)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$2,line,col);}
else {$$=-1*GetVal(table,$2);}}
| '(' '-' pint ')' {$$=-1*$3;}
| '(' '-' pfloat '(' {$$=-1*$3;}
| '(' '-' idf '('{if (Search(table,$3)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$3,line,col);}
else {$$=-1*GetVal(table,$3);}}
;
exp_comp : idf '=' '=' exp {if (Search(table,$1)==0) {printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);}
else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($4))) {if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);}}
| idf '!' '=' exp {if (Search(table,$1)==0) printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($4))) {if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);}}
| idf '>' '=' exp {if (Search(table,$1)==0) printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($4))) {if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);}}
| idf '>' exp {if (Search(table,$1)==0) printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($3))) {if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col); }}
| idf '<' '=' exp {if (Search(table,$1)==0) printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($4))) {if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);}}
| idf '<' exp {if (Search(table,$1)==0) printf("Semantic Error : Variable or Constant %s not declared . line : %d, column %d\n",$1,line,col);else if ((GetType(table,$1)==0) && (GetType(table,$1)!=TypeVal($3))) {if((GetNature(table,$1))==0) printf("Semantic Error : Type Incompatibility, The variable %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);
	else printf("Semantic Error : Type Incompatibility, The constant %s is an Integer while The value is a Float. line : %d, column %d\n",$1,line,col);}}
;
exp_log : exp_log exp_logi | '(' exp_comp ')' | exp_comp 
;
exp_logi : '&' '(' exp_comp ')'
         | '|' '(' exp_comp ')'
		 | '&' exp_comp 
		 | '|' exp_comp 
;
loop : FOR affloop WHILE pint DO body endfor 
;
condition : DO body ':' IF '(' exp_log ')' ELSE body ENDIF
;		
%%
int yyerror(char* msg)
{printf("\n\n%s line %d et column %d\n\n",msg,line,col);
return 0;
}
int main()  {  
yyin=fopen("Programme.txt","r");
yyparse();  
DisplayTable(table);
return 0;  
} 