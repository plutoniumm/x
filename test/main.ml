let rec fib n a b =
  if n <= 0 then []
  else
    let next = a + b in
    if next < 0 then []
    else next :: fib (n - 1) b next

let golden fibs =
  match List.rev fibs with
  | x :: y :: _ -> float_of_int x /. float_of_int y
  | _ -> 0.0

let () =
  if Array.length Sys.argv <> 2 then
    Printf.printf "Usage: %s <integer> <integer>\n" Sys.argv.(0)
  else
    (* first convert str to float to extract first 2 decimals as a,b *)
    let input = abs_float( float_of_string Sys.argv.(1) ) in
    let a = int_of_float (input *. 10.0) mod 10 in
    let b = int_of_float (input *. 100.0) mod 10 in

    let ratio = golden (fib 100 a b) in
    Printf.printf "%f" ratio
