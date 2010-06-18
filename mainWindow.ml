open GMain

open FormulaEditor
open ActorTree
open LogView

let mainWidth = 800
let mainHeight = 600

class mainWindow ?(show=false) () =
  let window = GWindow.window
    ~width:mainWidth
    ~height:mainHeight
    ~title:"ANR LISE - Analyseur de logs" () in
  let vbox = GPack.vbox
    ~packing:window#add () in
  let menubar = GMenu.menu_bar
    ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group in
  let file_menu = factory#add_submenu "Fichier" in
  let toolbar = GButton.toolbar
    ~style:`ICONS
    ~packing:vbox#pack () in
  let openButton = GButton.tool_button
    ~stock:`OPEN
    ~packing:(fun w -> toolbar#insert w) () in
  let vpaned = GPack.paned `VERTICAL
    ~border_width:5
    ~packing:vbox#add () in
  let hpaned = GPack.paned `HORIZONTAL
    ~border_width:5
    ~packing:vpaned#add () in
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
  let formulaEditor = new formulaEditor
    ~packing:hpaned#add2 () in
  let logView = new logView
    ~packing:vpaned#add () in
    object (self)
      method window = window

      initializer
        window#connect#destroy
          ~callback:Main.quit;
        toolbar#set_icon_size `SMALL_TOOLBAR;
        hpaned#set_position (mainWidth / 5);
        vpaned#set_position (mainHeight - (mainHeight / 3));
        treeview#set_rules_hint true;
        treeview#selection#set_mode `MULTIPLE;
        add_columns ~view:treeview ~model;
        treeview#misc#connect#realize ~callback:treeview#expand_all;
        if show then window#show ();
    end
