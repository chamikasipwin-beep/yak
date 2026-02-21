%{
#include "y.tab.h"
#include <stdlib.h>
%}

NUM [0-9]+

%%
{NUM}      { yylval.num = atoi(yytext); return NUMBER; }
[ \t\r]+  ;
"\n"      { return '\n'; }
"%"       { return MOD; }
"+"       { return '+'; }
"-"       { return '-'; }
"*"       { return '*'; }
"/"       { return '/'; }
"("       { return '('; }
")"       { return ')'; }
.          { printf("Invalid token: %s\n", yytext); return yytext[0]; }
%%
