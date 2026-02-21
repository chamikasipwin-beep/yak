%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
%}

%union { int num; }

%token <num> NUMBER
%token MOD
%left '+' '-'
%left '*' '/' MOD
%left UMINUS
%type <num> expr

%%

input:
    /* empty */
  | input line
  ;

line:
    '\n'
  | expr '\n'  { printf("Result = %d\n", $1); }
  ;

expr:
    NUMBER                { $$ = $1; }
  | expr '+' expr         { $$ = $1 + $3; }
  | expr '-' expr         { $$ = $1 - $3; }
  | expr '*' expr         { $$ = $1 * $3; }
  | expr '/' expr         {
                            if ($3 == 0) { fprintf(stderr, "Error: division by zero\n"); $$ = 0; }
                            else $$ = $1 / $3;
                          }
  | expr MOD expr         {
                            if ($3 == 0) { fprintf(stderr, "Error: division by zero\n"); $$ = 0; }
                            else $$ = $1 % $3;
                          }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'          { $$ = $2; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

int main(void) {
    printf("Enter expressions, one per line. Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}
