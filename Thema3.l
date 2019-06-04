%{
#include<stdio.h>
#include<string.h>
int isspace();
%}

letter [ABKZS]

%s shape
%s tetragwno
%s gwnia
%s trigwno
%%

(D|d)inetai {printf("%s : a verb\n",yytext);}; BEGIN(shape);

<shape>" "*(T|t)rigwno {while(isspace(*yytext)) yytext++; printf("%s : a geometric entity\n",yytext);}; BEGIN(trigwno);
<shape>" "*(T|t)etragwno {while(isspace(*yytext)) yytext++; printf("%s : a geometric entity\n",yytext);}; BEGIN(tetragwno);
<shape>" "*(G|g)wnia {while(isspace(*yytext)) yytext++; printf("%s : a geometric entity\n",yytext);}; BEGIN(gwnia);

<gwnia>" "*{letter} {while(isspace(*yytext)) yytext++; printf("%s : a geometric expression name\n",yytext);printf("Expression Accepted");}
<trigwno>" "*{letter}{3} {while(isspace(*yytext)) yytext++;
                            if (yytext[0]==yytext[1] || yytext[1]==yytext[2] || yytext[0]==yytext[2])
                            {printf("\n%s does not describe a triangle because it has duplicate letters\n",yytext);}
                            else 
                            {printf("%s : a geometric expression name\n",yytext); printf("Expression Accepted");}}
<tetragwno>" "*{letter}{4} {while(isspace(*yytext)) yytext++;
                            if (yytext[0]==yytext[1] || yytext[0]==yytext[2] || yytext[0]==yytext[3]
                            || yytext[1]==yytext[2] || yytext[1]==yytext[3] || yytext[2]==yytext[3])
                            {printf("\n%s does not describe a square because it has duplicate letters\n",yytext);}
                            else 
                            {printf("%s : a geometric expression name\n",yytext); printf("Expression Accepted");}}
. ;


%%
int main()
{
    printf("This scanner accepts input of the following form:\nDinetai Triwno/Tetragwno/Gwnia A/B/K/Z/S\nFor convenience it also accepts capitalized words and lowercase edge letters.\n");
    yylex();
}