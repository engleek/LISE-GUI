%token <int> INT 
%token <string> STRING
%token EOL 
%token EOF 
%token PTVIRG

%start main 
%type <(int*int*string*int*int*int) list> main
%%

main: EOF {[]}
| prota  main  {$1 :: $2} ;
prota : INT PTVIRG INT  PTVIRG STRING PTVIRG   INT PTVIRG  INT PTVIRG INT PTVIRG  EOL  {$1,$3,$5,$7,$9,$11}

;
