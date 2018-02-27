%{
    #include "zoomjoystrong.h"
    #include <stdio.h> 
    int yylex();
    void yyerror(const char* msg);
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
  return;  
}

void pointDraw(int x, int y){
  if(x < HEIGHT && x > 0 && x < WIDTH && y < HEIGHT && y > 0 && y < WIDTH){
   point(x , y);
  }
  else{
    printf("\nCan not draw this Point; the Point is not inside the window.\n");
  }
}

void lineDraw(int x, int y, int a, int b){
  if(x < HEIGHT && x > 0 && x < WIDTH && y < HEIGHT && y > 0 && y < WIDTH && a < HEIGHT && a > 0 && a < WIDTH && b < HEIGHT && b > 0 && b < WIDTH){
   line(x,y,a,b);
  }
  else{
    printf("\nCan not draw this Line; the Line is not inside the window.\n");
  }
}

void circleDraw(int x, int y, int r){
  if(x < HEIGHT && x > 0 && x < WIDTH && y < HEIGHT && y > 0 && y < WIDTH && r < HEIGHT && r > 0 && r < WIDTH){
   circle(x,y,r);
  }
  else{
    printf("\nCan not draw this Circle; the Circle is not inside the window.\n");
  }

}

void rectangleDraw(int x, int y, int w, int h){
  if(x < HEIGHT && x > 0 && x < WIDTH && y < HEIGHT && y > 0 && y < WIDTH && h < HEIGHT && h > 0 && h < WIDTH && w < HEIGHT && w > 0 && w < WIDTH){
   rectangle(x,y,w,h);
  }
  else{
    printf("\nCan not draw this Rectangle; the Rectangle is not inside the window.\n");
  }

}

void set_colorDraw(int r, int b, int g){
  if(r < 256 && r > -1 && b < 256 && b > -1 && g < 256 && g > -1){
    set_color(r,b,g);
  }
}
