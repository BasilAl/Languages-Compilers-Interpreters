%{
#include <stdio.h>
#include <string.h>
int isspace();
%}

type integer|bool|real|char
name [a-zA-Z][a-zA-Z0-9_]*

%x ident
%x vtype

%%

(S|s)ection" "* {printf("Variable Declaration Initialisation: %s\n",yytext);};BEGIN(ident);
<ident>{name}" "*"," {printf("\nVariable name: ");
                        while(isspace(*yytext)) yytext++;
                        for (int i=0;i<strlen(yytext)-1;i++)
                        {printf("%c",yytext[i]);}
                        };BEGIN(ident);
<ident>" "*{name}" "*":" {printf("\nVariable name: ");
                        while(isspace(*yytext)) yytext++;
                        for (int i=0;i<strlen(yytext)-1;i++)
                        {printf("%c",yytext[i]);}
                        };BEGIN(vtype);

<vtype>" "*{type}" "*";" {printf("\nVariable Type: ");
                        while(isspace(*yytext)) yytext++;
                        for (int i=0; i<strlen(yytext)-1; i++)
                        {printf("%c",yytext[i]);}
                        printf("\n");
                        printf("Declaration Accepted.");}; BEGIN(ident); 

. ;

%%

int main()
{
    printf("This parser recognises variable declarations in this format:\nsection var1,var2...:type1; var3,var4,...:type2; etc \nSection is declared once, and type can be any of the following: \nbool,integer,real,char\n");
    yylex();
}
