open GMain

open FormulaEditor
open FormulaBook
open ActorTree
open LogView
open Dialogs
open Lang

let mainWidth = 800
let mainHeight = 600

class mainWindow ?(show=false) () =
  (* Window *)
  let window = GWindow.window
    ~width:mainWidth
    ~height:mainHeight
    ~title:string_title () in

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

  (* Tooltips *)
  let tooltips = GData.tooltips () in

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

    object (self)
    
      val mutable formulaName = None
      
      method window = window

      method newFormula () = 
        if formulaName = None then
        match dialog_confirm () with
        | 1 -> ()
        | 2 -> ()
        | _ -> ()

      method loadFormula () =
        match dialog_open window () with
          | None -> ()
          | Some f -> print_endline f
            
      method saveFormula () = 
        if formulaName = None then
          match dialog_save window () with
            | None -> ()
            | Some f -> print_endline "Save file"
        else print_endline "Already have name, save file"

      initializer
        (* Window Sigs *)
        window#connect#destroy
          ~callback:Main.quit;

        (* Toolbar Sigs *)
        newButton#connect#clicked self#newFormula;
        openButton#connect#clicked self#loadFormula;
        saveButton#connect#clicked self#saveFormula;

        (* Tooltips *)
        tooltips#set_tip ~text:string_new_tooltip newButton#coerce;
        tooltips#set_tip ~text:string_open_tooltip openButton#coerce;
        tooltips#set_tip ~text:string_save_tooltip saveButton#coerce;
        tooltips#set_tip ~text:string_add_formula_tooltip newFormulaButton#coerce;

        (* Customizations *)
        toolbar#set_icon_size `SMALL_TOOLBAR;
        vpaned#set_position (mainHeight - (mainHeight / 3));

        tab#set_valid false;

        (* Curtains! *)
        if show then window#show ();
        window#maximize ();
    end
