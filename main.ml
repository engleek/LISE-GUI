open GMain
open GdkKeysyms
open StdLabels

open MainWindow

(* Build, instanciate, play! *)
let _ =
  Main.init ();
  ignore (new mainWindow ~show:true ());
  Main.main ()
