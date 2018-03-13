

%{

	#include <stdio.h>
	#include "zoomjoystrong.h"
	

	int yylex();


	//will plot line from x,y to u,v
	void plotLine(int x, int y, int u, int v);

	//plots a single point at x,y
	void plotPoint(int x, int y);

	//plots a circle of radius r around the center point at x,y
	void plotCircle(int x, int y, int r);

	//draws a rectangle of height h and width w beginning at the top left edge of x,y
	void drawRectangle(int x, int y, int w, int h);

	//sets color statement with syntax provided
	void setColor(int r, int g, int b);

	//Something to catch errors
	void yyerror(const char* msg);

%}


	%error-verbose
	%start zoomjoystrong

	%union {char* str; int i; float f; }

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

	
	zoomjoystrong: list end
	;

	list: zjs
	        | zjs list 
	;

	zjs:	        point
		|	line
		| 	circle
		|	rectangle
		|	set_color

	;



	point:	POINT INT INT END_STATEMENT
        	{printf("%s %d %d;\n", $1, $2, $3); plotPoint($2,$3);}  
	;

	line:	LINE INT INT INT INT END_STATEMENT
		{printf("%s %d %d %d %d;\n", $1, $2, $3, $4, $5); plotLine($2, $3, $4, $5);}
	;
	
	circle:	CIRCLE INT INT INT END_STATEMENT
		{printf("%s %d %d %d;\n", $1, $2, $3, $4); plotCircle($2, $3, $4);}
	;
	
	rectangle:  RECTANGLE INT INT INT INT END_STATEMENT
		{printf("%s %d %d %d %d;\n", $1, $2, $3, $4, $5); drawRectangle($2, $3, $4, $5);}
	;

	set_color:  SET_COLOR INT INT INT END_STATEMENT
		{printf("%s %d %d %d;\n", $1, $2, $3, $4); setColor($2, $3, $4);}
	;

	end: END END_STATEMENT
		{printf("%s;\n", $1); finish(); return 0;}
	; 

%%





//------------------------------------------------------------------------------------------------



	int main(int argc, char** argv){
	//first print statement showing user how to use program
	printf("Here are some example commands you can use...(n) = Number \n");
	printf("point (n) (n);\n");
	printf("line (n) (n) (n) (n);\n");
	printf("circle (n) (n) (n);\n");
	printf("rectangle (n) (n) (n) (n);\n");
	printf("set_color (n) (n) (n);\n");
	printf("end;\n");
	setup();
	yyparse();
	printf("\n Nice picture, you an art major or something?");
	return 0;
}

	//catches errors
	void yyerror(const char* err){
	fprintf(stderr, "Ya dun Goofed. %s\n", err);
	yyparse();
}

	//this is for the point method
	void plotPoint(int x, int y){
		if(x > 0 && y > 0 && x < HEIGHT &&  x < WIDTH && y < HEIGHT && y < WIDTH){
			point(x,y);
		}
	else{
		printf("\n let me POINT out that there is an error. out of range.\n");
}
}
	
	//this is for the line method
	void plotLine(int x, int y, int u, int v){
		if(x > 0 && y > 0 && u > 0 && v > 0 && x < HEIGHT && x < WIDTH && y < HEIGHT && y < WIDTH && u < HEIGHT && u < WIDTH && v < HEIGHT && v < WIDTH){
			line(x,y,u,v);
		}
	else{
		printf("\n This is where I draw the LINE with you causing errors. out of range.\n");
	}	
}

	//this is for the circle method
	void plotCircle(int x, int y, int r){
		if(r > 0 && WIDTH - x >= r && x >= r && y >= r && HEIGHT - y >= r){
			circle(x,y,r);
		}
	else{
		printf("\n CIRCLE of life man. You were bound to fail eventually. ERROR....  out of range.\n");
}
}

	//this is for the rectangle method
	void drawRectangle(int x, int y, int w, int h){
		 if(x + w <= WIDTH && x + w >= 0 && y + h <= HEIGHT && y + h >=  0){ 
   			 rectangle(x,y,w,h);
		 }
	else{
		printf("\n spent more time trying to think of a pun for rectangle then I'd like to admit. ERROR....  Out of range.\n");
}
}
	//this is for the color stuff
	// note to self.... only goes to 255 not 256
	void setColor(int r, int g, int b){
		if(r >= 0 && g >= 0 && b >= 0 && r < 256 && g < 256 && b < 256){
			set_color(r,g,b);

		}
	else{
		printf("\n the code must've RED something wrong causing an error. I know, it BLUE me away too. ERROR!\n");
}

}














