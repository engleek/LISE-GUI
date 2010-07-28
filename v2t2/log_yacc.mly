%token <string> INT 
%token <Big_int.big_int> BIGINT
%token <string> STRING
%token EOL 
%token EOF 
%token PTVIRG
%token FLECHE
%token TIRET
%token CALL 
%token RESPONSE
%start main 
%type <Log.log_elem list> main
%%

main: EOF {[]}
| log  main  {$1 :: $2} ;
log :CALL PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG param  
  { Log.make_call  $3 $5 $7 $11 $13 $9 $15 $17 }
|RESPONSE PTVIRG  INT PTVIRG INT PTVIRG FLECHE TIRET PTVIRG STRING PTVIRG EOL {(Log.make_response   $3  $5  $10)}
;

param:
 EOL {[]}
| INT PTVIRG  param {$1::$3} 
| STRING PTVIRG  param {$1::$3} 

 

