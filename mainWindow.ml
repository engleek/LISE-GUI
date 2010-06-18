open GMain

open FormulaEditor
open ActorTree
open LogView

let mainWidth = 800
let mainHeight = 600

class mainWindow ?(show=false) () =
  (* Window *)
  let window = GWindow.window
    ~width:mainWidth
    ~height:mainHeight
    ~title:"ANR LISE - Analyseur de logs" () in

  (* Main Layout Widget *)
  let vbox = GPack.vbox
    ~packing:window#add () in

  (* Toolbar *)
  let toolbar = GButton.toolbar
    ~style:`ICONS
    ~packing:vbox#pack () in
  let newButton = GButton.tool_button
    ~stock:`NEW
    ~packing:(fun w -> toolbar#insert w) () in
  let openButton = GButton.tool_button
    ~stock:`OPEN
    ~packing:(fun w -> toolbar#insert w) () in
  let saveButton = GButton.tool_button
    ~stock:`SAVE
    ~packing:(fun w -> toolbar#insert w) () in

  (* More Layout Widgets! *)
  let vpaned = GPack.paned `VERTICAL
    ~border_width:5
    ~packing:vbox#add () in
  let hpaned = GPack.paned `HORIZONTAL
    ~border_width:5
    ~packing:vpaned#add () in

  (* Actor Tree Widgets *)
  let actorTree = new actorTree
    ~packing:hpaned#add1 () in

  (* Formula Editor *)
  let formulaEditor = new formulaEditor
    ~packing:hpaned#add2 () in

  (* Log View *)
  let logView = new logView
    ~packing:vpaned#add () in

    object (self)
      method window = window

      initializer
        (* Window Sigs *)
        window#connect#destroy
          ~callback:Main.quit;

        (* Toolbar Sigs *)
        newButton#connect#clicked (fun () -> print_endline "NewButton");
        openButton#connect#clicked (fun () -> formulaEditor#open_formula());
        saveButton#connect#clicked (fun () -> formulaEditor#save_formula());

        (* Customizations *)
        toolbar#set_icon_size `SMALL_TOOLBAR;
        hpaned#set_position (mainWidth / 5);
        vpaned#set_position (mainHeight - (mainHeight / 3));

        (* Tree View: MOVEME *)
(*        treeview#set_rules_hint true;
        treeview#selection#set_mode `MULTIPLE;
        add_columns ~view:treeview ~model;
        treeview#misc#connect#realize ~callback:treeview#expand_all;
*)
        (* Curtains! *)
        if show then window#show ();
    end
