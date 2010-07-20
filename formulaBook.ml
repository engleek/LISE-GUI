open Tools
open Dialogs
open FormulaEditor

class tabWidget (name:string) (isFormula:bool) () =

  let hbox = GPack.hbox () in

  let typeIcon = GMisc.image
    ~file:"rc/pill.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in
    
  let label = GMisc.label
    ~text:name
    ~packing:hbox#add () in

  let validityIcon = GMisc.image
    ~file:"rc/bullet_green.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in

    object (self)
      inherit GObj.widget hbox#as_widget
      
      method label () = label
      
      initializer
        if isFormula then typeIcon#set_file "rc/plugin.png"
  end

class formulaBook ?packing ?show () =

  (* Notebook and Tabs *)
  let notebook = GPack.notebook
    ?packing ?show () in

    object (self)
      inherit GObj.widget notebook#as_widget

      val mutable current_formula = None
      val mutable vp_list = []
      val mutable formula_list = []
      
      val mutable temp_list = ([] : string list)

      method notebook = notebook;
      
      method data = 
        (let prep (elem:formulaEditor) = temp_list <- elem#data :: temp_list in
         let app (elem:formulaEditor) = temp_list <- elem#data :: temp_list in
             List.iter prep vp_list;
             List.iter app formula_list); temp_list
      
      method newVP ~name ?(content="") =
        (let label = new tabWidget name false () in
           let editor = new formulaEditor () in
              notebook#prepend_page ~tab_label:label#coerce editor#coerce;
              vp_list <- editor :: vp_list);
        ()

      method newFormula ~name ?(content="") =
        (let label = new tabWidget name true () in
            let editor = new formulaEditor () in
              notebook#prepend_page ~tab_label:label#coerce editor#coerce;
              formula_list <- editor :: formula_list);
        ()

    end
