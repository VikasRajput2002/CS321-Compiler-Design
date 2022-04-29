%{
	#include<stdio.h>
%}

/* rules  */

%%
[ \t]+ 	/* for  WhiteSpace no action */
\n	  { printf("Token and Lexeme: <newline>\n"); }
[()#]	{ printf("Token and Lexeme: %s\n", yytext); }
[^ \t\n()#]+ { if(strcmp(yytext, "Reverse") == 0)
				printf("Token: REVERSE; Lexeme: %s\n", yytext);
				else {
						int error = 0;
						for(int i=0; i<yyleng; i++) {
						if('a' > yytext[i] || yytext[i] > 'z') {
							printf("Error: unspecified string detected %s\n", yytext);
							error = 1;
							break;
					  	  }
					    }
					    if(!error) printf("Token: STRING; Lexeme: %s\n", yytext);
				  	  }
				    }

%%

int yywrap() { return 0;}

int main() {
	printf("Enter input \n");
	yylex();
	return 0;
}
