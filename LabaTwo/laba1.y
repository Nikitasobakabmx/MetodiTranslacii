%{ 
#include "stdlib.h" 
#include "stdio.h" 
extern int yylex(); 
extern int yyparse(); 
extern FILE* yyin; 
void yyerror(const char* s); 
%} 
%token T_NEWLINE 
%start calculation
%%
calculation :| calculation line;
line : S T_NEWLINE {printf("Success\n");};
S: E {printf("%d\n", $1);};
E: E E '+' {$$ = $1 + $2;}
| E E '*' {$$ = $1 * $2;}
|'2' {$$ = 2;}
|'3' {$$ = 3;}
|'4' {$$ = 4;}; 
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