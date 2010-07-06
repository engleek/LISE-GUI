let _ =
         (* try *)
            let lexbuf = Lexing.from_channel (open_in "/Users/val/Documents/projets/Lise/traceur/code_ocaml/LISE_logs/logosDir0/events") in
	      print_string("Ouverture du fichier de log \n") ; 
	      flush stdout;
              let result = Log_yacc.main Log_lex.token lexbuf in
		begin 
                print_string (Log.logs_to_string (Log.associe_protagonist result)); print_newline(); 
		print_string "\n Fin lecture des logs ..\n" ;
		flush stdout; 
		let kripke_log=Kripke.traitement_logs result  
		in 
		let subst_list = Unification.state_appears_in Log.statevar1 kripke_log in 
		  print_string ("\nOn a trouve "); 
		  print_int (List.length subst_list) ; 
		  print_string (" substitution(s) du pattern-etat : \n "^(Log.log_line_to_string Log.statevar1) );
		  
		  print_string (Unification.list_subst_to_string (subst_list)) ;
		   
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
