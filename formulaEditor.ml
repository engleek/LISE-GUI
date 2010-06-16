open Tools

class formulaEditor ?packing ?show () =
  let vbox = GPack.vbox ?packing ?show () in
  let formulaFrame = GBin.frame
    ~label:"Requête"
    ~packing:(vbox#pack ~expand:true ~fill:true) () in
  let translationFrame = GBin.frame
    ~label:"Traduction"
    ~packing:(vbox#pack ~expand:true ~fill:true) () in
  let formulaVBox = GPack.vbox
    ~packing: formulaFrame#add () in
  let formulaToolbar = GButton.toolbar
    ~packing:formulaVBox#pack () in
  let boldButton = GButton.toggle_tool_button ~stock:`BOLD () in
    object (self)
    
      val formula = GText.view
        ~packing:formulaVBox#add ()
        
      val translation = GText.view
        ~packing:translationFrame#add ()

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
    end
