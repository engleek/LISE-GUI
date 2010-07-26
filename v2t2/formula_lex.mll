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
  | "?\136?" {AND}
  | "?\136?" {OR}
  | "¬" {NOT}
  | "?\150?" {SQUARE}
  |"?\151\138" {DIAMOND}
  | "?\134\146" {IMPLY}
  | "?\135\148" {EQUIV}
  | 'E' {E}
  | 'A' {A}
  | 'X' {NEXT}
  |  ( ['a'-'z']* | ['A'-'Z']*|['0'-'9']*| ['/''_' '-' ] )* as lxm  { STRING (lxm)}
 
