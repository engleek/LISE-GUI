open Tools

class formulaEditor ?packing ?show () =

  (* Layout Widgets *)
  let vbox = GPack.vbox ?packing ?show () in

  (* Frames *)
  let formulaFrame = GBin.frame
    ~label:"Requête"
    ~packing:(vbox#pack ~expand:true ~fill:true) () in
  let translationFrame = GBin.frame
    ~label:"Traduction"
    ~packing:(vbox#pack ~expand:true ~fill:true) () in

  (* More Layout Widgets *)
  let formulaVBox = GPack.vbox
    ~packing: formulaFrame#add () in

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
  (* let formula = GText.view
    ~packing:scrolledWindow#add () in *)
  let formula = GSourceView2.source_view
    ~auto_indent:true
    ~tab_width:2
    ~insert_spaces_instead_of_tabs:true
    ~show_line_numbers:true
    ~show_right_margin:true
    ~right_margin_position:30
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
    ~packing:translationFrame#add () in

  (* Toolbar Buttons *)
  let chiButton = formulaToolbar#insert_button
    ~text:"Χ"
    ~tooltip:"Chi"
    ~callback:(fun () -> formula#buffer#insert "Χ") () in
  let phiButton = formulaToolbar#insert_button
    ~text:"Φ"
    ~tooltip:"Phi"
    ~callback:(fun () -> formula#buffer#insert "Φ") () in
  let psiButton = formulaToolbar#insert_button
    ~text:"Ψ"
    ~tooltip:"Psi"
    ~callback:(fun () -> formula#buffer#insert "Ψ") () in
  let spacer1 = formulaToolbar#insert_space () in
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
  let tautButton = formulaToolbar#insert_button
    ~text:"⊨"
    ~tooltip:"Tautologie"
    ~callback:(fun () -> formula#buffer#insert "⊨") () in
  let rarrowButton = formulaToolbar#insert_button
    ~text:"→"
    ~tooltip:"Implique"
    ~callback:(fun () -> formula#buffer#insert "→") () in
    
    object (self)
            
      val mutable filename = None

      method formula = formula
      
      (* File Loader *)
      method load_file name =
        try
          let b = Buffer.create 1024 in
            with_file name
              ~f:(input_channel b);
            let s = Glib.Convert.locale_to_utf8 (Buffer.contents b) in
              let n_buff = GText.buffer
                ~text:s () in
                formula#set_buffer n_buff;
                filename <- Some name;
                n_buff#place_cursor n_buff#start_iter
        with _ -> prerr_endline "Load failed"

      (* Formula Open Dialog *)
      method open_formula () =
        file_dialog
          ~title:"Ouvrir formule"
          ~callback:self#load_file ()

      (* Formula Save Dialog *)
      method save_dialog () =
        file_dialog ~title:"Save" ?filename
          ~callback:(fun file -> self#output ~file) ()

      (* File Saver *)
      method save_formula () =
        match filename with
          Some file -> self#output ~file
        | None -> self#save_dialog ()

      method output ~file =
        try
          if Sys.file_exists file
          then Sys.rename file (file ^ "~");
          let s = formula#buffer#get_text () in
            let oc = open_out file in
              output_string oc (Glib.Convert.locale_from_utf8 s);
              close_out oc;
              filename <- Some file
        with _ -> prerr_endline "Save failed"

      initializer

        formula#source_buffer#set_highlight_matching_brackets true;
        (*formula#source_buffer#set_bracket_match_style (GSourceView2.source_tag_style ~background:`GRAY) *)
        formula#set_show_line_marks true;

        formula#source_buffer#set_language (Some lang);
        formula#source_buffer#set_highlight_syntax true;
    end
