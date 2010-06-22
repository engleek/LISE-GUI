open StdLabels
open Gobject.Data
open GtkTree

let data_components =
  [ "org.apache.felix.framework", 1;
    "LISE-SAP-SigApp", 1;
  ]

let data_services =
  [ "fr.inria.amazones.lise.app.SigApp", 1;
    "fr.inria.amazones.lise.disp.MobileIOImp", 1;
    "fr.inria.amazones.lise.card.CardImpl", 1;
  ]

let data_providers =
  [ "LISE-SAP-SigApp", 1;
    "LISE-MPP-MobileIO", 1;
    "LISE-SCP-Card", 1;
  ]

let data_interfaces =
  [ "fr.inria.amazones.logos.lisendium.SigAppIfc", 1;
    "fr.inria.amazones.logos.lisendium.MobileIOIfc", 1;
  ]

let data_functions =
  [ "submitDocToUser", 1;
    "sign", 1;
  ]

class actorTree ?packing ?show () =

  (* Layout Widgets *)
  let actorFrame = GBin.frame
    ~label:"Acteurs"
    ~border_width:0
    ?packing () in
  let actorScrolledWindow = GBin.scrolled_window
    ~shadow_type:`ETCHED_IN
    ~hpolicy:`AUTOMATIC
    ~vpolicy:`AUTOMATIC
    ~packing:actorFrame#add () in

  (* Conveniances *)
  let columns = new GTree.column_list in
  let name = columns#add string in
  let count = columns#add int in
  let model = GTree.tree_store in
  let store = model columns in
  let row = store#append () in
  let tree = GTree.view
    ~model:store
    ~packing:actorScrolledWindow#add () in
  let name_col = GTree.view_column
    ~title:"Nom"
    ~renderer:(GTree.cell_renderer_text [], ["text", name]) () in
  let count_col = GTree.view_column
    ~title:"Nombre"
    ~renderer:(GTree.cell_renderer_text [], ["text", count]) () in
  let calls = store#set ~row ~column:name "Appel/Retour" in
  let components = store#set ~row ~column:name "Composant" in
  let services = store#set ~row ~column:name "Service" in
  let providers = store#set ~row ~column:name "Appel/Retour" in
  let interfaces = store#set ~row ~column:name "Fournisseur" in
  let functions = store#set ~row ~column:name "Fonction" in
  object (self)

    method addCall callName () =
      let path = GTree.Path.from_string "0" in
        let modl = tree#model in
          let parent = modl#get_iter path in
            let row = store#append ~parent in
              store#set ~row ~column:name "Testing!";
      
    initializer
      ignore (tree#append_column name_col);
      ignore (tree#append_column count_col);
      self#addCall "Super!"

(*
    initializer
      List.iter data_categories ~f:
        begin fun (category_name, category) ->
          let row = model#append () in
          model#set ~row ~column:name category_name;
        end;
      model
(* Keep an eye on this... *)
let add_columns ~(view : GTree.view) ~model =
  let renderer = GTree.cell_renderer_text [`XALIGN 0.] in
  let column_name = 
    GTree.view_column ~title:"Type" ~renderer:(renderer, ["text", name]) ()
  in
  view#append_column column_name;
  let column_count =
    GTree.view_column ~title:"Nombre" ~renderer:(renderer, ["text", count]) ()
  in
  view#append_column column_count
*)
  end
