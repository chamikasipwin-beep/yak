%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
%}

%union {
    char* str;
    int num;
}

%token ENGINE DOORS LIGHTS SPEED START STOP LOCK UNLOCK ON OFF SET EXIT
%token <num> NUMBER
%type <str> component action

%%

commands:
    /* empty */
  | commands instruction
  ;

instruction:
    SPEED SET NUMBER           { printf("Command: Speed Set %d\n", $3); }
  | component action            { printf("Command: %s %s\n", $1, $2); free($1); free($2); }
  | EXIT                       { printf("Exiting program...\n"); exit(0); }
  ;

component:
    ENGINE { $$ = strdup("Engine"); }
  | DOORS  { $$ = strdup("Doors"); }
  | LIGHTS { $$ = strdup("Lights"); }
  | SPEED  { $$ = strdup("Speed"); }
  ;

action:
    START  { $$ = strdup("Start"); }
  | STOP   { $$ = strdup("Stop"); }
  | LOCK   { $$ = strdup("Lock"); }
  | UNLOCK { $$ = strdup("Unlock"); }
  | ON     { $$ = strdup("On"); }
  | OFF    { $$ = strdup("Off"); }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Input: ");
    yyparse();
    return 0;
}
