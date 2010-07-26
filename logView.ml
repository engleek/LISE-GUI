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


let logs = [
  "c;1;4616686408;2;4;4;3;0;ser_0;",
  "1: Method call at 4616686408: 
     org.apache.felix.framework uses service fr.inria.amazones.lise.app.SigApp provided by LISE-SAP-SigApp throught interface fr.inria.amazones.logos.lisendium.SigAppIfc
     Service user calls function boolean submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "c;2;4620299367;4;1;5;0;1;ser_1;",
  "2: Method call at 4620299367: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
     Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "r;2;8532827286;<-;ser_2;",
  "2' : Method respond at 8532827286:         
        \"123\"";

  "c;3;8533162524;4;3;6;2;0;ser_3;123;",
  "3: Method call at 8533162524: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.card.CardImpl provided by LISE-SCP-Card throught interface fr.inria.amazones.logos.lisendium.CardIfc
     Service user calls function java.lang.String sign(java.lang.String,int) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"
        123";

  "r;3;8533302626;<-;ser_4;",
  "3' : Method respond at 8533302626:         
        \"\"";

  "c;4;8533425337;4;1;5;0;1;ser_5;",
  "4: Method call at 8533425337: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
     Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "r;4;12738414453;<-;ser_6;",
  "4' : Method respond at 12738414453:         
        \"1234\"";

  "c;5;12738629983;4;3;6;2;0;ser_7;1234;",
  "5: Method call at 12738629983: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.card.CardImpl provided by LISE-SCP-Card throught interface fr.inria.amazones.logos.lisendium.CardIfc
     Service user calls function java.lang.String sign(java.lang.String,int) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"
        1234";

  "r;5;12738844256;<-;ser_8;",
  "5' : Method respond at 12738844256:         
        \"To buy this pen at 10$ enter your PID below. (with private key=\"privateKey\" and public key = \"publicKey\")\"";

  "r;1;12738963196;<-;true;",
  "1' : Method respond at 12738963196:         
        true";

  "c;6;15010081589;2;4;4;3;0;ser_9;",
  "6: Method call at 15010081589: 
     org.apache.felix.framework uses service fr.inria.amazones.lise.app.SigApp provided by LISE-SAP-SigApp throught interface fr.inria.amazones.logos.lisendium.SigAppIfc
     Service user calls function boolean submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "c;7;15010270301;4;1;5;0;1;ser_10;",
  "7: Method call at 15010270301: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
     Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "r;7;21016999996;<-;ser_11;",
  "7' : Method respond at 21016999996:         
        \"azer\"";

  "c;8;21019733444;4;1;5;0;1;ser_12;",
  "8: Method call at 21019733444: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
     Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "r;8;28524514917;<-;ser_13;",
  "8' : Method respond at 28524514917:         
        \"zerty\"";

  "c;9;28524783178;4;1;5;0;1;ser_14;",
  "9: Method call at 28524783178: 
     LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
     Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
        \"To buy this pen at 10$ enter your PID below.\"";

  "r;9;32128165730;<-;ser_15;",
  "9' : Method respond at 32128165730:         
        \"erty\"";

  "r;6;32128425680;<-;false;",
  "6' : Method respond at 32128425680:         
        false";
]

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

  let model = make_model logs in

  (* Toolbar *)
  let toolbar = GButton.toolbar
    ~style:`ICONS
    ~packing:(hbox#pack ~fill:true ~expand:true) () in
  let openButton = GButton.tool_button
    ~stock:`OPEN
    ~packing:(fun w -> toolbar#insert w) () in
  let formulaSpacer = GButton.separator_tool_item
    ~packing:(fun w -> toolbar#insert w) () in
  let runButton = GButton.tool_button
    ~stock:`MEDIA_PLAY
    ~packing:(fun w -> toolbar#insert w) () in
    
  let spinStart = GEdit.spin_button
    ~packing:hbox#pack () in
  let spinEnd = GEdit.spin_button
    ~packing:hbox#pack () in

  let scrollWin = GBin.scrolled_window
    ~hpolicy:`AUTOMATIC
    ~packing:(vbox#pack ~fill:true ~expand:true) () in

  let logView = GTree.view
    ~model
    ~packing:scrollWin#add () in

  let colEntryOrig = GTree.view_column ~title:string_original ()
      ~renderer:(GTree.cell_renderer_text[], ["text", orig_col]) in
  let colEntryTrans = GTree.view_column ~title:string_translated ()
      ~renderer:(GTree.cell_renderer_text[], ["text", trans_col]) in
    object (self)

      method loadLog () =
        match dialog_open_log () with
          | None -> ()
          | Some f -> 
            begin
              print_endline f
            end
        
    initializer
      logView#set_headers_visible true;
      logView#selection#set_mode `MULTIPLE;
      ignore (logView#append_column colEntryOrig);
      ignore (logView#append_column colEntryTrans);

      toolbar#set_icon_size `SMALL_TOOLBAR;
      ignore(openButton#connect#clicked self#loadLog);
      (*runButton#connect#clicked ~callback:self#runCurrentFormula;*)
      (*logView#destroy ();*)
      (*scrollWin#destroy ();*)
  end
  
  (* "Nom de la nouvelle formule: " *)
