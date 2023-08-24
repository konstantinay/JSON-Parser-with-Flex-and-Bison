%{
	/* definitions */

	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <stdbool.h>
	#include "parser_new.tab.h"

	int my_line =1;

%}

%option noyywrap
/*EXP([Ee][-+]?[0-9]+)*/

CHARS [^"]*
ESC_CHARS \\["\\bfnrt/]
HEXS [0-9a-f]
UNCD \\u{HEXS}{HEXS}{HEXS}{HEXS}
ALL_CHARS {CHARS}|{ESC_CHARS}|{UNCD}

/* rules */
%%

\"last\" 					{printf("%s", yytext); return LAST;}
\"active\"\:				{printf("%s", yytext); return ACTIVE;}
\"content\"					{printf("%s", yytext); return CONTENT;}
\"gameId\"					{printf("%s", yytext); return G_ID;}
\"drawId\"					{printf("%s", yytext); return D_ID;}
\"drawTime\"				{printf("%s", yytext); return D_TIME;}
\"status\"					{printf("%s", yytext); return STATUS;}
\"drawBreak\"				{printf("%s", yytext); return D_BREAK;}
\"visualDraw\"				{printf("%s", yytext); return V_DRAW;}
\"pricePoints\"				{printf("%s", yytext); return PRICE_P;}
\"amount\"					{printf("%s", yytext); return AMNT;}
\"winningNumbers\"			{printf("%s", yytext); return W_NUM;}
\"list\"					{printf("%s", yytext); return LIST;}
\"bonus\"					{printf("%s", yytext); return BONUS;}
\"prizeCategories\"			{printf("%s", yytext); return P_CAT;}
\"wagerStatistics\"			{printf("%s", yytext); return W_STAT;}
\"id\"						{printf("%s", yytext); return ID;}
\"divident\"				{printf("%s", yytext); return DIVT;}
\"winners\"					{printf("%s", yytext); return WINNS;}
\"distributed\"				{printf("%s", yytext); return DSTBTD;}
\"jackpot\"					{printf("%s", yytext); return JACK;}
\"fixed\"					{printf("%s", yytext); return FXD;}
\"categoryType\"			{printf("%s", yytext); return C_TYPES;}
\"gameType\"				{printf("%s", yytext); return G_TYPES;}
\"minimumDistributed\"		{printf("%s", yytext); return MIN_DSTR;}
\"columns\"					{printf("%s", yytext); return COLS;}
\"wagers\"					{printf("%s", yytext); return WGRS;}
\"addOn\"					{printf("%s", yytext); return ADD_ON;}
\"totalPages\"				{printf("%s", yytext); return TOT_PGS;}
\"totalElements\"			{printf("%s", yytext); return TOT_ELS;}
\"numberOfElements\"		{printf("%s", yytext); return NUM_ELS;}
\"sort\"					{printf("%s", yytext); return SORT;}
\"direction\"				{printf("%s", yytext); return DRCTN;}
\"property\"				{printf("%s", yytext); return PROPRT;}
\"ignoreCase\"				{printf("%s", yytext); return IG_CASE;}
\"nullHandling\"			{printf("%s", yytext); return N_HAND;}
\"descending\"				{printf("%s", yytext); return DESC;}
\"ascending\"				{printf("%s", yytext); return ASCE;}
\"first\"					{printf("%s", yytext); return FIRST;}
\"size\"					{printf("%s", yytext); return SIZE;}
\"number\"					{printf("%s", yytext); return NUMB;}

\n {printf("%s",yytext); my_line++;}
\{ {printf("{"); return LCURLY;}
\} {printf("}"); return RCURLY;}
\[ {printf("["); return LBRAC;}
\] {printf("]"); return RBRAC;}
,  {printf(","); return ',';}
: {printf(":"); return ':';}

true	{yylval.boolConstant = true; printf("%s", yytext); return VTRUE;}
false	{yylval.boolConstant = false; printf("%s", yytext); return VFALSE;}

\"{ALL_CHARS}+\.{ALL_CHARS}+\"	{yylval.string = strdup(yytext); printf("%s", yytext); return PROP_S;}
\"{ALL_CHARS}+\" 				{yylval.string = strdup(yytext); printf("%s", yytext); return STRING;}
[0-9]+							{yylval.num = atoi(yytext); printf("%s", yytext); return INT_NUM;}
[0-9]+\.[0-9]+					{yylval.decimal = atof(yytext); printf("%s", yytext); return REAL_NUM;}
%%

