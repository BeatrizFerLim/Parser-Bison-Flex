/*==== DECLARATIONS ==========================================================*/
%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "anasin.tab.h"
%}


/*The regular expression to get the comments of the input*/
commentsExpression "/*".*."*/"

beginExpression "begin"
endExpression "end"

/*The regular expression used to get illegal symbols of the input*/
illegalSymbolsExpression "@"|"#"|"$"|"?"|"÷"|"π"|"√"|"¶"|"∆"|"£"|"~"

/*The regular expression used to get llegal variable declaration*/
/*Example? int 1a*/
illegalVariablesExpression ([0-9]|{illegalSymbolsExpression})[A-Za-z][A-Za-z0-9]*

/*The regular expression to get reserved words of the input*/
commandIf "if"
commandFor "for"
commandWhile "while"
commandElse "else"
commandPrint "print"

/*The regular expression to get the strings of the input*/
stringsExpression (\"(\\.|[^"\\])*\")

/*The regular expression to get integer numbers of the input*/
integersExpression [0-9]+

/*The regular expression to get float numbers of the input*/
floatsExpression [0-9]+"."[0-9]+

/*The regular expression to get valid variables declaration of the input*/
variablesExpression [A-Za-z][A-Za-z0-9]*

/*The regular expression to get types word of the input*/
typesExpression "int"|"float"|"string"|"array"

/*The regular expression to get operators symbols of the input*/
operatorsExpression "+"|"-"|"*"|"/"|"!="|"++"|"--"|"=="|">="|">"|"<="|"<"|%|"&&"|"||"|"!"

operatorEqual "="

commentContent "."

/* ==== TRANSLATION RULES ====================================================*/
%%

{beginExpression} return(BEGIN_CODE);

{endExpression} return(END_CODE);

{commentsExpression} return(COMMENT);

{commandIf} return(IF);

{commandFor} return (FOR);

{commandWhile} return (WHILE);

{commandElse} return (ELSE);

{commandPrint} return (PRINT);

"\t" return(TAB);

"\n" return(ENTER);

{operatorEqual} return (EQUAL);

{stringsExpression} return(STRING);

{integersExpression} return(INT);

{floatsExpression} return(FLOAT);

{typesExpression} return(TYPE);

{variablesExpression} return(VARIABLE);

{operatorsExpression} return(OPERATOR);

"[" return (OB);

"]" return (CB);

"{" return (OCB);

"}" return (CCB);

"(" return (OP);

")" return (CP);

"," return (COMMA);

"''" return (APOST);

";" return (SC);

":" return (COLON);

{illegalVariablesExpression} return IVAR;

{illegalSymbolsExpression} return ISYMBOL;

%%

/* ==== AUXILIARY FUNCTIONS ====================================================*/
int yywrap(){} 
