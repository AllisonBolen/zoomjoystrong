%{
    #include "zoomjoystrong.h"
    #include <stdio.h>
    void yyerror(const char* msg);
    int yylex();
    void lineDraw(int x, int y, int a, int b);
    void pointDraw(int x, int y);
    void circleDraw(int x, int y, int r);
    void set_colorDraw(int r, int b, int g);
    void rectangleDraw(int x, int y, int w, int h);
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
        {printf("%s %d %d;\n", $1, $3, $5); pointDraw($3,$5);}  
	;
line:	LINE SEPARATOR INT SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("%s %d %d %d %d;\n", $1, $3, $5, $7, $9); lineDraw($3, $5, $7, $9);}
	;
circle:	CIRCLE SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("%s %d %d %d;\n", $1, $3, $5, $7); circleDraw($3, $5, $7);}
	;
rectangle:  RECTANGLE SEPARATOR INT SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("%s %d %d %d %d;\n", $1, $3, $5, $7, $9); rectangleDraw($3, $5, $7, $9);}
	;
set_color:  SET_COLOR SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("%s %d %d %d;\n", $1, $3, $5, $7); set_colorDraw($3, $5, $7);}
	;
end: END END_STATEMENT
	{finish(); 
         return 0;}
	; 

%%


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

void pointDraw(int x, int y){
  if(x < HIEGHT && x > 0 && x < WIDTH && y < HIEGHT && y > 0 && y < WIDTH){
   point(x , y);
  }
  return;
}

void lineDraw(int x, int y, int a, int b){
  if(x < HIEGHT && x > 0 && x < WIDTH && y < HIEGHT && y > 0 && y < WIDTH && a < HIEGHT && a > 0 && a < WIDTH && b < HIEGHT && b > 0 && b < WIDTH){
   line(x,y,a,b);
  } 
 return;
}

void circleDraw(int x, int y, int r){
  if(x < HIEGHT && x > 0 && x < WIDTH && y < HIEGHT && y > 0 && y < WIDTH && r < HIEGHT && r > 0 && r < WIDTH){
   circle(x,y,r);
  }
  return;
}

void rectangleDraw(int x, int y, int w, int h){
  if(x < HIEGHT && x > 0 && x < WIDTH && y < HIEGHT && y > 0 && y < WIDTH && h < HIEGHT && h > 0 && h < WIDTH && w < HIEGHT && w > 0 && w < WIDTH){
   rectangle(x,y,w,h);
  }
  return;
}

void set_colorDraw(int r, int b, int g){
  if(r < 256 && r > -1 && b < 256 && b > -1 && g < 256 && g > -1){
    set_color(r,b,g);
  }
  return;
}
