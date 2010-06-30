open GMain

open FormulaEditor
open FormulaBook
open ActorTree
open LogView
open Lang

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
    
  (* General Toolbar Buttons *)
  let newButton = GButton.tool_button
    ~stock:`NEW
    ~packing:(fun w -> toolbar#insert w) () in
  let openButton = GButton.tool_button
    ~stock:`OPEN
    ~packing:(fun w -> toolbar#insert w) () in
  let saveButton = GButton.tool_button
    ~stock:`SAVE
    ~packing:(fun w -> toolbar#insert w) () in

  (* Formula General Toolbar Buttons *)
  let formulaSpacer = GButton.separator_tool_item
    ~packing:(fun w -> toolbar#insert w) () in
  let newFormulaButton = GButton.tool_button
    ~stock:`ADD
    ~packing:(fun w -> toolbar#insert w) () in

  (* More Layout Widgets! *)
  let vpaned = GPack.paned `VERTICAL
    ~border_width:5
    ~packing:vbox#add () in

  (* Formula Book *)
  let formulaBook = new formulaBook
    ~packing:vpaned#add1
    ~show:true () in

  (* Log View *)
  let logView = new logView
    ~packing:vpaned#add2 () in

  let tab = new tabWidget () in

  let ed = new formulaEditor () in
    object (self)
      method window = window

      initializer
        (* Window Sigs *)
        window#connect#destroy
          ~callback:Main.quit;

        (* Toolbar Sigs *)
        (* newButton#connect#clicked (fun () -> print_endline "NewButton");
        openButton#connect#clicked (fun () -> formulaEditor#open_formula());
        saveButton#connect#clicked (fun () -> formulaEditor#save_formula()); *)

        (* Customizations *)
        toolbar#set_icon_size `SMALL_TOOLBAR;
        vpaned#set_position (mainHeight - (mainHeight / 3));

        formulaBook#notebook#prepend_page ~tab_label:(tab)#coerce (new formulaEditor ())#coerce;
        formulaBook#notebook#goto_page 0;

        tab#set_valid false;

        (* Curtains! *)
        if show then window#show ();
        window#maximize ();
    end
