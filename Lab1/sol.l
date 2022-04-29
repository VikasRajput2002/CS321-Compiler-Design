/* definitions */

%{
#include<stdio.h>
#include<string.h>
int  lines=0,brac= 0,words,c_letters=0,num=0,spl_chr=0,blank_space=0,total=0,a=0,b=0,c=0,total_comment=0,keyward=0;
%}


/* rules */

TYPE int|char|bool|float|void|for|do|while|if|else|return|void

%%
{TYPE} {keyward++;}
[{|}|(|)] {brac++;}
\n {lines++; words++;}
[\t ' '] words++;
([  ])+ blank_space++;
[a-zA-Z] c_letters++;
[0-9] num++;


"//".* {a++;}
"/*" {b++;}
.*"*/" {b--;c++;}


%%


/* coding part */

/* if anything don't match...it back to the lex analser

int yywrap() {
        return 1;
}

int main()
{

        yyin = fopen("myScan.c","r");  
    /*   printf("Enter your input:  ");  */
        yylex();
        total = c_letters+num+spl_chr;
        total_comment=a+c;
        printf("\n File contents...\n");
        printf("\n\t %d single line comment",a);
         printf("\n\t %d Number of braces ",brac);
        printf("\n\t %d multiline comment",c);
        printf("\n\t %d total comment",total_comment);
        printf("\n\t %d line",lines);
        printf("\n\t %d Keyward",keyward);
        printf("\n\t %d blank",blank_space);
        printf("\n\t %d words",words);
        printf("\n\t %d characters",c_letters);
        printf("\n\t %d Digits", num);
        printf("\n\t %d Special Characters",spl_chr);
        printf("\n\t Total %d characters",total);
        return 0;
}