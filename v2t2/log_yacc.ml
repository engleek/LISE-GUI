type token =
  | INT of (string)
  | BIGINT of (Big_int.big_int)
  | STRING of (string)
  | EOL
  | EOF
  | PTVIRG
  | FLECHE
  | TIRET
  | CALL
  | RESPONSE

open Parsing;;
let yytransl_const = [|
  260 (* EOL *);
    0 (* EOF *);
  261 (* PTVIRG *);
  262 (* FLECHE *);
  263 (* TIRET *);
  264 (* CALL *);
  265 (* RESPONSE *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BIGINT *);
  259 (* STRING *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\003\000\003\000\003\000\000\000"

let yylen = "\002\000\
\001\000\002\000\017\000\012\000\001\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\000\000\000\000\008\000\000\000\000\000\
\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\004\000\000\000\000\000\
\000\000\000\000\000\000\000\000\005\000\003\000\000\000\000\000\
\006\000\007\000"

let yydgoto = "\002\000\
\006\000\007\000\038\000"

let yysindex = "\005\000\
\001\000\000\000\000\000\002\255\003\255\000\000\001\000\008\255\
\009\255\000\000\006\255\007\255\012\255\013\255\010\255\011\255\
\016\255\014\255\017\255\018\255\020\255\019\255\021\255\015\255\
\022\255\023\255\024\255\026\255\030\255\000\000\027\255\032\255\
\029\255\255\254\031\255\033\255\000\000\000\000\255\254\255\254\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\012\000\000\000\221\255"

let yytablesize = 266
let yytable = "\035\000\
\003\000\036\000\037\000\041\000\042\000\001\000\008\000\009\000\
\011\000\012\000\013\000\014\000\015\000\016\000\017\000\018\000\
\019\000\026\000\010\000\020\000\023\000\021\000\027\000\024\000\
\022\000\025\000\000\000\028\000\029\000\030\000\031\000\032\000\
\033\000\034\000\000\000\039\000\000\000\040\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\000\005\000"

let yycheck = "\001\001\
\000\000\003\001\004\001\039\000\040\000\001\000\005\001\005\001\
\001\001\001\001\005\001\005\001\001\001\001\001\005\001\005\001\
\001\001\003\001\007\000\006\001\001\001\005\001\001\001\005\001\
\007\001\005\001\255\255\005\001\005\001\004\001\001\001\005\001\
\001\001\005\001\255\255\005\001\255\255\005\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\008\001\009\001"

let yynames_const = "\
  EOL\000\
  EOF\000\
  PTVIRG\000\
  FLECHE\000\
  TIRET\000\
  CALL\000\
  RESPONSE\000\
  "

let yynames_block = "\
  INT\000\
  BIGINT\000\
  STRING\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 15 "v2t2/log_yacc.mly"
          ([])
# 162 "v2t2/log_yacc.ml"
               : Log.log_line list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'log) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Log.log_line list) in
    Obj.repr(
# 16 "v2t2/log_yacc.mly"
             (_1 :: _2)
# 170 "v2t2/log_yacc.ml"
               : Log.log_line list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 14 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 12 : string) in
    let _7 = (Parsing.peek_val __caml_parser_env 10 : string) in
    let _9 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _11 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _13 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _15 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _17 = (Parsing.peek_val __caml_parser_env 0 : 'param) in
    Obj.repr(
# 18 "v2t2/log_yacc.mly"
  ( Log.create_log_call (Log.Const ( _3))  (Log.Const ( _5 )) ( Log.Const _7)  (Log.Const _11) (Log.Const _13) ( Log.Const _9) (Log.Const _15) _17 )
# 184 "v2t2/log_yacc.ml"
               : 'log))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _10 = (Parsing.peek_val __caml_parser_env 2 : string) in
    Obj.repr(
# 19 "v2t2/log_yacc.mly"
                                                                              ((Log.create_log_response  (Log.Const _3)  (Log.Const _5)  (Log.Const _10)))
# 193 "v2t2/log_yacc.ml"
               : 'log))
; (fun __caml_parser_env ->
    Obj.repr(
# 23 "v2t2/log_yacc.mly"
     ([])
# 199 "v2t2/log_yacc.ml"
               : 'param))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'param) in
    Obj.repr(
# 24 "v2t2/log_yacc.mly"
                    ((Log.Const _1)::_3)
# 207 "v2t2/log_yacc.ml"
               : 'param))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'param) in
    Obj.repr(
# 25 "v2t2/log_yacc.mly"
                       ((Log.Const _1)::_3)
# 215 "v2t2/log_yacc.ml"
               : 'param))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Log.log_line list)
