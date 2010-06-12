open GMain
open GdkKeysyms
open StdLabels

(* File opening dialog *)
let file_dialog ~title ~callback ?filename () =
  let sel = GWindow.file_selection
    ~title
    ~modal: true ?filename () in
        sel#cancel_button#connect#clicked ~callback:sel#destroy;
        sel#ok_button#connect#clicked ~callback:
        begin fun () ->
            let name = sel#filename in
                sel#destroy ();
                callback name
        end;
    sel#show ()

(* Main GUI functions *)
class gui ?packing ?show () = object (self)

    val text = GBroken.text
        ~editable: true ?packing ?show ()

    val mutable filename = None

    (* text getter *)
    method text = text

    (* file loader *)
    method load_file name =
        try
            let ic = open_in name in
                filename <- Some name;
                text#freeze ();
                text#delete_text
                    ~start: 0
                    ~stop: text#length;
                let buf = String.create 1024 and len = ref 0 in
                    while len := input ic buf 0 1024; !len > 0
                    do
                        if !len = 1024
                        then text#insert buf
                        else text#insert (String.sub buf ~pos:0 ~len:!len)
                    done;
                    text#set_point 0;
                    text#thaw ();
                close_in ic
        with _ -> ()

    (* File Open Dialog *)
    method open_file () = file_dialog
        ~title: "Open"
        ~callback: self#load_file ()

    (* File Save Dialog *)
    method save_dialog () = file_dialog
        ~title:"Save" ?filename
        ~callback:(fun file -> self#output ~file) ()

    (* File Saver *)
    method save_file () =
        match filename with
            Some file -> self#output
                ~file
            | None -> self#save_dialog ()

    method output ~file =
    try
        if Sys.file_exists file
        then Sys.rename file (file ^ "~");
        let oc = open_out file in
            output_string oc (text#get_chars ~start:0 ~stop:text#length);
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


(* Build, instanciate, play! *)
let _ =
    window#connect#destroy
        ~callback:Main.quit;

    (* Menus *)
    let factory = new GMenu.factory file_menu
        ~accel_group in
            factory#add_item "Ouvrir..."
                ~key:_O;
            factory#add_item "Enregistrer"
                ~key:_S;
            factory#add_item "Enregistrer sous...";
            factory#add_separator ();
            factory#add_item "Quitter"
                ~key:_Q
                ~callback:window#destroy;

    window#add_accel_group accel_group;

    window#show ();
    Main.main ()
