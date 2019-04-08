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
%token T_NEWLINE
%start accept 
%% 
accept: S {printf("Success\n");} 
; 
S: E {printf("%s\n", $$);};
E: E '+' T
|
T
;
T: T '*' F  {
                if(operandOne == nullptr)
                {
                    operandOne = new char($1);
                }
                if(operandTwo == nullptr)
                {
                    operandTwo = new char($3);
                }
                $$ = T '*' $3;
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