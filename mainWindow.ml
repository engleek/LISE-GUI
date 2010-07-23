open GMain

open FormulaBook
open ActorTree
open LogView
open Dialogs
open Lang

let mainWidth = 700
let mainHeight = 400

class mainWindow ?(show=false) () =
  (* Window *)
  let window = GWindow.window
    ~width:mainWidth
    ~height:mainHeight
    ~position:`CENTER
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

  let spacer2 = GButton.separator_tool_item
    ~packing:(fun w -> toolbar#insert w) () in
  let aboutButton = GButton.tool_button
    ~stock:`ABOUT
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
    
      val mutable formulaName = ""
      val mutable unsaved = false
      
      method window = window
      
      method data_list = formulaBook#data

      method private renew () =
        formulaBook#reset;
        unsaved = true;
        formulaBook#newFormula ~name:"Racine" ~content:""

      method newSet () = 
        if unsaved then
        begin match dialog_confirm () with
          | 1 -> self#renew ()
          | 2 -> ()
          | _ -> ()
        end
        else self#renew ()

      method loadFormula () =
        match dialog_open window () with
          | None -> ()
          | Some f -> print_endline f
            
      method saveFormula () = 
        if formulaName = "" then
          match dialog_save window () with
            | None -> ()
            | Some f -> formulaBook#save f ()
        else print_endline "Already have name, save file"
        
        method print_data () =
          let prt (elem:string) = print_endline elem in
            List.iter prt (formulaBook#data)

        method about () =
          let dialog = GWindow.about_dialog
            ~name:"Analyseur de logs LISE" 
            ~authors:[
              "Valérie Viet Triem Tong";
              "Christopher Humphries"]
            ~copyright:"Copyright: copytruc" () in
              dialog#run (); ()

        method welcome () =
          let dialog = GWindow.dialog
            ~modal:true
            ~position:`CENTER () in
          let welcome = GMisc.label
            ~markup:"<b>Analyseur de log</b>"
            ~packing:(dialog#vbox#pack ~padding:3) () in
            
          let newhbox = GPack.hbox
            ~packing:(dialog#vbox#pack ~padding:3) () in
          let newButton = GButton.button
            ~packing:newhbox#pack () in
          let newimage = GMisc.image
            ~stock:`NEW
            ~icon_size:`DIALOG
            ~packing:newButton#add () in
          let newlabel = GMisc.label
            ~text:"Nouvelle série de formules."
            ~packing:(newhbox#pack ~padding:3) () in
            
          let openhbox = GPack.hbox
            ~packing:(dialog#vbox#pack ~padding:3) () in
          let openButton = GButton.button
            ~packing:openhbox#pack () in
          let openimage = GMisc.image
            ~stock:`OPEN
            ~icon_size:`DIALOG
            ~packing:openButton#add () in
          let openlabel = GMisc.label
            ~text:"Ouvrir une série de formules."
            ~packing:(openhbox#pack ~padding:3) () in
          dialog#vbox#set_spacing 3;
          newButton#connect#clicked ~callback:(fun () -> self#renew (); dialog#destroy ());
          openButton#connect#clicked ~callback:(fun () -> self#loadFormula (); dialog#destroy ());
          dialog#show ();
        
      initializer
        (* Window Sigs *)
        window#connect#destroy
          ~callback:Main.quit;

        (* Button setup *)
        addVPButton#set_icon_widget (addVPIcon)#coerce;
        addFormulaButton#set_icon_widget (addFormulaIcon)#coerce;

        (* Toolbar Sigs *)
        newButton#connect#clicked self#newSet;
        openButton#connect#clicked self#loadFormula;
        saveButton#connect#clicked self#saveFormula;

        aboutButton#connect#clicked ~callback:(fun () -> self#about ());

        addVPButton#connect#clicked ~callback:(fun () -> 
        (match GToolbox.input_string
           "Nom de la nouvelle variable: "
           ~title:"Nouvelle Variable Propositionnelle"
         with
           None -> ()
           | Some name -> formulaBook#newVP ~name ~content:"");
         ());

        addFormulaButton#connect#clicked ~callback:(fun () -> 
        (match GToolbox.input_string
           "Nom de la nouvelle formule: "
           ~title:"Nouvelle Formule"
         with
           None -> ()
           | Some name -> formulaBook#newFormula ~name ~content:"");
         ());

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
        self#welcome();
        (*window#maximize ();*)
    end
