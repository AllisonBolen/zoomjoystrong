%{
    #include "zoomjoystrong.h"
    #include <stdio.h>
    void yyerror(const char* msg);
    int yylex();
%}

%error-verbose
%start zoomjoystrong

%union { int i; char* str; float f;}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token SEPARATOR


%type<str> END
%type<str> END_STATEMENT
%type<str> POINT
%type<str> LINE
%type<str> CIRCLE
%type<str> RECTANGLE
%type<str> SET_COLOR
%type<i> INT
%type<f> FLOAT

%%

zoomjoystrong:zjs_list end;

zjs_list: zjs_statement | zjs_statement zjs_list;

zjs_statement: point  |	line  |	circle	| rectangle | set_color | end;

point:	POINT SEPARATOR INT SEPARATOR INT END_STATEMENT
        {printf("%s %d %d;\n", $1, $3, $5); point($3,$5);}  
	;
line:	LINE SEPARATOR INT SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("%s %d %d %d %d;\n", $1, $3, $5, $7, $9); lineDraw($3, $5, $7, $9);}
	;
circle:	CIRCLE SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("\n----------\n");}
	;
rectangle:  RECTANGLE SEPARATOR INT SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("\n----------\n");}
	;
set_color:  SET_COLOR SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("\n----------\n");}
	;
end: END END_STATEMENT
	{return 0;}
	; 

%%

void pointDraw(int x, int y){
// printf("HHEHHEHEHHEHEHEHHEHEHHEHHEHEHHEHEH");
 point(x , y);
 return;
}

void lineDraw(int x, int y, int a, int b){
  line(x,y,a,b);
  return;
}

int main(int argc, char** argv){
  printf("\n==========\n");
  setup();
  yyparse();
  printf("\n\n=========\nZoomJoyStrong running good\n");
  
  return 0;
}

void yyerror(const char* msg){
  fprintf(stderr, "ERROR! %s\n", msg);
}

