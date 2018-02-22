%{
    #include "zoomjoystrong.h"
    #include <stdlib.h>
%}

%option noyywrap

%%


(END)	  { return END }
;	  { return END_STATEMENT }
(point)([0-9]+)([0-9]+)  { yylval.str = strdup(yytext); return POINT; }
(line)([0-9]+)([0-9]+)([0-9]+)([0-9]+)	{ yylval.str = strdup(yytext); return LINE; }
(circle)([0-9]+)([0-9]+)([0-9]+)  { yylval.str = strdup(yytext); return CIRCLE; }
(rectangle)([0-9]+)([0-9]+)([0-9]+)([0-9]+) { yylval.str = strdup(yytext); return RECTANGLE; }
(set_color)([0-9]+)([0-9]+)([0-9]+) {yylval.str = strdup(yytext); return SET_COLOR; }
[0-9]+	  { yylval.i = atoi(yytext); return INT; }
-?[0-9]+\.[0-9]+ {yylval.f = atof(yytext); return FLOAT; }
,	  { return SEPARATOR; }
[ \t\n]	  ;


%%
