module KS-SPEC
     imports KS-TEST-MAIN
     imports KS-SYNTAX

     rule <k> Ks.termArity ($ ($ plus3 1) 2 3) => 0 </k> [specification]

     rule <k> ($ ($ ($ plus3 1) 2) 3) => 6 </k> [specification]


     rule <k> 1 +Int 1 => 2 </k> [specification]

     rule <k> Ks.unit |> Ks.id => Ks.unit </k> [specification]

     rule <k> Ks.unit |> Ks.id |> Ks.id |> Ks.id => Ks.unit </k> [specification]

     rule <k> Ks.TermList.length(Ks.id) => 1 </k> [specification]
     rule <k> Ks.TermList.length(Ks.id Ks.unit) => 2 </k> [specification]


     rule <k> Ks.isValue(($ Ks.id)) => true </k> [specification]
     rule <k> Ks.isValue(($ Ks.id Ks.unit)) => false </k> [specification]


     rule <k> ($ List.cons 0 {}) => [[0]] </k> [specification]
     rule <k> ($ List.cons 0 [[1]]) => [[0,1]] </k> [specification]
     rule <k> ($ List.cons 0 [[1,2]]) => [[0,1,2]] </k> [specification]

     rule <k> ($ List.cons ($ Ks.id 0) {}) => [[0]] </k> [specification]

     rule <k> ($ List.cons 0 ($ Ks.id {})) => [[0]] </k> [specification]
     rule <k> ($ List.cons ($ Ks.id 0) ($ Ks.id {})) => [[0]] </k> [specification]

     rule <k> ($ Ks.id Ks.id) => Ks.id </k> [specification]
     rule <k> ($ ($ Ks.id Ks.id) Ks.unit) => Ks.unit </k> [specification]
     rule <k> ($ ($ Ks.id Ks.id) Ks.id) => Ks.id </k> [specification]

     rule <k> Ks.unit |> ($ Ks.id Ks.id) => Ks.unit </k> [specification]

     rule <k> ($ ($ Ks.id Ks.id) Ks.unit) => Ks.unit </k> [specification]
     rule <k> ($ List.map Ks.id {}) => {} </k> [specification]

     rule <k> ($ ($ List.map Ks.id) {}) => {} </k> [specification]

     rule <k> {} |> ($ List.map Ks.id) => {} </k> [specification]

     rule <k> [[1,2,3]] |> ($ List.map Ks.id) => [[1,2,3]] </k> [specification]

     rule <k> {} |> ($ List.map ($ plus 3)) => {} </k> [specification]


     rule <k> ($ List.cons? ($ Ks.id true) 1 [[2]]) => [[1,2]] </k> [specification]
     rule <k> ($ List.cons? ($ Ks.id false) 1 [[2]]) => [[2]] </k> [specification]

     rule <k> [[1,2,3,4]] |> ($ List.filter isEven) => [[2,4]] </k> [specification]

     rule <k> [[1,2,3,4]]
           |> ($ List.filter isEven)
           => [[2,4]]
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ List.map ($ plus 3))
           => [[4,5,6,7]]
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ List.filter isEven)
           |> ($ List.map ($ plus 3))
           => [[5,7]]
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ List.map ($ plus 3))
           |> ($ List.filter isEven)
           => [[4,6]]
          </k>
          [specification]

     rule <k> Ks.List.from(List.from([[1,2,3]]))
           => [[1,2,3]]
          </k>
          [specification]

     rule <k> List.from(Ks.List.from(ListItem(1) ListItem(2) ListItem(3)))
           => ListItem(1) ListItem(2) ListItem(3)
          </k>
          [specification]

endmodule
