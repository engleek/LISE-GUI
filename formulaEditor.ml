open Tools

class formulaEditor ?packing ?show ?(content="") () =

  (* Layout Widgets *)
  let vbox = GPack.vbox ?packing ?show () in

  (* More Layout Widgets *)
  let formulaVBox = GPack.vbox
    ~packing:(vbox#pack ~expand:false ~fill:true) () in

  (* Formula Toolbar *)
  let formulaToolbar = GButton.toolbar
    ~style:`BOTH
    ~packing:(formulaVBox#pack ~expand:false ~fill:true) () in

  (* Divide into two sections *)
  let hpaned = GPack.paned `HORIZONTAL
    ~border_width:5
    ~packing:(vbox#pack ~expand:true ~fill:true) () in
    
  (* Formula Scrollbar *)
  let scrolledWindow = GBin.scrolled_window
    ~shadow_type:`ETCHED_IN
    ~hpolicy:`NEVER
    ~vpolicy:`AUTOMATIC
    ~packing:(hpaned#pack1 ~shrink:true ~resize:true) () in

  (* Formula Text Box *)
  let formula = GSourceView2.source_view
    ~auto_indent:true
    ~tab_width:2
    ~insert_spaces_instead_of_tabs:true
    ~show_line_numbers:true
    ~show_right_margin:true
    ~right_margin_position:80
    ~smart_home_end:`ALWAYS
    ~height:300
    ~width:600
    ~packing:scrolledWindow#add () in
  let language_manager = GSourceView2.source_language_manager
    ~default:true in
  let lang =
    match language_manager#guess_language
      ~content_type:"text/x-ocaml" () with
      | None -> failwith "no language for text/x-ocaml"
      | Some lang -> lang in

  (* Translation *)
  let translationFrame = GBin.frame
    ~label:"Traduction"
    ~packing:(hpaned#pack2 ~shrink:true ~resize:true) () in
  let translation = GMisc.label
    ~text:"Traduction de la requête en langage naturel ici."
    ~width:200
    ~height:80
    ~packing:translationFrame#add () in

  (* Toolbar Buttons *)
  let trueButton = formulaToolbar#insert_button
    ~text:"⊤"
    ~tooltip:"Vrai"
    ~callback:(fun () -> formula#buffer#insert "TRUE") () in
  let trueButton = formulaToolbar#insert_button
    ~text:"⊥"
    ~tooltip:"Faux"
    ~callback:(fun () -> formula#buffer#insert "FALSE") () in
  let squareButton = formulaToolbar#insert_button
    ~text:"□"
    ~tooltip:"Vrai dans tous les états prochains"
    ~callback:(fun () -> formula#buffer#insert "SQUARE") () in
  let lozengeButton = formulaToolbar#insert_button
    ~text:"◊"
    ~tooltip:"Vrai dans au moins un des états prochains"
    ~callback:(fun () -> formula#buffer#insert "DIAMOND") () in
  let spacer1 = formulaToolbar#insert_space () in
  let notButton = formulaToolbar#insert_button
    ~text:"¬"
    ~tooltip:"Négation"
    ~callback:(fun () -> formula#buffer#insert "NOT") () in
  let andButton = formulaToolbar#insert_button
    ~text:"∧"
    ~tooltip:"Et"
    ~callback:(fun () -> formula#buffer#insert "AND") () in
  let orButton = formulaToolbar#insert_button
    ~text:"∨"
    ~tooltip:"Ou"
    ~callback:(fun () -> formula#buffer#insert "OR") () in
  let rarrowButton = formulaToolbar#insert_button
    ~text:"→"
    ~tooltip:"Implique"
    ~callback:(fun () -> formula#buffer#insert "IMPLY") () in
  let rarrowButton = formulaToolbar#insert_button
    ~text:"⇔"
    ~tooltip:"Equivalent"
    ~callback:(fun () -> formula#buffer#insert "EQUIV") () in    
  let spacer2 = formulaToolbar#insert_space () in
  let rarrowButton = formulaToolbar#insert_button
    ~text:"A"
    ~tooltip:"Tout les chemins"
    ~callback:(fun () -> formula#buffer#insert "A") () in    
  let rarrowButton = formulaToolbar#insert_button
    ~text:"E"
    ~tooltip:"Il existe un chemin"
    ~callback:(fun () -> formula#buffer#insert "E") () in    
  let rarrowButton = formulaToolbar#insert_button
    ~text:"X"
    ~tooltip:"Chemin suivant"
    ~callback:(fun () -> formula#buffer#insert "NEXT") () in    
    object (self)
      inherit GObj.widget vbox#as_widget
      
      val mutable name = ""
            
      method name = name
      
      method setName str () = name <- str
            
      method setTranslation str () = translation#set_label str

      method formula = formula
      
      method data = formula#buffer#get_text ()
      
      (*method showValid = label#validate
      
      method showInvalid = label#invalidate*)
      
      initializer

        formula#source_buffer#set_highlight_matching_brackets true;
        formula#set_show_line_marks true;
        formula#source_buffer#set_text content;

        formula#source_buffer#set_language (Some lang);
        formula#source_buffer#set_highlight_syntax true;
        
    end
