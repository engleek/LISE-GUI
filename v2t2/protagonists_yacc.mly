%token <int> INT 
%token <string> STRING
%token EOL 
%token EOF 
%token PTVIRG

%start main 
%type <(int*int*string*string) list> main
%%

main: EOF {[]}
| prota  main  {$1 :: $2} ;
prota : INT PTVIRG INT  PTVIRG STRING PTVIRG STRING EOL  {$1,$3,$5,$7}

;
