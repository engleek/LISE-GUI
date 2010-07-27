{
 open Formula_yacc
}



rule token = parse 
  [' ' '\t']     { token lexbuf }     (* mange les blancs et les tab  *)
  | ['\n' ]        { EOL }
  | eof            { EOF}
  | "TRUE"  {TRUE}
  | "FALSE" {FALSE}
  |['('] {PARO}
  | [')'] {PARF}
  | [','] {VIRG}
  | "AND" {AND}
  | "OR" {OR}
  | "NOT" {NOT}
  | "SQUARE" {SQUARE}
  |"DIAMOND" {DIAMOND}
  | "IMPLY" {IMPLY}
  | "EQUIV" {EQUIV}
  | 'E' {E}
  | 'A' {A}
  | 'X' {NEXT}
  |  ( ['a'-'z']* | ['A'-'Z']*|['0'-'9']*| ['/''_' '-' ] )* as lxm  { STRING (lxm)}
 
