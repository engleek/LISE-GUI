class logView ?packing ?show () =

  (* Layout Widgets *)
  let logFrame = GBin.frame
    ?packing ?show
    ~label:"Logs" () in
  let hbox = GPack.hbox
    ~packing:logFrame#add () in

  (* Stores and Vars *)
  let cols = new GTree.column_list in
  let cols_content = cols#add Gobject.Data.string in
  let logstore = GTree.list_store cols in

  (* Notebook and Tabs *)
  let notebook = GPack.notebook
    ~packing:hbox#add () in
  let scrollbar = GRange.scrollbar `VERTICAL
    ~packing:hbox#pack () in
  let logOrig = GTree.view
    ~vadjustment:scrollbar#adjustment
    ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(GMisc.label ~text:"Original" ())#coerce w)) () in
  let logTrans = GTree.view
    ~vadjustment:scrollbar#adjustment
    ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(GMisc.label ~text:"Traduction" ())#coerce w)) () in

    object (self)
      
      initializer
        ignore(logstore#append ());
    end
