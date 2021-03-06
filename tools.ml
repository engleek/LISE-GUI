(* General Tools for the main GUI *)


let input_channel b ic =
  let buf = String.create 1024 and len = ref 0 in
    while len := input ic buf 0 1024; !len > 0 do
      Buffer.add_substring b buf 0 !len
    done

let with_file name ~f =
  let ic = open_in name in
    try f ic;
      close_in ic
    with exn -> close_in ic;
    raise exn
