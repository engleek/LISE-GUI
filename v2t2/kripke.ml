type state = Q of int 

type kripke = {states_list  : state list ; init : state list ; transitions : (state,state list) Hashtbl.t ; label : (state ,Log.log_line ) Hashtbl.t }



let nextstate s kripke =
Hashtbl.find  kripke.transitions s

let number_of_state kripke = List.length (kripke.states_list)

let create_kripke x1 x2 x3 x4 = 
{states_list = x1 ; 
init = x2 ; 
transitions =x3 ; 
label =x4}


let state_to_string q = let Q(x)=q in " Q("^(string_of_int x)^") "

let label_of_a_state q l=
Hashtbl.find q l
 
let rec states_list_to_string stl =
match 
stl 
with 
[] -> ".\n"
|Q(x):: stll -> " Q("^(string_of_int x)^"),\n "^(states_list_to_string stll)



let rec states_with_label_list_to_string stl label =
Hashtbl.fold  (fun q -> fun lbl -> fun s -> (s^("\n--\n "^(state_to_string q)^"with label "^(Log.log_line_to_string(lbl))^"\n" )))  label ""


let rec transitions_to_string trans  = 
Hashtbl.fold  (fun q -> fun ql -> fun s -> (s^"-- \n\n"^(List.fold_right (fun qs ->fun ss -> (ss^(" "^(state_to_string q)^" -> "^(state_to_string (qs))^"\n" ))) ql "")))  trans ""



let kripke_to_string k =
("\n Initial states: \n"^
   (states_list_to_string k.init)^
   "\n States: \n"^
   (states_with_label_list_to_string k.states_list k.label)^
   "\n Transitions: \n"^
   transitions_to_string k.transitions
)

let logs_to_kripke logs  = 
  let rec logs_to_kripke_aux logs state_l init_l  trans label_l i = 
    match 
      logs 
    with 
	[] -> create_kripke state_l [Q(0)] trans label_l
      | c ::llogs -> logs_to_kripke_aux llogs (if i>0 then (Q(i)::state_l) else (state_l) ) init_l ((if i>0 then Hashtbl.add trans (Q(i-1)) [(Q(i))] else ()); trans) ( Hashtbl.add  label_l (Q(i)) c ; label_l) (i+1)
   
      
  in logs_to_kripke_aux logs [] [] (Hashtbl.create (List.length logs)) (Hashtbl.create (List.length logs)) 0




let traitement_logs logs =
  let kripke_ex = logs_to_kripke  ((Log.associe_protagonist  logs))
  in 
    begin
      print_string (kripke_to_string( kripke_ex)); 
      kripke_ex
    end

let is_labeled_by kp s x = true (*  !!!!!!!!!!!!!!!!!  *)
