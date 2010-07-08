(* File Open Dialog *)

let all_files () =
  let f = GFile.filter
	~name:"All" () in
  f#add_pattern "*" ;
  f

let formula_filter () = 
  GFile.filter 
    ~name:"Formula files" 
    ~patterns:[ "*.fm" ] ()

let dialog_confirm () =
  GToolbox.question_box
    "Les formules courrantes ne sont pas sauvegardées.\nVraiment tout effacer?"
    ~title:"Vraiment sauvegarder?"
    ~buttons:["Tout effacer";"Annuler"]
    ~default:0
    ~icon:(GMisc.image ~stock:`DIALOG_WARNING ())#coerce

let dialog_open parent () =
  let file = ref None in
  let dialog = GWindow.file_chooser_dialog 
      ~action:`OPEN
      ~title:"Ouvrir"
      ~parent () in
  dialog#add_button_stock `CANCEL `CANCEL ;
  dialog#add_select_button_stock `OPEN `OPEN ;
  dialog#add_filter (formula_filter ()) ;
  dialog#add_filter (all_files ()) ;
  begin match dialog#run () with
  | `OPEN ->
      file := dialog#filename;
  | `DELETE_EVENT | `CANCEL -> ()
  end ;
  dialog#destroy ();
  !file

let dialog_save parent () =
  let file = ref None in
  let dialog = GWindow.file_chooser_dialog 
      ~action:`SAVE
      ~title:"Sauvegarder"
      ~parent () in
  dialog#add_button_stock `CANCEL `CANCEL ;
  dialog#add_select_button_stock `SAVE `SAVE ;
  dialog#add_filter (formula_filter ()) ;
  dialog#add_filter (all_files ()) ;
  begin match dialog#run () with
  | `SAVE ->
      file := dialog#filename;
  | `DELETE_EVENT | `CANCEL -> ()
  end ;
  dialog#destroy ();
  !file
