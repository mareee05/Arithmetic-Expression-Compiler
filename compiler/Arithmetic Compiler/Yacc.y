%{
	#include <stdio.h>
        #include <stdlib.h>
	#include <string.h>
    	int yylex (void);
    	void yyerror (char const *s);
%}

%union{
	char *str;
}

%token <str>Zero
%token <str>One
%token <str>Two
%token <str>Three
%token <str>Four
%token <str>Five
%token <str>Six
%token <str>Seven
%token <str>Eight
%token <str>Nine
%token <str>Mul
%token <str>Plus
%token <str>Min
%token <str>Div
%token <str>Lpar
%token <str>Rpar


%type <str>program
%type <str>stmts
%type <str>expr
%type <str>term
%type <str>factor
%type <str>digits
%type <str>thousand
%type <str>hundred
%type <str>ten
%type <str>digit

%%
program : stmts 			{ printf("print %s", $1);};

stmts : expr 				{char n[200]; sprintf($$, "t%s", NumCode(n , $1));};

expr : expr Plus term 			{char n[200]; sprintf($$, "t%s", ExpCode(n , $1 , $2 , $3));} 
	| expr Min term 		{char n[200]; sprintf($$, "t%s", ExpCode(n , $1 , $2 , $3));} 
	| term		       	        {sprintf($$, "%s", $1);}
	;

term : term Mul factor 			{char n[200]; sprintf($$, "t%s", ExpCode(n , $1 , $2 , $3));} 
	| term Div factor 		{char n[200]; sprintf($$, "t%s", ExpCode(n , $1 , $2 , $3));} 
	| factor 			{sprintf($$, "%s", $1);}
	;

factor : digits 			{sprintf($$ , "%s" , $1);} 
	| Lpar expr Rpar 		{sprintf($$ , "%s" , $2);}
	;

digits : thousand			{sprintf($$ , "%s" , $1);} 
	|hundred 			{sprintf($$ , "%s" , $1);} 
	|ten 				{sprintf($$ , "%s" , $1);} 
	|digit 				{sprintf($$ , "%s" , $1);}
	;

thousand : digit hundred 		{char string[200]; string[0] = '('; strcat(string , $$); strcpy($$ , string); strcat($$ , ")Tou_"); strcat($$ , $2);} 
	| digit digit hundred 		{char string[200]; string[0] = '('; strcat(string , $$); strcpy($$ , string); strcat($$ , "Ten_"); strcat($$ , $2);  strcat($$ , ")Tou_"); strcat($$ , $3);} 
	| digit digit digit hundred 	{char string[200]; string[0] = '('; strcat(string , $$); strcpy($$ , string); strcat($$ , "Hun_"); strcat($$ , $2); strcat($$ , "Ten_"); strcat($$ , $3); strcat($$ ,")Tou_"); strcat($$ , $4);}
	;

hundred : digit ten {sprintf($$, "%sHun_%s", $1, $2);};

ten :	digit digit {sprintf($$, "%sTen_%s", $1, $2);};

digit :	Zero 				{sprintf($$ , "%s" , $1);} 
	|One				{sprintf($$ , "%s" , $1);}
	|Two 				{sprintf($$ , "%s" , $1);}
	|Three 				{sprintf($$ , "%s" , $1);}
	|Four 				{sprintf($$ , "%s" , $1);}
	|Five 				{sprintf($$ , "%s" , $1);}
	|Six 				{sprintf($$ , "%s" , $1);}
	|Seven 				{sprintf($$ , "%s" , $1);}
	|Eight 				{sprintf($$ , "%s" , $1);}
	|Nine 				{sprintf($$ , "%s" , $1);} 
	;

%%

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}
extern FILE *yyin;

int main(int argc,char **argv)
{
    ++argv, --argc;  
    yyin = fopen( argv[0], "r" );
    yyparse();
    return 0 ;
}
