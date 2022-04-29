%{
	#include "y.tab.h"
	#include<string.h>
%}

%%
[ \t]+
[\n()#]						{ return *yytext; }
[^ \t\n()#]+				{ strcpy(yylval.s, yytext);
							  if(strcmp(yytext, "Reverse") == 0)
								  return REVERSE;
							  for(int i=0; yytext[i]!='\0'; i++) {
								  if(yytext[i] < 'a' || 'z' < yytext[i]) {
									  return 0;
								  }
							  }
							  return STRING;
							}

%%
int yywrap(void) {
	return 1;
}
