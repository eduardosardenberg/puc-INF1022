%{

/* Alunos:
DANIEL STULBERG HUF - 1920468
EDUARDO SARDENBERG TAVARES - 1911328
*/

/*NOTAS:
1. Gostaríamos muito de ter adicionado outros features da linguagem C, como a leitura de comentários multilinha,
porém o desconhecimento de uma expressão regular capaz de descrevê-lo foi um impedimento para isso...

*/

#include<stdio.h>
#include<math.h>
#include <stdlib.h>
#include<string.h>
#include <unistd.h>

#define CAPACIDADE 1000000

char* hash[CAPACIDADE];

void insere(char* string)
{   
    long long res = 0;
    int pos, i=0;
    while (string[i] != '\0') {
        res += (int) string[i] * pow(63, i);
        i++;
    }
    pos = res%CAPACIDADE;
    if (hash[pos]!= NULL) {
        printf("Colisão: hash[%d] já tem o elemento %s", pos, hash[pos]);
    }
    else {
        hash[pos] = (char *)malloc(strlen(string)*sizeof(char));
	strcpy(hash[pos], string);
        printf("%s inserido em hash[%d]\n", string,(pos));
    }
}

void exibe()
{
    int i;
    printf("\n-----------------------------\n");
    printf("TABELA HASH:\n");
    for(i = 0; i < CAPACIDADE; i++)
        if (hash[i]!=NULL)
            printf("hash[%d] = %s\n",i,hash[i]);
    printf("-----------------------------\n");
}

char* preparaConsulta (char *stringMaior) {
    char *copiaMaior = malloc(strlen(stringMaior) * sizeof(char));
    strcpy(copiaMaior, stringMaior);
    char * token = strtok(copiaMaior, ":");
    token = strtok(NULL, ":");
    return token;
}

void consulta (char* string)
{
    long long res = 0;
    int pos, i=0;
    while (string[i] != '\0') {
        res += (int) string[i] * pow(63, i);
        i++;
    }
    pos = res%CAPACIDADE;
    if(hash[pos]!=NULL && strcmp(hash[pos],string)==0)
        printf("Elemento %s encontrado na posição %d!\n", string, (pos));
    else
        printf("Elemento %s não foi encontrado na tabela hash.\n", string);
}

%}

DIGITO                 [0-9]
LETRA                  [a-zA-Z]
ALFANUM                [a-zA-Z0-9]

%%
fim   			      		      return(0);
consulta:.+                                   consulta(preparaConsulta(yytext));
-{DIGITO}+"."{DIGITO}*|{DIGITO}+"."{DIGITO}*  {printf("Leu o ponto flutuante %g\n ", atof(yytext)); insere(yytext);}                        
-{DIGITO}+|{DIGITO}+                          {printf("Leu o inteiro %d\n ", atoi(yytext)); insere(yytext);}
true|false                                    {printf("Leu o booleano %s\n", yytext); insere(yytext);}
'.'                                           {printf("Leu o caracter %s\n", yytext); insere(yytext);}
\"[^\n"]+\"                                   {printf("Leu a cadeia de caracteres %s\n", yytext); insere(yytext);}
\*{LETRA}+                                    {printf("Leu o ponteiro %s\n", yytext); insere(yytext);}
if|else|while|do|break|continue|return|case|switch|struct|typedef|sizeof|double|short|void|int|float|char|long|unsigned|static|goto|include      {printf("Leu a palavra reservada %s\n ", yytext); insere(yytext);}
{LETRA}{ALFANUM}*                             {printf("Leu o identificador %s\n ", yytext); insere(yytext);}
[]({ })[]                                     {printf("Leu o delimitador %s\n ", yytext); insere(yytext);}
"//".*                                        {printf("Leu o comentário linha unica %s\n ", yytext); insere(yytext);}
"+"|"-"|"*"|"/"                               {printf("Leu o operador %s\n ", yytext); insere(yytext);}
\t                                            {printf("Tabulação. \n"); insere(yytext);}
%%

int main()
{
	yylex();
	exibe();	
}