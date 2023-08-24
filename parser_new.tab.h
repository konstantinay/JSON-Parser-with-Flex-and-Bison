/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_PARSER_NEW_TAB_H_INCLUDED
# define YY_YY_PARSER_NEW_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    LCURLY = 258,
    RCURLY = 259,
    LBRAC = 260,
    RBRAC = 261,
    LAST = 262,
    ACTIVE = 263,
    CONTENT = 264,
    G_ID = 265,
    D_ID = 266,
    D_TIME = 267,
    STATUS = 268,
    D_BREAK = 269,
    V_DRAW = 270,
    PRICE_P = 271,
    AMNT = 272,
    W_NUM = 273,
    LIST = 274,
    BONUS = 275,
    P_CAT = 276,
    W_STAT = 277,
    ID = 278,
    DIVT = 279,
    WINNS = 280,
    DSTBTD = 281,
    JACK = 282,
    FXD = 283,
    C_TYPES = 284,
    G_TYPES = 285,
    MIN_DSTR = 286,
    COLS = 287,
    WGRS = 288,
    ADD_ON = 289,
    TOT_PGS = 290,
    TOT_ELS = 291,
    NUM_ELS = 292,
    SORT = 293,
    DRCTN = 294,
    PROPRT = 295,
    IG_CASE = 296,
    N_HAND = 297,
    DESC = 298,
    ASCE = 299,
    FIRST = 300,
    SIZE = 301,
    NUMB = 302,
    PROP_S = 303,
    STRING = 304,
    REAL_NUM = 305,
    INT_NUM = 306,
    VTRUE = 307,
    VFALSE = 308
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 52 "parser_new.y"

	char *string;
	double decimal;
	int num;
	bool boolConstant;

#line 118 "parser_new.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_NEW_TAB_H_INCLUDED  */
