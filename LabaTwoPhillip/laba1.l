%option noyywrap 
%{ 
#include <stdio.h> 
#include "y.tab.h" 
extern void yyerror(const char*); 
%} 

%% 
"\n" {return T_NEWLINE;} 
"m" {return 'm';} 
"n" {return 'n';} 
"k" {return 'k';} 
"+" {return '+';} 
"*" {return '*';} 
"(" {return '(';} 
")" {return ')';} 

. {yyerror("\nUnknown character\n");} 
%%