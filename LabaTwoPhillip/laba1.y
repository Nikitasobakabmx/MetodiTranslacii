%{
#include "stdlib.h" 
#include "stdio.h" 
#include <string.h>
extern int yylex(); 
extern int yyparse(); 
extern FILE* yyin; 
void yyerror(const char* s); 
//std::string *result = nullptr; 
char *operandOne = nullptr;
char *operandTwo = nullptr;
%} 
%union
{
    struct
    {
        std::string* line = nullptr;
        int precedence = 0;
    }expression_type;
}
%type <expression_type> S E T F
%token T_NEWLINE
%start accept 
%left '+'
%left '*'
%% 
accept: S {printf("Success\n");} 
; 
S: E {printf("%s\n", *($$.line));};
E: E '+' T
|
T
;
T: T '*' F  {

            }
|
F {$$ = $1;}
; 
F: 'k' {$$ = $1;}
|
'n' {$$ = $1;}
|
'm' {$$ = $1;}
|
'(' E ')' {} 
;

%% 
void yyerror(const char* p) { 
fprintf(stderr,"\nParsing error: %s \n",p); 
} 
int main(){ 
yyparse(); 
system("pause"); 
return 0; 
}