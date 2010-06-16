open GMain
open GdkKeysyms
open StdLabels

open FormulaEditor
open ActorTree

(* Main Widget Declarations *)
let window = GWindow.window
  ~width:500
  ~height:300
  ~title:"ANR LISE - Analyseur de logs" ()

let vbox = GPack.vbox
  ~packing:window#add ()

let menubar = GMenu.menu_bar
  ~packing:vbox#pack ()

let factory = new GMenu.factory menubar

let accel_group = factory#accel_group

let file_menu = factory#add_submenu "Fichier"

let hpaned = GPack.paned `HORIZONTAL
  ~border_width:5
  ~packing:vbox#add ()

(* FormulaEditor *)

let formulaEditor = new formulaEditor
  ~packing:hpaned#add2 ()

(*let statusbar = GMisc.statusbar
  ~height:20
  ~packing:vbox#add ()*)
   
(* Build, instanciate, play! *)
let _ =
  window#connect#destroy
    ~callback:Main.quit;

  (* ActorTree *)

  let actorFrame = GBin.frame
    ~label:"Acteurs"
    ~border_width:0
    ~packing:hpaned#add1() in
      let actorScrolledWindow = GBin.scrolled_window
        ~shadow_type:`ETCHED_IN
        ~hpolicy:`AUTOMATIC
        ~vpolicy:`AUTOMATIC
        ~packing:actorFrame#add () in
          let model = actorModel () in
            let treeview = GTree.view ~model ~packing:actorScrolledWindow#add () in
              treeview#set_rules_hint true;
              treeview#selection#set_mode `MULTIPLE;
              add_columns ~view:treeview ~model;
              treeview#misc#connect#realize ~callback:treeview#expand_all;

  (* Menus *)
  let factory = new GMenu.factory file_menu
    ~accel_group in
      factory#add_item "Ouvrir..."
        ~key:_O
        ~callback:formulaEditor#open_formula;
      factory#add_item "Enregistrer"
        ~key:_S
        ~callback:formulaEditor#save_formula;
      factory#add_separator ();
      factory#add_item "Quitter"
        ~key:_Q
        ~callback:window#destroy;

  hpaned#set_position 200;

  window#add_accel_group accel_group;

  window#show ();
  Main.main ()
