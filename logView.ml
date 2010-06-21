class logView ?packing ?show () =

  (* Layout Widgets *)
  let logFrame = GBin.frame
    ?packing ?show
    ~label:"Logs" () in
  let hbox = GPack.hbox
    ~packing:logFrame#add () in

  (* Notebook and Tabs *)
  let notebook = GPack.notebook
    ~packing:hbox#add () in
  let label1 = GMisc.label
    ~text:"Version originale ici."
    (* ~vadjustment:scrollbar#adjustment  *)
    ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(GMisc.label ~text:"Original" ())#coerce w)) () in
  let label1 = GMisc.label
    ~text:"Version en langage naturel ici." 
    (* ~vadjustment:scrollbar#adjustment  *)
    ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(GMisc.label ~text:"Traduction" ())#coerce w)) () in

  (* Scrolling *)
  let scrollbar = GRange.scrollbar `VERTICAL
    ~packing:hbox#pack () in

    object (self)
      
    end
