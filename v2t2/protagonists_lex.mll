{
 open Protagonists_yacc

}

  

rule token = parse 
  [' ' '\t']     { token lexbuf }     (* mange les blancs et les tab  *)
  | ['\n' ]        { EOL }
  | eof            { EOF}      
  |[';'] {PTVIRG}
  |  (['0'-'9']*) as lxm  { INT (int_of_string lxm)}  
  |  ( ['a'-'z']* | ['A'-'Z']* | ['/'':' '-' '.' ' ' '_' ]*|['0'-'9']*)* as lxm  { STRING (lxm)}
 
