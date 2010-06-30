open Tools
open FormulaEditor

class tabWidget () =

  let hbox = GPack.hbox () in

  let validityIcon = GMisc.image
    ~file:"rc/bullet_green.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in

  let label = GMisc.label
    ~text:"Formule"
    ~packing:hbox#add () in
    
    object (self)
      inherit GObj.widget hbox#as_widget
      
      method label () = label
      
      method set_valid valid () =
        if valid
        then validityIcon#set_stock `NO
        else validityIcon#set_stock `NO
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

      (*method newFormula data = 
        notebook#prepend_page ~tab_label:(GMisc.label ~text:"Formule B" ())#coerce (new formulaEditor ())#coerce;*)

      initializer
        ignore (notebook#prepend_page ~tab_label:((new tabWidget ())#coerce) (new formulaEditor ())#coerce);
        (*addImage#connect#clicked (fun () -> print "New Formula Button clicked!");*)
    end
