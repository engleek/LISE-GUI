open Tools
open Dialogs
open FormulaEditor

exception No_editor

class tabWidget (name:string) (isFormula:bool) () =

  let hbox = GPack.hbox () in

  let typeIcon = GMisc.image
    ~file:"rc/pill.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in
    
  let label = GMisc.label
    ~text:name
    ~packing:hbox#add () in

  (*let validityIcon = GMisc.image
    ~file:"rc/bullet_orange.png"
    ~icon_size:`MENU
    ~packing:hbox#add () in*)

    object (self)
      inherit GObj.widget hbox#as_widget
      
      method label () = label
      
      (*method validate () =
        validityIcon#set_file "rc/bullet_green.png"

      method invalidate () =
        validityIcon#set_file "rc/bullet_red.png"*)
      
      initializer
        if isFormula then typeIcon#set_file "rc/plugin.png"
  end

class formulaBook ?packing ?show () =

  (* Notebook and Tabs *)
  let notebook = GPack.notebook
    ?packing ?show () in

    object (self)
      inherit GObj.widget notebook#as_widget

      val mutable current_editor = None
                 
      val mutable vp_list = []
      val mutable formula_list = []
      val mutable editor_list= []
      
      val mutable temp_list = ([] : string list)

      method current_editor () =
        List.nth editor_list (notebook#current_page)
        (*match current_editor with
	        Some c -> c
          | None -> raise No_editor*)

      method notebook = notebook;
      
      method data = 
        (let prep (elem:formulaEditor) = temp_list <- elem#data :: temp_list in
         let app (elem:formulaEditor) = temp_list <- elem#data :: temp_list in
             temp_list = [];
             List.iter prep vp_list;
             List.iter app formula_list); temp_list
      
      method newVP ~name ?(content="") =
        (let label = new tabWidget name false () in
           let editor = new formulaEditor () in
              notebook#prepend_page ~tab_label:label#coerce editor#coerce;
              editor#setName name ();
              editor#formula#buffer#set_text content;
              vp_list <- editor :: vp_list;
              editor_list <- editor :: editor_list;
              current_editor <- Some editor;
              notebook#goto_page 0);
        ()

      method newFormula ~name ?(content="") =
        (let label = new tabWidget name true () in
            let editor = new formulaEditor () in
              notebook#prepend_page ~tab_label:label#coerce editor#coerce;
              editor#setName name ();
              editor#formula#buffer#set_text content;
              formula_list <- editor :: formula_list;
              editor_list <- editor :: editor_list;
              current_editor <- Some editor;
              notebook#goto_page 0);
        ()
        
      method save filename () =
        try
          let oc = open_out filename in
            let writeVP vp =
              begin
                output_string oc "<variable name=\"";
                output_string oc vp#name;
                output_string oc "\">";
                output_string oc "<data>";
                output_string oc vp#data;
                output_string oc "</data>";
                output_string oc "<description>";
                output_string oc "</description>";
                output_string oc "</variable>";
              end in
            let writeFormula formula =
              begin
                output_string oc "<formula name=\"";
                output_string oc formula#name;
                output_string oc "\">";
                output_string oc "<data>";
                output_string oc formula#data;
                output_string oc "</data>";
                output_string oc "<description>";
                output_string oc "</description>";
                output_string oc "</formula>";
              end in
          output_string oc "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>";
          output_string oc "<root>";
          List.iter writeVP vp_list;
          List.iter writeFormula formula_list;
          output_string oc "</root>";
          close_out oc;
        with _ -> prerr_endline "Save failed"
              
      method reset () =
        while notebook#current_page != -1 do
          notebook#remove_page (notebook#current_page)
        done
        
    end
