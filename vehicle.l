%{
#include "y.tab.h"
#include <stdlib.h>
%}

NUM [0-9]+

%%
engine         { return ENGINE; }
doors          { return DOORS; }
lights         { return LIGHTS; }
speed          { return SPEED; }
start          { return START; }
stop           { return STOP; }
lock           { return LOCK; }
unlock         { return UNLOCK; }
on             { return ON; }
off            { return OFF; }
set            { return SET; }
exit           { return EXIT; }
{NUM}          { yylval.num = atoi(yytext); return NUMBER; }
[ \t\n]+       ;
.              { printf("Invalid token: %s\n", yytext); }
%%
