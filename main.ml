open GMain
open GdkKeysyms
open StdLabels

open Tools

(* Formula editing widget *)
class formula_editor ?packing ?show () = object (self)

  val formula = GText.view ?packing ?show ()

  val mutable filename = None

  method formula = formula

  (* File Loader *)
  method load_file name =
    try
      let b = Buffer.create 1024 in
        with_file name
          ~f:(input_channel b);
        let s = Glib.Convert.locale_to_utf8 (Buffer.contents b) in
          let n_buff = GText.buffer
            ~text:s () in
            formula#set_buffer n_buff;
            filename <- Some name;
            n_buff#place_cursor n_buff#start_iter
    with _ -> prerr_endline "Load failed"

  (* Formula Open Dialog *)
  method open_formula () =
    file_dialog
      ~title:"Ouvrir formule"
      ~callback:self#load_file ()

  (* Formula Save Dialog *)
  method save_dialog () =
    file_dialog ~title:"Save" ?filename
      ~callback:(fun file -> self#output ~file) ()

  (* File Saver *)
  method save_formula () =
    match filename with
      Some file -> self#output ~file
    | None -> self#save_dialog ()

  method output ~file =
    try
      if Sys.file_exists file
      then Sys.rename file (file ^ "~");
      let s = formula#buffer#get_text () in
        let oc = open_out file in
          output_string oc (Glib.Convert.locale_from_utf8 s);
          close_out oc;
          filename <- Some file
    with _ -> prerr_endline "Save failed"
end

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

let file_menu = factory#add_submenu "File"

let hpaned = GPack.paned `HORIZONTAL
  ~border_width:5
  ~packing:vbox#pack ()

(* Actor Model *)
open Gobject.Data

let cols = new GTree.column_list
let col_name = cols#add string	(* string column *)
let col_age = cols#add int	(* int column *)

let create_model () =
  let data = [("Heinz El-Mann", 51); ("Jane Doe", 23); ("Joe Bungop", 91)] in
    let store = GTree.list_store cols in
    let fill (name, age) =
      let iter = store#append () in
        store#set
          ~row:iter
          ~column:col_name name;
        store#set
          ~row:iter
          ~column:col_age age
    in
    List.iter fill data;
    store

(* Actor View *)
let create_view ~model ~packing () =
  let view = GTree.view
    ~model
    ~packing () in

  (* Column #1: col_name is string column *)
  let col = GTree.view_column
    ~title:"Name"
    ~renderer:(GTree.cell_renderer_text [], ["text", col_name]) () in
  ignore (view#append_column col);

  (* Column #2: col_age is int column *)
  let col = GTree.view_column
    ~title:"Age"
    ~renderer:(GTree.cell_renderer_text [], ["text", col_age]) () in
  ignore (view#append_column col);

  view

let formula_editor = new formula_editor
  ~packing:hpaned#add2 ()

let statusbar = GMisc.statusbar
  ~height:20
  ~packing:vbox#add ()
   
(* Build, instanciate, play! *)
let _ =
    window#connect#destroy
        ~callback:Main.quit;

  (* Menus *)
  let factory = new GMenu.factory file_menu
    ~accel_group in
      factory#add_item "Ouvrir..."
        ~key:_O
        ~callback:formula_editor#open_formula;
      factory#add_item "Enregistrer"
        ~key:_S
        ~callback:formula_editor#save_formula;
      factory#add_separator ();
      factory#add_item "Quitter"
        ~key:_Q
        ~callback:window#destroy;

  let model = create_model () in
    create_view ~model ~packing:hpaned#add1 ();

  hpaned#set_position 200;

  window#add_accel_group accel_group;

  window#show ();
  Main.main ()
