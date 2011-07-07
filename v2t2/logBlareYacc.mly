%token <string> INT 
%token <string> FLOAT
%token <string> STRING
%token EOL 
%token EOF 
%token PTVIRG
%token CH_OUV
%token CH_FER
%token ACC_OUV 
%token ACC_FER
%token CR_OUV
%token CR_FER
%token DXPTS
%token ALERT_BLARE
%start main 
%type <Log.log_elem list> main
%%




main: EOF {[]}
| log  main  {$1 :: $2} ;

log : CH_OUV INT CH_FER CR_OUV FLOAT CR_FER CR_OUV STRING CR_FER STRING nom  INT CH_FER STRING nom INT CH_FER ACC_OUV list_tag ACC_FER EOL
  { Log.make_log $5 $10 $11 $12 $14 $15 $16 $19 };



nom :
| STRING DXPTS STRING {Log.make_nom ([$1]@[$3])} 
| STRING  {Log.make_nom [$1]} ;

list_tag:
| INT  {[$1]}
| INT  list_tag  {$1::$2}

