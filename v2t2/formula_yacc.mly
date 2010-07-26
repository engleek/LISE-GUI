%token <string> INT 
%token <string> STRING
%token EOL
%token EOF
%token PARO
%token PARF
%token AND
%token OR
%token VIRG
%token TRUE
%token FALSE
%token SQUARE
%token NOT
%token A
%token E
%token EQUIV
%token IMPLY
%token DIAMOND
%token NEXT
%start main 
%type <Formula.formula> main
%%

main: EOF {failwith "Formule vide" }
| formula {$1} ;

formula: 
| PARO formula PARF {$2}
| vp {$1}
| TRUE {Formula.True}
| FALSE {Formula.False}
| NOT formula {Formula.Neg($2)}
| PARO formula AND formula PARF {Formula.And($2,$4)} ;
| formula AND formula {Formula.And($1,$3)} ;
| PARO formula OR formula PARF {Formula.Or($2,$4)} ;
| formula OR formula {Formula.Or($1,$3)} ;
| PARO formula IMPLY formula PARF {Formula.Implies($2,$4)} ;
| PARO formula EQUIV formula PARF {Formula.Equiv($2,$4)} ;
| A formula {Formula.A($2)}
| E formula {Formula.E($2)}
| NEXT formula {Formula.Next($2)}
| DIAMOND formula {Formula.Diamond($2)}
| SQUARE formula {Formula.Square($2)}
vp: STRING { Formula.VP($1)}
