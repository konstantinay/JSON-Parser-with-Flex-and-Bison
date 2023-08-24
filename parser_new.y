%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <stdbool.h>

	FILE *yyin;
	extern char* yytext;
	extern int my_line;
	int yylex();
	void yyerror(const char *s);
	bool includes(int array[], int length, int value);

	int flag;
	int gameIdValues[] = {1100, 1110, 2100, 2101, 5103, 5104, 5106};
	int lcounter = 1;
%}

%token LCURLY RCURLY LBRAC RBRAC
%token LAST
%token ACTIVE
%token CONTENT
%token G_ID
%token D_ID
%token D_TIME
%token STATUS
%token D_BREAK
%token V_DRAW
%token PRICE_P
%token AMNT
%token W_NUM
%token LIST BONUS
%token P_CAT
%token W_STAT
%token ID DIVT WINNS DSTBTD JACK FXD C_TYPES G_TYPES MIN_DSTR
%token COLS WGRS ADD_ON
%token TOT_PGS
%token TOT_ELS
%token NUM_ELS
%token SORT
%token DRCTN PROPRT IG_CASE N_HAND DESC ASCE
%token FIRST
%token SIZE
%token NUMB

%token<string> PROP_S;
%token<string> STRING;
%token<decimal> REAL_NUM;
%token<num> INT_NUM;
%token<boolConstant> VTRUE VFALSE;

%union{
	char *string;
	double decimal;
	int num;
	bool boolConstant;
}

%%

json: LCURLY last ',' active RCURLY
	| LCURLY content ',' tP ',' tE ',' la ',' nE ',' sort ',' fi ',' si ',' nu RCURLY
;

last: LAST ':' LCURLY json_contents RCURLY
;

active: ACTIVE LCURLY json_contents RCURLY
;

content: CONTENT ':' js_array;

tP: TOT_PGS ':' INT_NUM;
tE: TOT_ELS ':' INT_NUM;
la: LAST ':' booleans;
nE: NUM_ELS ':' INT_NUM;
sort: SORT ':' LBRAC sort_obj RBRAC;
fi: FIRST ':' booleans;
si: SIZE ':' INT_NUM;
nu: NUMB ':' INT_NUM;

json_contents: json_content
		  	 | json_contents ',' json_content
;

json_content: gid | did | dtime | status | dbreak | vdraw 
			| pricep | win_nums | pr_cat | wg_stat
;

gid: 		G_ID ':' INT_NUM 
			{ if (includes(gameIdValues, 7, $3) == false) {yyerror("Wrong Input!");} };

did: 		D_ID ':' INT_NUM;
dtime: 		D_TIME ':' INT_NUM;
status: 	STATUS ':' STRING;
dbreak: 	D_BREAK ':' INT_NUM;
vdraw:  	V_DRAW ':' INT_NUM;

pricep:		PRICE_P ':' LCURLY amnt RCURLY;
amnt:		AMNT ':' REAL_NUM;

win_nums:	W_NUM ':' LCURLY list ',' bonus RCURLY;
list:		LIST ':' LBRAC l_inputs RBRAC {
	if (lcounter != 5) {yyerror("Wrong Input!");} 
	lcounter = 1;
};

l_inputs: INT_NUM {if ($1<1 || $1 > 45) {yyerror("Out of bounds!");}}
		| l_inputs ',' INT_NUM {
			if ($3<1 || $3 > 45) {yyerror("Out of bounds!");}
			if($3){lcounter++;}
};

bonus:	  BONUS ':' LBRAC INT_NUM RBRAC;

pr_cat:	  P_CAT ':' js_array {if (flag != 8){yyerror("Wrong Input!");}};

js_array: LBRAC RBRAC
		| LBRAC pc_json RBRAC
		| LBRAC con_json RBRAC
;

con_json: LCURLY RCURLY
		| LCURLY json_contents RCURLY
		| con_json ',' LCURLY json_contents RCURLY
;

pc_json: LCURLY pc_values RCURLY
	   | pc_json ',' LCURLY pc_values RCURLY
;

pc_values: pc_value
		 | pc_values ',' pc_value
;

pc_value: id | divt | winns | dstbtd | jack | fxd | c_type | g_type | min_dstr ;

id:			ID ':' INT_NUM {flag = $3; if ($3<1 || $3 > 8) {yyerror("Out of bounds!");} };
divt:		DIVT ':' REAL_NUM;
winns:		WINNS ':' INT_NUM;
dstbtd:		DSTBTD ':' REAL_NUM;
jack:		JACK ':' REAL_NUM;
fxd:		FXD ':' REAL_NUM;
c_type:		C_TYPES ':' INT_NUM {if ($3 > 1) {yyerror("Out of bounds!");} };
g_type:		G_TYPES ':' STRING;
min_dstr:	MIN_DSTR ':' REAL_NUM {if (MIN_DSTR && flag!=1) {yyerror("Unexpected token!");}};

wg_stat:	W_STAT ':' LCURLY COLS ':' INT_NUM ',' WGRS ':' INT_NUM ',' ADD_ON ':' array RCURLY;

sort_obj: LCURLY RCURLY
		| LCURLY sort_values RCURLY
;

sort_values: sort_value
		   | sort_values ',' sort_value
;

sort_value:  DRCTN ':' STRING
		   | PROPRT ':' PROP_S
		   | IG_CASE ':' booleans
		   | N_HAND ':' STRING
		   | DESC ':' booleans
		   | ASCE ':' booleans
;

booleans: VTRUE | VFALSE;

array: LBRAC RBRAC
	 | LBRAC values RBRAC
;

values: value
	  | values ',' value
;

value: STRING
	 | PROP_S
	 | INT_NUM
	 | REAL_NUM
	 | VTRUE
	 | VFALSE
;

%%

int main(int argc, char* argv[]){

	FILE *f;
	f = fopen(argv[1], "r");
	yyin = f;
	yyparse();
	printf("\nYou did it, you son of a bitch, you did it!\n");

	return 0;
}

void yyerror(const char *s){
	fprintf(stderr,"ERROR: %s on line %d", s, my_line);
	printf("\n");
	exit(1);
}

bool includes(int array[], int length, int value){
	for (int i = 0; i < length; i++)
	{
		if (array[i] == value) return true;
	}

	return false;
}