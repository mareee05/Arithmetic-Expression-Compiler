%option noyywrap
%{
	#include <stdio.h>
	#include <string.h>
	#include "y.tab.h"
	int i = 1;
%}

delim	[ \t\n]
ws	{delim}+

%%

{ws}	{}
"0"	{yylval.str=strdup("Zer"); return Zero;}
"1"	{yylval.str=strdup("One"); return One;}
"2"	{yylval.str=strdup("Two"); return Two;}
"3"	{yylval.str=strdup("Thr"); return Three;}
"4"	{yylval.str=strdup("Fou"); return Four;}
"5"	{yylval.str=strdup("Fiv"); return Five;}
"6"	{yylval.str=strdup("Six"); return Six;}
"7"	{yylval.str=strdup("Sev"); return Seven;}
"8"	{yylval.str=strdup("Eig"); return Eight;}
"9"	{yylval.str=strdup("Nin"); return Nine;}
"*"	{yylval.str=strdup("Mul"); return Mul;}
"+"	{yylval.str=strdup("Plu"); return Plus;}
"-"	{yylval.str=strdup("Min"); return Min;}
"/"	{yylval.str=strdup("Div"); return Div;}
"(" 	{yylval.str=strdup(""); return Lpar;}
")" 	{yylval.str=strdup(""); return Rpar;}

%%

char *ExpCode(char n[] , char *num1 , char *operator , char *num2)
{
	sprintf(n , "%d" , i);
  	i++;
  	printf("Assign %s %s %s to t%s\n" , num1 , operator , num2 , n);
  	return n;
}

char *NumCode(char n[], char *num)
{
  	if(i==1){	
  		sprintf(n , "%d" , i);	
 	 	printf("Assign %s to t%s\n", num , n);
 	 	return n;
	}
 	else{
		i--;
		sprintf(n , "%d", i);
		return n;
	}
}


