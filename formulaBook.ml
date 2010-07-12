open Tools
open FormulaEditor

class tabWidget (name:string) (isFormula:bool) () =

  let hbox = GPack.hbox () in

  let label = GMisc.label
    ~text:name
    ~packing:hbox#add () in

  let typeIcon = GMisc.image
    ~file:"rc/pill.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in

  (*let validityIcon = GMisc.image
    ~file:"rc/bullet_green.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in*)
    
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
      val mutable formula_list = []

      method notebook = notebook;

      method newVP ?(name="var inconnue") ?(content="") =
        (let label = new tabWidget name false () in
            let editor = new formulaEditor () in
                notebook#prepend_page ~tab_label:label#coerce editor#coerce);
        ()

      method newFormula ?(name="formule inconnue") ?(content="") =
        (let label = new tabWidget name true () in
            let editor = new formulaEditor () in
                notebook#prepend_page ~tab_label:label#coerce editor#coerce);
        ()

    end
