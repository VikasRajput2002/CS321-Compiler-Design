%{
	#include <stdio.h>
	#include <string.h>

	int yylex(void);
	void yyerror(char*);
%}
%union {
	char s[100];
}
%token<s> STRING
%token<s> REVERSE
%type<s> expr

%%
start 	:	start expr '\n'				{ printf("%s\n", $2); }
		|
		;

expr	:	STRING
		| 	expr '#' expr				{ strcat($1, $3);  strcpy($$, $1); }

		| 	REVERSE '(' STRING ')'		{	int n=strlen($3);
											for(int i=0; i<strlen($3); i++)
									  			$$[i] = $3[n-(i+1)];

									    	$$[n] = '\0';
								 		}
								 	
		;

%%
void yyerror(char* s) {
	printf("%s\n", s);
}

int main() {
	yyparse();
	return 0;
}
