%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *);
%}


%%
/* rules section*/
[a-z]+  {yylval.id = strdup(yytext);
        return ID;}
[0-9]+  {yylval.num = atoi(yytext);
        return NUM;}
[-+*/)(]   {return *yytext;}
\n      {return *yytext;}
[ \t]   {       }
.       {printf("Invalid character.\n");
        yyerror("invalid character");}


%%
    /*** C Code section ***/

void yyerror(char *s) {
      fprintf(stderr, "line %d: yytext = %s.  Error msg: %s.\n", yylineno, yytext, s);
}


int yywrap(void) {
   return 1;
}