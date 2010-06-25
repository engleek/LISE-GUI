open Tools

class formulaBook ?packing ?show () =

  (* Notebook and Tabs *)
  let notebook = GPack.notebook
    ~tab_border:0
    ?packing ?show () in

  (* Adding Tab *)
  let addImage = GButton.tool_button
    ~stock:`ADD () in

    object (self)
      inherit GObj.widget notebook#as_widget

      val mutable current_formula = None
      val mutable formula_list = []

      method notebook = notebook;

      method add = notebook;

      initializer
        ignore (notebook#append_page ~tab_label:addImage#coerce (GMisc.label ~text:"This is an empty page, you shouldn't be seeing it..." ())#coerce);
    end
