let _ =
         (* try *)
  (*pour LISE let lexbuf = Lexing.from_channel (open_in "/Users/val/Documents/projets/Lise/traceur/code_ocaml/LISE_logs/logosDir0/events") in
  *)
   let lexbuf = Lexing.from_channel (open_in "/Users/val/Documents/dev/anaLISEeur/LISE-GUI/v2t2/logBlareTEST.txt") in 

 print_string("Ouverture du fichier de log \n") ; 
    flush stdout;
    let result = LogBlareYacc.main LogBlareLex.token lexbuf in
      begin 
	print_string "\n Fin lecture des logs ..\n" ;
	flush stdout 
      end


(*;
	let log=  "/Users/val/Documents/projets/Lise/traceur/code_ocaml/LISE_logs/logosDir0/events"
	and  phi = "DIAMOND(Interface_0)"
in  if Ctl.satifaction_log_from_file log phi then  print_string "\nFormule satisfaite\n" else print_string "\nFormule non satisfaite\n"
      



 let lexbuf= Lexing.from_channel (open_in log)  in
print_string (Log.translate ( (List.nth (Log_yacc.main Log_lex.token lexbuf) 2)))
(* (Ctl.string_to_formula ("(est-un-service) ?\136? (?\151\138( ?\138??\134\146(?\138??\136??\138?))"))*)

	(*	let kripke_log=Kripke.traitement_logs result  
		in 
		let subst_list = Unification.state_appears_in Log.statevar1 kripke_log in 
		  print_string ("\nOn a trouve "); 
		  print_int (List.length subst_list) ; 
		  print_string (" substitution(s) du pattern-etat : \n "^(Log.log_line_to_string Log.statevar1) );
		  
		  print_string (Unification.list_subst_to_string (subst_list)) ;*)
		   
		end
         (* with  _ ->
	    begin
	       print_string "Erreur dans la lecture des logs ..\n" ;
            exit 0
	    end *)



      
(* Utiliser deux table de hachage dans la structure 
une qui associe le label d'un état
une qui associe le/les suivants d'un état 
permettre de trouver les / les suivants dans la structure *)
*)
