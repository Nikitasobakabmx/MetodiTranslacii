%{ 

#include "stdlib.h" 
#include "stdio.h" 
extern int yylex(); 
extern int yyparse(); 
extern FILE* yyin; 
void yyerror(const char* s); 
%} 
%token T_NEWLINE 
%start accept 
%% 
accept: S {printf("Success\n");} ; 
S: E;
E: E E '+' | E E "*" ;
E: '2' | '3' | '4' ; 
%% 
void yyerror(const char* s)
{ 
    fprintf(stderr,"\nParsing error: %s \n",s); 
} 
int main()
{ 
    yyparse(); 
    return 0; 
}