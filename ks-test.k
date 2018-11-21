require "ks.k"

module KS-TEST-MAIN
     imports BOOL
     imports INT
     imports KS

     syntax KsFunction ::= "plus"
     rule Ks.arity plus => 2
     rule Ks.apply plus X::Int Y::Int => X +Int Y

     syntax KsFunction ::= "plus3"
     rule Ks.arity plus3 => 3
     rule Ks.apply plus3 X::Int Y::Int Z::Int => (X +Int Y) +Int Z

     syntax KsFunction ::= "isEven"
     rule Ks.arity isEven => 1
     rule Ks.apply isEven X::Int => (X %Int 2) ==Int 0

     configuration
          <k> .K </k>
          <acc> 0 </acc>

     // Int -> Unit
     syntax KsUnaryFunction ::= "acc.add"
     rule <k> Ks.apply acc.add X::Int => Ks.unit ...</k>
          <acc> Y::Int => X +Int Y </acc>

     // Int -> Unit
     syntax KsUnaryFunction ::= "acc.mul"
     rule <k> Ks.apply acc.mul X::Int => Ks.unit ...</k>
          <acc> Y::Int => X *Int Y </acc>

     syntax KsFunction ::= "isOdd"
     rule isOdd => Ks.compose(($ plus 1), isEven) [anywhere]

     syntax Int ::= twice(Int) [function]
     rule twice(X) => 2 *Int X

endmodule

