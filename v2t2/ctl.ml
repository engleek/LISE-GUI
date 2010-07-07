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

