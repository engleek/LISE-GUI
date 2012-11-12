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

let translate log = ""


