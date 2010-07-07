(* le type des variables propositionnelles *)

type var_prop = (*hum mis pour l'exemple, sans doute a améliorer*)  string 

type state_formula = 
    True 
  | False 
  | Neg of state_formula 
  | VP of var_prop 
  | Or of state_formula * state_formula 
  | And of state_formula * state_formula
  | Implies of state_formula * state_formula
  | Equiv of state_formula * state_formula
  | A of walk_formula 
   |E of walk_formula

and 
walk_formula =
 Next of state_formula 
| Diamond of walk_formula 
| Square of walk_formula



let satisfies_vp s phi = true 
let rec satisfies_sf kp s phi =
  match
    phi
  with  
      True -> true 
    | False -> false
    | VP(x) ->  satisfies_vp s phi
    | Neg (psi )-> not (satisfies_sf kp s psi) 
    | Or(psi1, psi2) -> (satisfies_sf kp s psi1) || (satisfies_sf kp s psi2)
    | And(psi1, psi2) -> (satisfies_sf kp s psi1) && (satisfies_sf kp s psi2)
    | Implies(psi1, psi2) ->( (not (satisfies_sf kp s psi1))  || (satisfies_sf kp s psi2))
    | Equiv (psi1, psi2) -> (satisfies_sf kp s (Implies (psi1, psi2))) && (satisfies_sf kp s (Implies( psi2, psi1))) 
  (*  | A(psi) ->
	begin  
	  try 
	    List.for_all (fun x -> satisfies_wf kp x psi) (Kripke.liste_suivants s kp )
	  with
	      Not_found ->  failwith "à voir la def de A dans la relation de satisfaction"
	end
	  
    | E(psi) ->
	begin 
	  try
	    List.exists  (fun x -> satisfies_wf kp x psi) (Kripke.nextstate s kp )
	  with Not_found ->  failwith "à voir la def de E dans la relation de satisfaction"
	end

and  satisfies_wf kp s phi =
  match 
    phi
  with  
    | Next(psi) -> 
	begin 
	  try 
	    List.for_all  (fun x -> satisfies_sf kp x psi) (Kripke.nextstate s kp )
	  with Not_found ->  failwith "à voir la def de NEXT dans la relation de satisfaction"
	end
	  
    |Square (psi ) ->
       begin  
	 let a = (satisfies_wf kp s (Next(psi))) in
	   if not a then false else  (List.forall (fun x-> satisfies_wf kp x (Square psi) ) (Kripke.nextstate s kp))
       end

    |Diamond (psi ) -> 
       begin 
	 let a = (satisfies kp s (Next(psi))) in
	   if  a then true else  (List.exists (fun x-> satisfies_wf kp x (Square psi) ) (Kripke.nextstate s kp))
       e 
  *)
    |_ -> failwith "a virer"
