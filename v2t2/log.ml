type log_elem = string list
type log_collection = log_elem list

(* ajouté pour les logs Blare *)

let rec list_tag_to_string (l:string list) =  
List.fold_left (fun x y ->( x^" "^(y)^" ")) "" l

let make_log  x1 x2 x3 x4 x5 x6 x7 x8 =
["TS_"^x1;"source_type_"^x2;"source_name_"^x3; "Id_Source_"^x4;"destination_type_"^x5;"destination_name_"^x6; "Id_"^x7;"tags_involved_"^(list_tag_to_string x8) ]

let make_nom nom =
  match 
    nom 
  with 
      p::[] -> p
    |p::t::[] ->  p^"_:thread_"^t
    |_ -> failwith "erreur de parsing"
(* fin ajout *)


(* version Lise *)
let make_call  x1 x2 x3 x4 x5 x6 x7 x8 =
["call";"call_ident_"^x1;"Caller_"^x3; "Service_"^x4;"Interface_"^x5; "Provider_"^x6;"Function_"^x7 ]@x8

let make_response x1 x2 x3 =
["response";"response_ident_"^x1;"Output_"^x3 ]

let log_elem_to_string l = List.fold_left (fun x y -> x^" "^y^";") "\n" l

let log_collection_to_string (l:log_collection) =  
List.fold_left (fun x y ->( x^" "^(log_elem_to_string y)^" ")) "\n" l

let translate log = "toto"
(*
  let translate_call log =
("Appel de service Numero "^(let x = (List.nth log 1) in (String.sub x 11 ((String.length x)-11 )))^
", \n l'appelant est "^(let x = (List.nth log 2) in (String.sub x 7 ((String.length x)-7 )))^
", \n le service appele est "^(let x = (List.nth log 3) in (String.sub x 8 ((String.length x)-8 )))^
", \n en utilisant de l'interface "^(let x = (List.nth log 4) in (String.sub x 10 ((String.length x)-10 )))^
", \n fournit par "^(let x = (List.nth log 5) in (String.sub x 9 ((String.length x)-9 )))^
", \n la fonction appelee est "^(let x = (List.nth log 6) in (String.sub x 9 ((String.length x)-9 )))^
", \n avec les parametres "^(List.nth log 7)^"\n"

)


  in 
  let translate_response log =
("Reponse a l'appel de service Numero "^(let x = (List.nth log 1) in (String.sub x 15 ((String.length x)-15 )))^
"\n avec la sortie "^(let x = (List.nth log 2) in (String.sub x 7 ((String.length x)-7 )))
)

  in 
    match
      List.hd log
    with 
    "call" -> translate_call log
      |"response"-> translate_response log 
      | _ -> failwith "Format de Log innattendu"

*) 
(*fin version Lise *)



