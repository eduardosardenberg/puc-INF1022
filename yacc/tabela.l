%option yywrap
      #include <stdio.h>
      #include <unistd.h>
      /* Falta escrever comentários multilinha, booliano, \n, \t. /*
      /* Falta escrever a tabela de símbolos (hash) */

DIGITO                 [0-9]
LETRA                  [a-zA-Z]
ALFANUM                [a-zA-Z0-9]

%%
fim                           return(0);
(-|\+)*{DIGITO}+              printf("Leu o inteiro %d\n ", atoi(yytext));
(-|\+){DIGITO}+"."{DIGITO}*   printf("Leu o ponto flutuante %g\n ", atof(yytext));
'.'                           printf("Leu o caracter %s\n", yytext);
\"[^\n"]+\"                   printf("Leu a cadeia de caracteres %s\n", yytext);
\*{LETRA}+                    printf("Leu o ponteiro %s\n", yytext);
if|else|while|do|break|continue|return|case|switch|struct|typedef|sizeof|double|short|void|int|float|char|long|unsigned|static|goto|include      printf("Leu a palavra reservada %s\n ", yytext);
{LETRA}{ALFANUM}*          printf("Leu o identificador %s\n ", yytext);
[]({ })[]               printf("Leu o delimitador %s\n ", yytext);
"//".*                  printf("Leu o comentário linha unica %s\n ", yytext);
"+"|"-"|"*"|"/"         printf("Leu o operador %s\n ", yytext);
\n                      printf("Quebra de linha. \n");
%%

int main()
{
  yylex();
}