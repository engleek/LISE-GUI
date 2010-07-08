(* le type des variables propositionnelles *)

type var_prop =  string 


type formula = 
    True 
  | False 
  | Neg of formula 
  | VP of var_prop 
  | Or of formula * formula 
  | And of formula * formula
  | Implies of formula * formula
  | Equiv of formula * formula
  | A of formula 
   |E of formula
   | Next of formula 
| Diamond of formula 
| Square of formula





let satisfies_vp s phi = true 


let rec satisfies (kp:Kripke.kripke) (s:Kripke.state) phi =
  match
    phi
  with  
      True -> true 
    | False -> false
    | VP(x) ->  satisfies_vp s phi
    | Neg (psi )-> not (satisfies kp s psi) 
    | Or(psi1, psi2) -> (satisfies kp s psi1) || (satisfies kp s psi2)
    | And(psi1, psi2) -> (satisfies kp s psi1) && (satisfies kp s psi2)
    | Implies(psi1, psi2) ->( (not (satisfies kp s psi1))  || (satisfies kp s psi2))
    | Equiv (psi1, psi2) -> (satisfies kp s (Implies (psi1, psi2))) && (satisfies kp s (Implies( psi2, psi1))) 
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
       begin 
	 let a = (satisfies kp s (Next(psi))) in
	   if  a then true else  (List.exists (fun x-> satisfies kp x (Square psi) ) (Kripke.nextstate s kp))
     end



(*ATTENTION ECRIRE UNE FONCTION QUI VERIFIE QU'UNE FORMULE DONNEE EST BIEN EN CTL !!!!!!! *)
