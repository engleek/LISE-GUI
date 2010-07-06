type var = Var of int 
type substitution = (var * string) list

(* le compteur s'utilise pour creer de nouvelles variables lors du calcul des substitutions *)
let compteur = ref 0



let rec  is_a_substitution c = 
  match 
    c 
  with 
      [] -> true 
    |((Var(i), s))::suite -> if (try (List.assoc (Var(i)) suite)=s with _ -> true) then is_a_substitution suite else false

let unif_1 = (Var(1), "toto")::(Var(2),"titi") :: (Var(3),"stroumph")::(Var(4),"pipo")::[]

let test = is_a_substitution unif_1 


let rec construit_unification subst (Var i,s) = 
try ( if (List.assoc (Var(i)) subst) =s then subst else failwith "unification has failed") with Not_found -> ( (Var(i),s)::subst)

(*
let test2 = construit_unification unif_1 (Var(4),"truc") 
let test3 = construit_unification unif_1 (Var(5),"truc")
let test4 = construit_unification unif_1 (Var(4),"pipo")
*)

let unify x y = 
  match 
    (x,y) 
  with 
    | Log.Var(i), Log.Const z  -> [(Var(i),z)]
    |(Log.Const z, Log.Const t  ) -> if  z=t then [] else  failwith "unification not possible"

    | _ -> failwith "unification not possible"


let test5 = unify (Log.Var 2) (Log.Const "toto") 

let unify_one_state stvar st = 
match 
  (stvar, st)
with 
    (Log.Call(s1), Log.Call(s2)) -> (unify s1.Log.call_ident s2.Log.call_ident) @ (unify s1.Log.time_call s2.Log.time_call) @  (unify s1.Log.caller s2.Log.caller) @ (unify s1.Log.service_ident s2.Log.service_ident) @ (unify s1.Log.interface_service s2.Log.interface_service) @ (unify s1.Log.service_supplier s2.Log.service_supplier) @ (unify s1.Log.method_called s2.Log.method_called) @(List.concat (List.map (fun (x,y) -> unify x y) (List.combine s1.Log.parameters s2.Log.parameters)))
  | (Log.Response(s1), Log.Response(s2)) -> unify (s1.Log.response_ident) (s2.Log.response_ident) @ (unify s1.Log.time_response s2.Log.time_response) @ (unify s1.Log.output s2.Log.output) 
  | _ -> failwith "States not unifiable"



let state_appears_in_all stvar kripke  = 
Hashtbl.fold (fun q -> fun lbl -> fun l -> (l@(try [(unify_one_state stvar lbl) ]with _ -> []) ))  (kripke.Kripke.label) []


let state_appears_from stvar kripke i  = 
  let n = (Kripke.number_of_states kripke) in 
if (i>=n) then else 


let seq_appears_in stvarseq kripke =
  let rec aux stvarseq kripke i res = 
    match
      stvarseq
    with 
	[] -> res 
      | stvar::suiteseq -> state_appears_i 


let subst_to_string subst =
  let rec aux subst =
    match 
      subst 
    with 
	[] -> ""
      |(Var(i),s)::suite -> ("\n x_"^(string_of_int i)^(" <- ")^s^";"^(aux suite))
  in aux subst

let rec list_subst_to_string ls =
  let rec aux ls i =
    match 
      ls 
  with 
      [] -> ""
    | subst::suite ->("\n\nSubstitution "^(string_of_int i)^":"^(subst_to_string subst))^(aux suite (i+1))
		      in aux ls 1



