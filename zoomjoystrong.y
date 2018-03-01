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

zoomjoystrong:	zjs_list end
;

zjs_list: zjs_statement 
	| zjs_statement zjs_list 
;

zjs_statement:  point  
	|	line  
	|	circle	
	|	rectangle 
	|	set_color
;

point:	POINT INT INT END_STATEMENT
        {printf("%s %d %d;\n", $1, $2, $3); pointDraw($2,$3);}  
;

line:	LINE INT INT INT INT END_STATEMENT
	{printf("%s %d %d %d %d;\n", $1, $2, $3, $4, $5); lineDraw($2, $3, $4, $5);}
;

circle:	CIRCLE INT INT INT END_STATEMENT
	{printf("%s %d %d %d;\n", $1, $2, $3, $4); circleDraw($2, $3, $4);}
;

rectangle:  RECTANGLE INT INT INT INT END_STATEMENT
	{printf("%s %d %d %d %d;\n", $1, $2, $3, $4, $5); rectangleDraw($2, $3, $4, $5);}
;

set_color:  SET_COLOR INT INT INT END_STATEMENT
	{printf("%s %d %d %d;\n", $1, $2, $3, $4); set_colorDraw($2, $3, $4);}
;

end: END END_STATEMENT
	{printf("%s;\n", $1); finish(); return 0;}
; 

%%


int main(int argc, char** argv){
  printf("\nZoomJoyStrong Commands:\npoint # #;\nline # # # #;\ncircle # # #;\nrectangle # # # #;\nset_color # # #;\nend;\n\n");
  setup();
  yyparse();
  printf("\n\nThanks for using ZoomJoyStrong!\n\n");
  return 0;
}

void yyerror(const char* msg){
  fprintf(stderr, "ERROR! %s\n", msg);
  yyparse(); 
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
  if(WIDTH-x >= r && x>=r && y>=r && HEIGHT-y >= r  && r > 0){ 
    circle(x,y,r);
  }
  else{
    printf("\nCan not draw this Circle; the Circle is not inside the window.\n");
  }

}

void rectangleDraw(int x, int y, int w, int h){
  if(x+w <= WIDTH && x+w > -1 && y+h <= HEIGHT && y+h > -1){ 
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
