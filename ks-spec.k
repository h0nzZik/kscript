module KS-SPEC
     imports KS-TEST-MAIN
     imports KS-SYNTAX

     rule <k> Ks.termArity(($ ($ plus3 1) 2 3)) => 0 </k> [specification]

     rule <k> ($ ($ ($ plus3 1) 2) 3) => 6 </k> [specification]


     rule <k> 1 +Int 1 => 2 </k> [specification]

     rule <k> Ks.unit |> Ks.id => Ks.unit </k> [specification]

     rule <k> Ks.unit |> Ks.id |> Ks.id |> Ks.id => Ks.unit </k> [specification]

     rule <k> Ks.TermList.length(Ks.id) => 1 </k> [specification]
     rule <k> Ks.TermList.length(Ks.id Ks.unit) => 2 </k> [specification]


     rule <k> Ks.isValue(($ Ks.id)) => true </k> [specification]
     rule <k> Ks.isValue(($ Ks.id Ks.unit)) => false </k> [specification]


     rule <k> ($ Ks.List.cons 0 {}) => [[0]] </k> [specification]
     rule <k> ($ Ks.List.cons 0 [[1]]) => [[0,1]] </k> [specification]
     rule <k> ($ Ks.List.cons 0 [[1,2]]) => [[0,1,2]] </k> [specification]

     rule <k> ($ Ks.List.cons ($ Ks.id 0) {}) => [[0]] </k> [specification]

     rule <k> ($ Ks.List.cons 0 ($ Ks.id {})) => [[0]] </k> [specification]
     rule <k> ($ Ks.List.cons ($ Ks.id 0) ($ Ks.id {})) => [[0]] </k> [specification]

     rule <k> ($ Ks.id Ks.id) => Ks.id </k> [specification]
     rule <k> ($ ($ Ks.id Ks.id) Ks.unit) => Ks.unit </k> [specification]
     rule <k> ($ ($ Ks.id Ks.id) Ks.id) => Ks.id </k> [specification]

     rule <k> Ks.unit |> ($ Ks.id Ks.id) => Ks.unit </k> [specification]

     rule <k> ($ ($ Ks.id Ks.id) Ks.unit) => Ks.unit </k> [specification]
     rule <k> ($ Ks.List.map Ks.id {}) => {} </k> [specification]

     rule <k> ($ ($ Ks.List.map Ks.id) {}) => {} </k> [specification]

     rule <k> {} |> ($ Ks.List.map Ks.id) => {} </k> [specification]

     rule <k> [[1,2,3]] |> ($ Ks.List.map Ks.id) => [[1,2,3]] </k> [specification]

     rule <k> {} |> ($ Ks.List.map ($ plus 3)) => {} </k> [specification]


     rule <k> ($ Ks.List.cons? ($ Ks.id true) 1 [[2]]) => [[1,2]] </k> [specification]
     rule <k> ($ Ks.List.cons? ($ Ks.id false) 1 [[2]]) => [[2]] </k> [specification]

     rule <k> [[1,2,3,4]] |> ($ Ks.List.filter isEven) => [[2,4]] </k> [specification]

     rule <k> [[1,2,3,4]]
           |> ($ Ks.List.filter isEven)
           => [[2,4]]
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ Ks.List.map ($ plus 3))
           => [[4,5,6,7]]
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ Ks.List.filter isEven)
           |> ($ Ks.List.map ($ plus 3))
           => [[5,7]]
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ Ks.List.map ($ plus 3))
           |> ($ Ks.List.filter isEven)
           => [[4,6]]
          </k>
          [specification]

     rule <k> Ks.List.from(List.from([[1,2,3]]))
           => [[1,2,3]]
          </k>
          [specification]

     //rule <k> List.from(Ks.List.from(ListItem(1) ListItem(2) ListItem(3)))
     //      => ListItem(1) ListItem(2) ListItem(3)
     //     </k>
     //     [specification]

     rule <k> ($ plus 1) ~> Ks.discard => .K </k> [specification]

     rule <k> ($ acc.add 2) </k>
          <acc> 0 </acc>
          =>
          <k> Ks.unit </k>
          <acc> 2 </acc>
          [specification]

     rule <k> ($ Ks.compose(($ plus 1), isEven) 1)
            => true
          </k>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ Ks.List.filter isOdd)
           => [[1,3]]
          </k>
          [specification]

     rule <k> twice(5) => 10 </k>
          [specification]

     rule <k> Ks.arity Ks.fromKLabel(#klabel(`twice`))
           => 1
          </k>
          [specification]

     rule <k> Ks.termArity(($ Ks.fromKLabel(#klabel(`twice`))))
           => 1
          </k>
          [specification]


     // Currently untestable
     /*
     rule <k> Ks.apply Ks.fromKLabel(#klabel(`twice`)) 3
           => 6
          </k>
          <acc> 0 </acc>
          [specification]

     rule <k> ($ Ks.fromKLabel(#klabel(`twice`)) 3)
           => 6
          </k>
          <acc> 0 </acc>
          [specification]

     rule <k> [[1,2,3,4]]
           |> ($ Ks.List.map Ks.fromKLabel(#klabel(`twice`)))
           => [[2,4,6,8]]
          </k>
          <acc> 0 </acc>
          [specification]
     */

endmodule
