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
  let addVPButton = GButton.tool_button
    ~packing:(fun w -> toolbar#insert w) () in
  let addFormulaButton = GButton.tool_button
    ~packing:(fun w -> toolbar#insert w) () in

  (* Icons *)
  let addFormulaIcon = GMisc.image
    ~file:"rc/plugin_add.png"
    ~icon_size:`MENU () in
  let addVPIcon = GMisc.image
    ~file:"rc/pill_add.png"
    ~icon_size:`MENU () in

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

    object (self)
    
      val mutable formulaName = None
      
      method window = window
      
      method data_list = formulaBook#data

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
        
      method print_data () =
        let prt (elem:string) = print_endline elem in
          List.iter prt (formulaBook#data)

      initializer
        (* Window Sigs *)
        window#connect#destroy
          ~callback:Main.quit;

        (* Button setup *)
        addVPButton#set_icon_widget (addVPIcon)#coerce;
        addFormulaButton#set_icon_widget (addFormulaIcon)#coerce;

        (* Toolbar Sigs *)
        newButton#connect#clicked ~callback:(fun () -> self#print_data ());
        openButton#connect#clicked self#loadFormula;
        saveButton#connect#clicked self#saveFormula;
        addVPButton#connect#clicked ~callback:(fun () -> formulaBook#newVP ~name:"name" ~content:"name");
        addFormulaButton#connect#clicked ~callback:(fun () -> formulaBook#newFormula ~name:"name" ~content:"name");

        (* Tooltips *)
        tooltips#set_tip ~text:string_new_tooltip newButton#coerce;
        tooltips#set_tip ~text:string_open_tooltip openButton#coerce;
        tooltips#set_tip ~text:string_save_tooltip saveButton#coerce;
        tooltips#set_tip ~text:string_add_formula_tooltip addFormulaButton#coerce;

        (* Customizations *)
        toolbar#set_icon_size `SMALL_TOOLBAR;
        vpaned#set_position (mainHeight - (mainHeight / 3));

        (* Curtains! *)
        if show then window#show ();
        window#maximize ();
    end
