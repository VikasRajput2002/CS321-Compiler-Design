%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
int yylex(void);
void yyerror(char *);
int check(char * , char *);
%}

%union{
char *id;
int num;
struct expr{
        int val;
        char *type;
        }expr;
};

%token <id> ID
%token <num> NUM
%type <id> chain
%type <id> exp
%type <id> txp
%type <id> fxp

%start chain

%%

chain   :chain exp '\n' {printf("\nvalue = %s\n",$2);}
        |
        ; 


exp     :exp '+' txp          {if(check($1, $3))
                                {printf("+ ");$$="int";}
                               else {printf("\ntype mismatch string found\n");
                                exit(0);}}
        |exp '-' txp          {if(check($1, $3))
                                {printf("- ");$$="int";}
                               else {printf("\ntype mismatch string found\n");
                                exit(0);}}
        |txp                  {$$ = "int";}
        ;

txp     :txp '*' fxp          {if(check($1, $3))
                                {printf("* ");$$="int";}
                               else {printf("\ntype mismatch string found\n");
                                exit(0);}}
        |txp '/' fxp          {if(check($1, $3))
                                {printf("/ ");$$="int";}
                               else {printf("\ntype mismatch string found\n");
                                exit(0);}}
        |fxp                  {if(check($1, "int"))
                                {$$="int";}
                               else {printf("\ntype mismatch string found\n");
                                exit(0);}}
        ;
fxp     :'(' exp ')'          {$$ = "int";}
        |NUM                  {printf("int ");$$ = "int";}
        |ID                   {printf("string ");$$ = "string";}
        ;

%%

int check(char *a, char *b){
        if(strcmp(a,b)==0 && strcmp(a,"int")==0)
        return 1;
        else return 0;
}

int main(void) {
    yyparse();
    return 0;
}