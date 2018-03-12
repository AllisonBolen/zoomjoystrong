%{
    #include "zoomjoystrong.h"
    #include <stdio.h> 
    int yylex();
    
    //** catches errors **//
    void yyerror(const char* msg);
    
    //** draws line if input is valid **//
    void lineDraw(int x, int y, int a, int b);
    
    //** draws point if input is valid **//
    void pointDraw(int x, int y);
    
    //** draws circle if input is valid **//
    void circleDraw(int x, int y, int r);
    
    //** sets color if input is valid **//
    void set_colorDraw(int r, int b, int g);
    
    //** draws rectangle if input is valid **//
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

// * * * * * * * * *
// Prints commands at start
// calls the setup function for settingup the drawing window
// calls the parsing fucntion to begin accepting input
// prints a statement at the end then quit
// params: int argc, char** argv, command line input 
// * * * * * * * * *
int main(int argc, char** argv){
  printf("\nZoomJoyStrong Commands:\npoint # #;\nline # # # #;\ncircle # # #;\nrectangle # # # #;\nset_color # # #;\nend;\n\n");
  setup();
  yyparse();
  printf("\n\nThanks for using ZoomJoyStrong!\n\n");
  return 0;
}

// * * * * * * * * *
// if we encounter something we dont want outputs the error and keeps running
// params: const char* msg = error message 
// * * * * * * * * *
void yyerror(const char* msg){
  fprintf(stderr, "ERROR! %s\n", msg);
  yyparse(); 
}

// * * * * * * * * *
// calls the point method to draw it
// params: int x = x coordinate, int y = y cooridinate
// if the int values sent in are out of the range of the window then output a message stating that. 
// * * * * * * * * *
void pointDraw(int x, int y){
  if(x < HEIGHT && x > 0 && x < WIDTH && y < HEIGHT && y > 0 && y < WIDTH){
   point(x , y);
  }
  else{
    printf("\nCan not draw this Point; the Point is not inside the window.\n");
  }
}

// * * * * * * * * *
// calls the line method to draw it
// params: int x = starting x coordinate, int y = starting y cooridinate, int a = ending x coordinate, int b = ending y coordinate
// if the int values sent in are out of the range of the window then output a message stating that. 
// * * * * * * * * *
void lineDraw(int x, int y, int a, int b){
  if(x < HEIGHT && x > 0 && x < WIDTH && y < HEIGHT && y > 0 && y < WIDTH && a < HEIGHT && a > 0 && a < WIDTH && b < HEIGHT && b > 0 && b < WIDTH){
   line(x,y,a,b);
  }
  else{
    printf("\nCan not draw this Line; the Line is not inside the window.\n");
  }
}

// * * * * * * * * *
// calls the circle method to draw it
// params: int x = x coordinate, int y = y cooridinate, int r = radius
// if the int values sent in are out of the range of the window then output a message stating that. 
// * * * * * * * * *
void circleDraw(int x, int y, int r){
  if(WIDTH-x >= r && x>=r && y>=r && HEIGHT-y >= r  && r > 0){ 
    circle(x,y,r);
  }
  else{
    printf("\nCan not draw this Circle; the Circle is not inside the window.\n");
  }

}

// * * * * * * * * *
// calls the rectangle method to draw it
// params: int x = x coordinate, int y = y cooridinate, int w = width of rect, int h = height of rect
// if the int values sent in are out of the range of the window then output a message stating that. 
// * * * * * * * * *
void rectangleDraw(int x, int y, int w, int h){
  if(x+w <= WIDTH && x+w > -1 && y+h <= HEIGHT && y+h > -1){ 
    rectangle(x,y,w,h);
  }
  else{
    printf("\nCan not draw this Rectangle; the Rectangle is not inside the window.\n");
  }
  
}

// * * * * * * * * *
// calls the rectangle method to draw it
// params: int r = red value, int b = blue value, int g = green value
// if the int values sent in are out of the range of 0-255 then output a message stating that. 
// * * * * * * * * *
void set_colorDraw(int r, int b, int g){
  if(r < 256 && r > -1 && b < 256 && b > -1 && g < 256 && g > -1){
    set_color(r,b,g);
  }
  else{
    printf("\nYour color number is invalid.\n");
  }
}
