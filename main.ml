open GMain
open GdkKeysyms

let main () =
	let window = GWindow.window
		~title:"ANR LISE - Analyseur de logs" () in
			let vbox = GPack.vbox ~packing:window#add () in
				window#connect#destroy ~callback:Main.quit;

	window#show ();
	Main.main ()
;;

main ()
