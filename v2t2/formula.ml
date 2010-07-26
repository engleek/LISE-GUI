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





