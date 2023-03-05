%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "t2c.h"
	#include "t_parse.h"
%}

%token lWRITE lREAD lIF lASSIGN
%token lRETURN lBEGIN lEND
%left  lEQU lNEQ lGT lLT lGE lLE
%left  lADD lMINUS
%left  lTIMES lDIVIDE
%token lLP lRP
%token lINT lREAL lSTRING
%token lELSE
%token lMAIN
%token lSEMI lCOMMA
%token lID lINUM lRNUM lQSTR

%expect 1

%%
prog	:	mthdcls
		{ printf("Program -> MethodDecls\n");
		  printf("Parsed OK!\n"); }
	|
		{ printf("****** Parsing failed!\n"); }
	;

mthdcls	:	mthdcl mthdcls
		{ printf("MethodDecls -> MethodDecl MethodDecls\n"); }
	|	mthdcl
		{ printf("MethodDecls -> MethodDecl\n"); }
	;

type	:	lINT
		{ printf("Type -> INT\n"); }
	|	lREAL
		{ printf("Type -> REAL\n"); }
	;

mthdcl	:	type lMAIN lID lLP formals lRP Block
		{ printf("MethodDecl -> Type MAIN ID LP Formals RP Block\n"); }
	|	type lID lLP formals lRP Block
		{ printf("MethodDecl -> Type ID LP Formals RP Block\n"); }
	;

formals	:	formal oformal
		{ printf("Formals -> Formal OtherFormals\n"); }
	|
		{ printf("Formals -> \n"); }
	;

formal	:	type lID
		{ printf("Formal -> Type ID\n"); }
	;

oformal	:	lCOMMA formal oformal
		{ printf("OtherFormals -> COMMA Formal OtherFormals\n"); }
	|
		{ printf("OtherFormals -> \n"); }
	;

Block   :   lBEGIN Statement oBlock lEND
        {printf("Block -> BEGIN Statement oBlock End \n");}
    ;

oBlock	:	Statement oBlock
		{printf("OtherBlock -> Statement OtherBlock \n");}
	|
		{printf("OtherBlock -> \n");}

Statement   :  Block
        {printf("Statement -> Block\n");}
    | LocalVarDecl
        {printf("Statement -> LocalVarDecl\n");}
    | AssignStmt
        {printf("Statement -> AssignStmt\n");}
    | ReturnStmt
        {printf("Statement -> ReturnStmt\n");}
    | IfStmt
        {printf("Statement -> IfStmt\n");}
    | WriteStmt
        {printf("Statement -> WriteStmt\n");}
    | ReadStmt
        {printf("Statement -> ReadStmt\n");}
    ;

LocalVarDecl: type lID lSEMI
        {printf("LocalVarDecl -> Type Id ; \n");}
    | type AssignStmt
        {printf("LocalVarDecl -> Type AssignStmt \n");}
    ;

AssignStmt:  lID lASSIGN Expression lSEMI
        {printf("AssignStmt -> Id := Expression \n");}
    ;

ReturnStmt:  lRETURN Expression lSEMI
        {printf("ReturnStmt -> RETURN Expression \n");}
    ;

IfStmt:      lIF lLP BoolExpr lRP Statement
        {printf("IfStmt -> IF ( BoolExpr ) Statement \n");}
    | lIF lLP BoolExpr lRP Statement lELSE Statement
        {printf("IfStmt -> IF ( BoolExpr ) Statement ELSE Statement \n");}
    ;

WriteStmt:   lWRITE lLP Expression lCOMMA lQSTR lRP lSEMI
        {printf("WriteStmt -> WRITE ( Expression , QString ) ; \n");}
    ;

ReadStmt:    lREAD lLP lID lCOMMA lQSTR lRP lSEMI
        {printf("ReadStmt -> READ ( Id , QString ) ; \n");}
    ;

Expression:  MultiplicativeExpr oMultiplicativeExpr
        {printf("Expression -> MultiplicativeExpr OtherMultiplicativeExpr\n");}
    ;

MultiplicativeExpr: PrimaryExpr oPrimaryExpr
        {printf("MultiplicativeExpr -> PrimaryExpr OtherPrimaryExpr\n");}
    ;

oMultiplicativeExpr: lADD MultiplicativeExpr oMultiplicativeExpr
        {printf("OtherMultiplicativeExpr -> + MultiplicativeExpr OtherMultiplicativeExpr \n");}
    |  lMINUS MultiplicativeExpr oMultiplicativeExpr
        {printf("OtherMultiplicativeExpr -> - MultiplicativeExpr OtherMultiplicativeExpr \n");}
    |
        {printf("OtherMultiplicativeExpr -> \n");}
    ;

PrimaryExpr:  lINUM
        {printf("PrimaryExpr -> INT\n");}
    |  lRNUM
        {printf("PrimaryExpr -> REAL\n");}
    |  lID
        {printf("PrimaryExpr -> ID\n");}
    |  lLP Expression lRP
        {printf("PrimaryExpr -> ( Expression )\n");}
    |  lID lLP ActualParams lRP
        {printf("PrimaryExpr -> ID ( ActualParams )\n");}
    ;

oPrimaryExpr:  lTIMES PrimaryExpr oPrimaryExpr
        {printf("OtherPrimaryExpr -> lTIMES PrimaryExpr OtherPrimaryExpr \n");}
    |  lDIVIDE PrimaryExpr oPrimaryExpr
        {printf("OtherPrimaryExpr -> lDIVIDE PrimaryExpr OtherPrimaryExpr \n");}
    |
        {printf("OtherPrimaryExpr -> \n");}
    ;

BoolExpr:  Expression lEQU Expression
        {printf("BoolExpr -> Expression == Expression \n");}
    |  Expression lNEQ Expression
        {printf("BoolExpr -> Expression != Expression \n");}
    |  Expression lGT Expression
        {printf("BoolExpr -> Expression > Expression \n");}
    |  Expression lLT Expression
        {printf("BoolExpr -> Expression < Expression \n");}
    |  Expression lGE Expression
        {printf("BoolExpr -> Expression >= Expression \n");}
    |  Expression lLE Expression
        {printf("BoolExpr -> Expression <= Expression \n");}
    ;

ActualParams:  Expression oExpression
        {printf("ActualParams -> Expression OtherExpression\n");}
	|
		{printf("ActualParams -> \n");}
    ;

oExpression:  lCOMMA Expression oExpression
        {printf("OtherExpression -> ,  Expression OtherExpression \n");}
	|
		{printf("OtherExpression -> \n");}
    ;
%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return 1;
}

