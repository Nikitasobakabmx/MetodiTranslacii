%option noyywrap 
%{ 
#include <stdio.h> 
#include "y.tab.h" 
extern void yyerror(const char* s);
%} 

%% 
"\n" {return T_NEWLINE;} 
"2" {return '2' ;} 
"3" {return '3' ;} 
"4" {return '4' ;} 
"+" {return '+' ;} 
"*" {return '*' ;} 
. {yyerror("\nUnknown character\n");} 
%%
