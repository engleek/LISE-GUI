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
%type <Log.log_line list> main
%%

main: EOF {[]}
| log  main  {$1 :: $2} ;
log :CALL PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG INT PTVIRG param  
  { Log.create_log_call (Log.Const ( $3))  (Log.Const ( $5 )) ( Log.Const $7)  (Log.Const $11) (Log.Const $13) ( Log.Const $9) (Log.Const $15) $17 }
|RESPONSE PTVIRG  INT PTVIRG INT PTVIRG FLECHE TIRET PTVIRG STRING PTVIRG EOL {(Log.create_log_response  (Log.Const $3)  (Log.Const $5)  (Log.Const $10))}
;

param:
 EOL {[]}
| INT PTVIRG  param {(Log.Const $1)::$3} 
| STRING PTVIRG  param {(Log.Const $1)::$3} 

 

