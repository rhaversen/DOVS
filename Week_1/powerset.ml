let rec powerset s = function
  | [] -> [[]]
  | head :: tail ->
    let tail_powerset = powerset tail in
    tail_powerset @ List.map (fun x -> head :: x) tail_powerset