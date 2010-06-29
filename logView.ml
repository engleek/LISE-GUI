
let rawLogs = [
  "c;1;4616686408;2;4;4;3;0;ser_0;";
  "c;2;4620299367;4;1;5;0;1;ser_1;";
  "r;2;8532827286;<-;ser_2;";
  "c;3;8533162524;4;3;6;2;0;ser_3;123;";
  "r;3;8533302626;<-;ser_4;";
  "c;4;8533425337;4;1;5;0;1;ser_5;";
  "r;4;12738414453;<-;ser_6;";
  "c;5;12738629983;4;3;6;2;0;ser_7;1234;";
  "r;5;12738844256;<-;ser_8;";
  "r;1;12738963196;<-;true;";
  "c;6;15010081589;2;4;4;3;0;ser_9;";
  "c;7;15010270301;4;1;5;0;1;ser_10;";
  "r;7;21016999996;<-;ser_11;";
  "c;8;21019733444;4;1;5;0;1;ser_12;";
  "r;8;28524514917;<-;ser_13;";
  "c;9;28524783178;4;1;5;0;1;ser_14;";
  "r;9;32128165730;<-;ser_15;";
  "r;6;32128425680;<-;false;"
]

let humanLogs = [
"1: Method call at 4616686408: 
   org.apache.felix.framework uses service fr.inria.amazones.lise.app.SigApp provided by LISE-SAP-SigApp throught interface fr.inria.amazones.logos.lisendium.SigAppIfc
   Service user calls function boolean submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";
"2: Method call at 4620299367: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
   Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";

"2' : Method respond at 8532827286:         
      \"123\"";

"3: Method call at 8533162524: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.card.CardImpl provided by LISE-SCP-Card throught interface fr.inria.amazones.logos.lisendium.CardIfc
   Service user calls function java.lang.String sign(java.lang.String,int) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"
      123";

"3' : Method respond at 8533302626:         
      \"\"";

"4: Method call at 8533425337: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
   Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";

"4' : Method respond at 12738414453:         
      \"1234\"";

"5: Method call at 12738629983: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.card.CardImpl provided by LISE-SCP-Card throught interface fr.inria.amazones.logos.lisendium.CardIfc
   Service user calls function java.lang.String sign(java.lang.String,int) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"
      1234";

"5' : Method respond at 12738844256:         
      \"To buy this pen at 10$ enter your PID below. (with private key=\"privateKey\" and public key = \"publicKey\")\"";

"1' : Method respond at 12738963196:         
      true";

"6: Method call at 15010081589: 
   org.apache.felix.framework uses service fr.inria.amazones.lise.app.SigApp provided by LISE-SAP-SigApp throught interface fr.inria.amazones.logos.lisendium.SigAppIfc
   Service user calls function boolean submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";

"7: Method call at 15010270301: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
   Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";

"7' : Method respond at 21016999996:         
      \"azer\"";

"8: Method call at 21019733444: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
   Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";

"8' : Method respond at 28524514917:         
      \"zerty\"";

"9: Method call at 28524783178: 
   LISE-SAP-SigApp uses service fr.inria.amazones.lise.disp.MobileIOImpl provided by LISE-MPP-MobileIO throught interface fr.inria.amazones.logos.lisendium.MobileIOIfc
   Service user calls function java.lang.String submitDocToUser(java.lang.String) with folowing parameter(s):
      \"To buy this pen at 10$ enter your PID below.\"";

"9' : Method respond at 32128165730:         
      \"erty\"";

"6' : Method respond at 32128425680:         
      false";
]

open Gobject.Data

let columns = new GTree.column_list
let entry = columns#add string

let createOrigModel () =
  let storeOrig = GTree.tree_store columns in
      let addEntry entryDat = storeOrig#set ~row:(storeOrig#append ()) ~column:entry entryDat in
        List.iter addEntry rawLogs;
        storeOrig

let createTransModel () =
  let storeTrans = GTree.tree_store columns in
      let addEntry entryDat = storeTrans#set ~row:(storeTrans#append ()) ~column:entry entryDat in
        List.iter addEntry humanLogs;
        storeTrans

class logView ?packing ?show () =

  (* Layout Widgets *)
  let logFrame = GBin.frame
    ?packing ?show
    ~label:"Logs" () in
  let hbox = GPack.hbox
    ~packing:logFrame#add () in

  let modelOrig = createOrigModel () in
  let modelTrans = createTransModel () in

  (* Notebook and Tabs *)
  let notebook = GPack.notebook
    ~packing:hbox#add () in
  let scrollbar = GRange.scrollbar `VERTICAL
    ~packing:hbox#pack () in
  let logOrig = GTree.view
    ~model:modelOrig
    ~vadjustment:scrollbar#adjustment
    ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(GMisc.label ~text:"Original" ())#coerce w)) () in
  let logTrans = GTree.view
    ~model:modelTrans
    ~vadjustment:scrollbar#adjustment
    ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(GMisc.label ~text:"Traduction" ())#coerce w)) () in

  let colEntryOrig = GTree.view_column ~title:"Entry" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",entry]) in
  let colEntryTrans = GTree.view_column ~title:"Entry" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",entry]) in
    object (self)

      method setData data () =
        let storeOrig = GTree.tree_store columns in
        let storeTrans = GTree.tree_store columns in
          let addEntries =
            begin fun (orig, trad) ->
              storeOrig#set ~row:(storeOrig#append ()) ~column:entry orig;
              storeTrans#set ~row:(storeTrans#append ()) ~column:entry trad
            end;
          in
          List.iter addEntries data;

    
    initializer
      logOrig#set_headers_visible false;
      ignore (logOrig#append_column colEntryOrig);
      logTrans#set_headers_visible false;
      ignore (logTrans#append_column colEntryTrans);
  end
