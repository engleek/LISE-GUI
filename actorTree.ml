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

let data_categories =
  [ "Composants", data_components;
    "Services", data_services;
    "Fournisseurs", data_providers;
    "Interfaces", data_interfaces;
    "Fonctions", data_functions;
  ]

let cols = new GTree.column_list
let name = cols#add string
let count = cols#add int

let actorModel () =
  let model = GTree.tree_store cols in
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
