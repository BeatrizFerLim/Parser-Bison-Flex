%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex();
    void yyerror(char const *);
%}

%start start

%token COMMENT TAB ENTER ISYMBOL IVAR
%token FOR WHILE IF ELSE PRINT /* comandos */
%token STRING FLOAT INT /* tipos */
%token VARIABLE TYPE OPERATOR
%token EQUAL OB CB OCB CCB OP CP COMMA APOST SC COLON
%token BEGIN_CODE END_CODE

%% 

start: 
      %empty                                                                  |
      BEGIN_CODE ENTER  body  END_CODE {printf("Fim do programa!");}
      ;

body:
      command SC ENTER body start         |
      declaration SC ENTER  body start    |
      attribution SC ENTER  body start    |
      initializer ENTER body start        |
      expr SC ENTER body start            |
      start                               |
      erro 
    ;


erro: 
      ISYMBOL {printf("Sentença inválida\n"); break;} |
      IVAR    {printf("Sentença inválida\n"); break;} 
    ;

command:
      IF OP expr CP OCB expr CCB   {printf("Comando IF identificado!\n");}                       |
      IF OP expr CP OCB expr_stmt CCB ENTER ELSE OCB expr_stmt CCB  {printf("Comando IF/ELSE identificado!\n");} |
	    FOR OP expr_stmt expr_stmt expr CP OCB expr_stmt CCB {printf("Comando FOR identificado!\n");}   |
      WHILE OP expr CP OCB expr_stmt CCB  {printf("Comando WHILE identificado!\n");}                  |
      PRINT OP initializer CP {printf("Comando PRINT identificado\n");}
     

    ;


expr_stmt:
      expr SC
    ;

declaration:
      TYPE VARIABLE    {printf("Declaração de variável identificada!\n");}                         |
      TYPE attribution {printf("Declaração de variável com atribuição identificada!\n");}  
    ;

attribution:
      VARIABLE EQUAL initializer {printf("Atribuição identificada!\n");}  |
      VARIABLE EQUAL expr  {printf("Atribuição identificada!\n");}
    ;

expr:
      OP expr OP                 |
      VARIABLE EQUAL initializer |
      VARIABLE OPERATOR initializer   {printf("Expressão lógica/aritmética identificada!\n");}  | 
      VARIABLE OPERATOR   {printf("Expressão lógica/aritmética identificada!\n");}           |
      OPERATOR VARIABLE   {printf("Expressão lógica/aritmética identificada!\n");}
    ;
initializer:
      VARIABLE {printf("Variável\n");}        | 
      INT      {printf("Inteiro\n");}         | 
      FLOAT    {printf("Ponto flutuante\n");} |
      STRING   {printf("String\n");} 
    ;
%%

void yyerror(char const *s){
    printf("%s\n", s);
}

int main(){
    yyparse();
}


      

