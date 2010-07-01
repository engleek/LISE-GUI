open Tools

class formulaEditor ?packing ?show ?(content="") () =

  (* Layout Widgets *)
  let vbox = GPack.vbox ?packing ?show () in

  (* More Layout Widgets *)
  let formulaVBox = GPack.vbox
    ~packing:(vbox#pack ~expand:true ~fill:true) () in

  (* Formula Toolbar *)
  let formulaToolbar = GButton.toolbar
    ~style:`BOTH
    ~packing:formulaVBox#pack () in

  (* Formula Scrollbar *)
  let scrolledWindow = GBin.scrolled_window
    ~shadow_type:`ETCHED_IN
    ~hpolicy:`NEVER
    ~vpolicy:`AUTOMATIC
    ~packing:formulaVBox#add () in

  (* Formula Text Box *)
  let formula = GSourceView2.source_view
    ~auto_indent:true
    ~tab_width:2
    ~insert_spaces_instead_of_tabs:true
    ~show_line_numbers:true
    ~show_right_margin:true
    ~right_margin_position:80
    ~smart_home_end:`ALWAYS
    ~packing:scrolledWindow#add
    ~height:300 () in
  let language_manager = GSourceView2.source_language_manager
    ~default:true in
  let lang =
    match language_manager#guess_language
      ~content_type:"text/x-ocaml" () with
      | None -> failwith "no language for text/x-ocaml"
      | Some lang -> lang in

  (* Translation Label *)
  let translation = GMisc.label
    ~text:"Traduction de la requête en langage naturel ici."
    ~packing:(vbox#pack ~expand:true ~fill:true)
    ~height:80 () in

  (* Toolbar Buttons *)
  let trueButton = formulaToolbar#insert_button
    ~text:"⊤"
    ~tooltip:"Vrai"
    ~callback:(fun () -> formula#buffer#insert "⊤") () in
  let trueButton = formulaToolbar#insert_button
    ~text:"⊥"
    ~tooltip:"Faux"
    ~callback:(fun () -> formula#buffer#insert "⊥") () in
  let squareButton = formulaToolbar#insert_button
    ~text:"□"
    ~tooltip:"Vrai dans tous les états prochains"
    ~callback:(fun () -> formula#buffer#insert "□") () in
  let lozengeButton = formulaToolbar#insert_button
    ~text:"◊"
    ~tooltip:"Vrai dans au moins un des états prochains"
    ~callback:(fun () -> formula#buffer#insert "◊") () in
  let spacer1 = formulaToolbar#insert_space () in
  let notButton = formulaToolbar#insert_button
    ~text:"¬"
    ~tooltip:"Négation"
    ~callback:(fun () -> formula#buffer#insert "¬") () in
  let andButton = formulaToolbar#insert_button
    ~text:"∧"
    ~tooltip:"Et"
    ~callback:(fun () -> formula#buffer#insert "∧") () in
  let orButton = formulaToolbar#insert_button
    ~text:"∨"
    ~tooltip:"Ou"
    ~callback:(fun () -> formula#buffer#insert "∨") () in
  let rarrowButton = formulaToolbar#insert_button
    ~text:"→"
    ~tooltip:"Implique"
    ~callback:(fun () -> formula#buffer#insert "→") () in
  let rarrowButton = formulaToolbar#insert_button
    ~text:"⇔"
    ~tooltip:"Equivalent"
    ~callback:(fun () -> formula#buffer#insert "⇔") () in    
    object (self)
      inherit GObj.widget vbox#as_widget
      
      val mutable filename = None

      method formula = formula
      
      initializer

        formula#source_buffer#set_highlight_matching_brackets true;
        formula#set_show_line_marks true;
        formula#source_buffer#set_text content;

        formula#source_buffer#set_language (Some lang);
        formula#source_buffer#set_highlight_syntax true;
    end
