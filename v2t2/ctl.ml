(* le type des variables propositionnelles *)

type var_prop =  Formula.var_prop
open Formula

type formula = Formula.formula 


let satisfies_vp kp s x =
  try
   Kripke.is_labeled_by kp s x (*Ecrire cette fonction qui doit vérifier que x apparait dans le label de s*) 
  with _ ->failwith "satisfies_vp appelé avec autre chose qu'une variable propositionnelle" 

let rec satisfies (kp:Kripke.kripke) (s:Kripke.state) (phi:formula) =
  match
    phi
  with  
      True -> true 
    | False -> false
    | VP(x) ->  satisfies_vp kp s x
    | Neg (psi )-> not (satisfies kp s psi) 
    | Or(psi1, psi2) -> (satisfies kp s psi1) || (satisfies kp s psi2)
    | And(psi1, psi2) -> (satisfies kp s psi1) && (satisfies kp s psi2)
    | Imply(psi1, psi2) ->( (not (satisfies kp s psi1))  || (satisfies kp s psi2))
    | Equiv (psi1, psi2) -> (satisfies kp s (Imply (psi1, psi2))) && (satisfies kp s (Imply( psi2, psi1))) 
    | A(psi) ->
	begin  
	  try 
List.for_all (fun x -> satisfies kp x psi) (Kripke.nextstate s kp )
	  with
	      Not_found ->  failwith "à voir la def de A dans la relation de satisfaction"
	end
	  
    | E(psi) ->
	begin 
	  try
	    List.exists  (fun x -> satisfies kp x psi) (Kripke.nextstate s kp )
	  with Not_found ->  failwith "à voir la def de E dans la relation de satisfaction"
	end

    | Next(psi) ->
	begin 
	  try 
	    List.for_all  (fun x -> satisfies kp x psi) (Kripke.nextstate s kp )
	  with Not_found ->  failwith "à voir la def de NEXT dans la relation de satisfaction"
	end
	  
    |Square (psi ) ->
       begin  
	 let a = (satisfies kp s (Next(psi))) in
	   if not a then false else  (List.for_all (fun x-> satisfies kp x (Square psi) ) (Kripke.nextstate s kp))
       end

    |Diamond (psi ) -> 
       (satisfies kp s (Next(psi))) || ((List.exists (fun x-> satisfies kp x (Square psi) ) (Kripke.nextstate s kp)))

(*	 let a = (satisfies kp s (Next(psi))) in
	   if  a then true else  (List.exists (fun x-> satisfies kp x (Square psi) ) (Kripke.nextstate s kp))
*)  



(*ATTENTION ECRIRE UNE FONCTION QUI VERIFIE QU'UNE FORMULE DONNEE EST BIEN EN CTL !!!!!!! *)

let need_definition s =

 (true, [VP("A"), VP("B"), Next(Or(VP("C"),False) )])


let make_var (s:string) :var_prop = s

let string_to_formula s =
  let lexbuf=Lexing.from_string s in Formula_yacc.main Formula_lex.token lexbuf 

let rec formula_to_string s =
match 
s
with 
  | True -> " True "
  | False -> " False "  
  | VP(x) ->  x
  | Neg (psi )-> "NOT("^(formula_to_string psi)^")" 
  | Or(p1,p2) -> " ("^(formula_to_string p1) ^" OR "^(formula_to_string p1)^")"
  | And(p1,p2) -> " ("^(formula_to_string p1) ^" AND "^(formula_to_string p2)^")"
  | Equiv(p1,p2) -> " ("^(formula_to_string p1) ^" EQUIV "^(formula_to_string p2)^")"
  | Imply(p1,p2) -> " ("^(formula_to_string p1) ^" IMPLY "^(formula_to_string p2)^")"
  | Next (psi )-> " NEXT ("^(formula_to_string psi)^")" 
 | A (psi )-> "A ("^(formula_to_string psi)^")" 
 | E (psi )-> "E("^(formula_to_string psi)^")" 
 | Diamond (psi )-> "DIAMOND("^(formula_to_string psi)^")" 
 | Square (psi )-> "SQUARE("^(formula_to_string psi)^")" 

(*Vérifie si un log représenté par la chaine de caractère s_log vérifie la formule représenté par la chaine de caractère s_phi *)
let satifaction_log_from_string s_log s_phi =
  let lexbuf= Lexing.from_string s_log  in
  let log_kripke  =Kripke.logs_to_kripke (Log_yacc.main Log_lex.token lexbuf) in
    satisfies (log_kripke) (List.hd (log_kripke.Kripke.init)) (string_to_formula s_phi)

(*Vérifie si un log représenté par LE FICHIER s_log vérifie la formule représenté par la chaine de caractère s_phi *)
let satifaction_log_from_file s_log s_phi =
  let lexbuf= Lexing.from_channel (open_in s_log)  in
  let log_kripke  =Kripke.logs_to_kripke (Log_yacc.main Log_lex.token lexbuf) in
    satisfies (log_kripke) (List.hd (log_kripke.Kripke.init)) (string_to_formula s_phi)


