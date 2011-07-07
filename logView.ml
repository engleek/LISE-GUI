open Lang

let all_files () =
  let f = GFile.filter
	~name:"All" () in
  f#add_pattern "*" ;
  f

let log_filter () = 
  GFile.filter 
    ~name:"Log files" 
    ~patterns:[ "*.log" ] ()

let dialog_open_log () =
  let file = ref None in
  let dialog = GWindow.file_chooser_dialog 
    ~action:`OPEN
    ~title:"Ouvrir fichier log" () in
  dialog#add_button_stock `CANCEL `CANCEL ;
  dialog#add_select_button_stock `OPEN `OPEN ;
  dialog#add_filter (log_filter ()) ;
  dialog#add_filter (all_files ()) ;
  begin match dialog#run () with
  | `OPEN ->
      file := dialog#filename;
  | `DELETE_EVENT | `CANCEL -> ()
  end ;
  dialog#destroy ();
  !file      

let create s =
  let lexbuf = Lexing.from_channel (open_in s)  in
    let log_collection = LogBlareYacc.main LogBlareLex.token lexbuf in
      List.map (fun log_elementaire -> (List.fold_left (fun x  y -> x^y^", ") "" log_elementaire, Log.translate log_elementaire)
    ) log_collection

open Gobject.Data

let cols = new GTree.column_list
let orig_col = cols#add Gobject.Data.string 
let trans_col = cols#add Gobject.Data.string

let make_model data =
  let store = GTree.list_store cols in
  List.iter
    (fun (orig, trans) ->
      let row = store#append () in
      store#set ~row ~column:orig_col orig ;
      store#set ~row ~column:trans_col trans)
    data;
  store

class logView ?packing ?show () =

  (* Layout Widgets *)
  let logFrame = GBin.frame
    ?packing ?show
    ~label:"Logs" () in
  let vbox = GPack.vbox
    ~packing:logFrame#add () in
  let hbox = GPack.hbox
    ~packing:(vbox#pack ~fill:true ~expand:false) () in

  (* Toolbar *)
  let toolbar = GButton.toolbar
    ~style:`ICONS
    ~packing:(hbox#pack ~fill:true ~expand:true) () in
  let openButton = GButton.tool_button
    ~stock:`OPEN
    ~packing:(fun w -> toolbar#insert w) () in
  let formulaSpacer = GButton.separator_tool_item
    ~packing:(fun w -> toolbar#insert w) () in
  let logButton = GButton.tool_button
    ~packing:(fun w -> toolbar#insert w) () in

  let scriptRunIcon = GMisc.image
    ~file:"rc/script_go.png"
    ~icon_size:`MENU () in
  let scriptAlertIcon = GMisc.image
    ~file:"rc/script_error.png"
    ~icon_size:`MENU () in
    
  (*let spinStart = GEdit.spin_button
    ~packing:hbox#pack () in
  let spinEnd = GEdit.spin_button
    ~packing:hbox#pack () in*)

  let scrollWin = GBin.scrolled_window
    ~hpolicy:`AUTOMATIC
    ~packing:(vbox#pack ~fill:true ~expand:true) () in

  let logView = GTree.view
    ~packing:scrollWin#add () in

  let colEntryOrig = GTree.view_column ~title:string_original ()
      ~renderer:(GTree.cell_renderer_text[], ["text", orig_col]) in
  let colEntryTrans = GTree.view_column ~title:string_translated ()
      ~renderer:(GTree.cell_renderer_text[], ["text", trans_col]) in
    object (self)

      val mutable logFile = "";

      method logFile = logFile
      
      method connectPlay = logButton#connect#clicked

      method loadLog () =
        match dialog_open_log () with
          | None -> ()
          | Some f -> 
            begin
              logView#set_model (Some (make_model (create f))#coerce);
              logFile <- f
            end
    
      method logError (tf:bool) () =
        if tf
        then ignore(logButton#set_icon_widget (scriptRunIcon)#coerce; GToolbox.message_box "Succès!" "Ce log vérifie la formule.")
        else ignore(logButton#set_icon_widget (scriptAlertIcon)#coerce; GToolbox.message_box "Aille..." "Ce log ne vérifie pas la formule.")
        
    initializer
      logButton#set_icon_widget (scriptRunIcon)#coerce;
    
      logView#set_headers_visible true;
      logView#selection#set_mode `MULTIPLE;
      ignore (logView#append_column colEntryOrig);
      ignore (logView#append_column colEntryTrans);

      toolbar#set_icon_size `SMALL_TOOLBAR;
      ignore(openButton#connect#clicked self#loadLog);
  end