(*

type parametre_de_log = Const of string | Var of int  



type log_line_call = 
{ call_ident : parametre_de_log ; 
  time_call: parametre_de_log   ;
  caller :  parametre_de_log  ;

  service_ident :  parametre_de_log  ; 
  interface_service :  parametre_de_log  ; 
  service_supplier : parametre_de_log  ; 
  method_called : parametre_de_log  ; 
  parameters:  parametre_de_log list  ; 
 }

type log_line_response = 
{
response_ident : parametre_de_log ;  
time_response: parametre_de_log  ; 
output: parametre_de_log  ; 
}

type log_line = Call of log_line_call | Response of log_line_response
type logs = log_line list  


let param_to_string p =
  match 
    p 
  with 
      Var(i) -> "x_"^(string_of_int  i) 
| Const(s) -> s



let create_log_response x1 x2 x3 =
Response({
response_ident =x1 ; 
time_response =x2 ; 
output =x3;
})


let create_log_call x1 x2 x3 x4 x5 x6 x7 x8 =
Call ({call_ident=x1 ; 
 time_call =x2 ;
  caller =x3;
  service_ident =x4; 
  interface_service =x5 ; 
  service_supplier =x6 ; 
  method_called =x7 ; 
  parameters =x8 ; 
})

let rec  list_to_string l =
if l==[] then "" else (param_to_string (List.hd l))^", "^(list_to_string (List.tl l))

let log_line_to_string l = 
match 
    l 
  with 
      Call(c) ->("\n\nCall number  "^ (param_to_string c.call_ident)^ " at "^(param_to_string  c.time_call)^" ns"^
		   ":\n the service user_id (the caller) is " ^
		   (param_to_string c.caller) ^
		   "\n the service called is "^
		   ( param_to_string c.service_ident) ^
		   ("\n using interface ")^
		   (param_to_string  c.interface_service)^
		   ("\n the service supplier is ")^
		   ( param_to_string c.service_supplier)^
		   ("\n the method called is ")^
		   (param_to_string c.method_called)^
		    ("\n with parameters ")^
		   (list_to_string c.parameters)
)

    | Response (r) ->  ("\n\nResponse "^ (param_to_string r.response_ident)^
		        " at "^(param_to_string r.time_response)^" ns"^
		       "\n output "^
			(param_to_string r.output)
			^"\n"
		       )


let rec logs_to_string l =
match 
l 
with 
[] -> "."
  |log::ll -> (log_line_to_string log) ^(logs_to_string ll )


let change_caller log c =
match 
  log
with
  |Call(l) ->Call ({call_ident= l.call_ident ; 
						 time_call =l.time_call ;
						 caller =c;
						 service_ident =l.service_ident; 
						 interface_service =l.interface_service ; 
						 service_supplier =l.service_supplier ; 
						 method_called =l.method_called ; 
						 parameters =l.parameters ; 
						})
  |Response(_) -> failwith "non fait dans change caller"

let change_supplier log s =
match 
  log 
with
  |Call(l) ->Call ({call_ident= l.call_ident ; 
						 time_call =l.time_call ;
						 caller =l.caller;
						 service_ident =l.service_ident; 
						 interface_service =l.interface_service ; 
						 service_supplier =s; 
						 method_called =l.method_called ; 
						 parameters =l.parameters ; 
						})
  |Response(_) -> failwith "non fait dans change supplier"


let change_service log s =
match 
  log 
with
  |Call(l) ->Call ({call_ident= l.call_ident ; 
						 time_call =l.time_call ;
						 caller =l.caller;
						 service_ident =s; 
						 interface_service =l.interface_service ; 
						 service_supplier =l.service_supplier; 
						 method_called =l.method_called ; 
						 parameters =l.parameters ; 
						})
  |Response(_) -> failwith "non fait dans change service (pas besoin normalement :-))"




let lire_services fich = 
   let lexbuf = Lexing.from_channel (open_in fich) in
       print_string "fichier ouvert \n" ;
     Services_yacc.main Services_lex.token lexbuf 

let associe_services logs fich = 
  let rec aux2 l ls =
    match 
      (l.service_ident,ls) 
    with
	(_,[] ) -> failwith "Service not found"
      | (Const c, (i1,i2,s, i3, i4, i6)::lls ) ->   if (try (i1 = int_of_string c) with _ -> false) then Const(s) else (aux2 l lls)
      | _ -> failwith "cas non prévu"
  in 
let rec aux logs ls =
    match 
      logs 
    with 
	[] -> []
      | Call(l)::suite -> (change_service (Call(l)) (aux2 l ls)) :: (aux suite ls)
      |Response(r)::suite ->(Response(r))::(aux suite ls) 
  in 
  let liste_services =  lire_services "/Users/val/Documents/projets/Lise/traceur/code_ocaml/LISE_logs/logosDir0/serviceObjects_info"  
in aux logs liste_services


let associe_protagonist logs = 
  let rec cherche_un_protagoniste caller liste_prota =
    match 
      (caller, liste_prota) 
    with 
	(_,[]) -> failwith "Protagonist not found"
      | (Const c,(x,y,s1,s2)::suite_prota) -> if ( c=string_of_int x) then  (Const s1) else  cherche_un_protagoniste (Const c) suite_prota
      | (_,_) -> failwith "Cas non prévu" 
  in

   let lexbuf = Lexing.from_channel (open_in "/Users/val/Documents/projets/Lise/traceur/code_ocaml/LISE_logs/logosDir0/protagonists_info") in
     begin 
       print_string "fichier ouvert \n" ;
   let liste_prota =   Protagonists_yacc.main Protagonists_lex.token lexbuf in


   let rec remplace_tous_protagonistes logs liste_prota =
     match 
       logs
     with 
	 [] -> []
       | (Call(log))::suite -> 
	   (change_supplier 
	      (change_caller (Call(log)) (cherche_un_protagoniste log.caller liste_prota)) 
	      ((cherche_un_protagoniste log.service_supplier  liste_prota)))
	   ::(remplace_tous_protagonistes suite liste_prota)
       | (Response(log))::suite ->((Response(log)))::(remplace_tous_protagonistes suite liste_prota)
   in 
     remplace_tous_protagonistes logs liste_prota  
  
     end
 


let statevar1 = create_log_call (Var 1) (Var 2) (Var 9 ) (Var 3) (Var 4) (Var 5) (Var 7) [Var(8)]


*)
