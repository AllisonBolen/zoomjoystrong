%{
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
zoomjoystrong: point  |	line  |	circle	| rectangle | set_color ;

point:	POINT SEPARATOR INT SEPERATOR INT END_STATEMENT
        {printf("\n---------\n");}
        ;
line:	LINE SEPARATOR INT SEPARATOR INT SEPARATOR INT SEPARATOR INT END_STATEMENT
	{printf("\n---------\n");}
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

%%

int main(int argc, char** argv){
  printf("\n==========\n");
  yyparse();
  printf("\n\n=========\nZoomJoyStrong running good");
  return 0;
}

void yyerror(const char* msg){
  fprintf(stderr, "ERROR! %s\n", msg);
}
