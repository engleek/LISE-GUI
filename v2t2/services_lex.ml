# 1 "services_lex.mll"
 
 open Services_yacc


# 7 "services_lex.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\091\000\192\000\252\255\253\255\254\255\255\255\027\001\
    ";
  Lexing.lex_backtrk = 
   "\004\000\005\000\004\000\255\255\255\255\255\255\255\255\000\000\
    ";
  Lexing.lex_default = 
   "\255\255\255\255\255\255\000\000\000\000\000\000\000\000\255\255\
    ";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\006\000\005\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \007\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\001\000\001\000\001\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\001\000\003\000\000\000\000\000\000\000\000\000\
    \000\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\000\000\000\000\000\000\000\000\001\000\
    \000\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\000\000\000\000\
    \000\000\000\000\001\000\000\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\001\000\001\000\001\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\001\000\000\000\000\000\000\000\000\000\000\000\
    \004\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\000\000\000\000\000\000\000\000\001\000\
    \000\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\000\000\000\000\
    \000\000\000\000\001\000\000\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\000\000\000\000\
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
    \000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\255\255\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\001\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\255\255\255\255\
    \255\255\255\255\001\000\255\255\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \002\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\255\255\255\255\255\255\255\255\255\255\
    \000\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\255\255\255\255\255\255\255\255\002\000\
    \255\255\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\007\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\255\255\255\255\
    \255\255\255\255\007\000\255\255\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\255\255\255\255\
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
    \255\255\255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 9 "services_lex.mll"
                 ( token lexbuf )
# 177 "services_lex.ml"

  | 1 ->
# 10 "services_lex.mll"
                   ( EOL )
# 182 "services_lex.ml"

  | 2 ->
# 11 "services_lex.mll"
                   ( EOF)
# 187 "services_lex.ml"

  | 3 ->
# 12 "services_lex.mll"
         (PTVIRG)
# 192 "services_lex.ml"

  | 4 ->
let
# 13 "services_lex.mll"
                     lxm
# 198 "services_lex.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 13 "services_lex.mll"
                          ( INT (int_of_string lxm))
# 202 "services_lex.ml"

  | 5 ->
let
# 14 "services_lex.mll"
                                                                            lxm
# 208 "services_lex.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 14 "services_lex.mll"
                                                                                 ( STRING (lxm))
# 212 "services_lex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;

