require "ks.k"

module KS-TEST-MAIN-SYNTAX
     imports KS-SYNTAX

     syntax KsFunction ::= "plus"
endmodule

module KS-TEST-MAIN
     imports KS-TEST-MAIN-SYNTAX // self

     imports BOOL
     imports INT
     imports KS

     rule Ks.arity plus => 2
     rule Ks.apply plus X::Int Y::Int => X +Int Y

     syntax KsFunction ::= "plus3"
     rule Ks.arity plus3 => 3
     rule Ks.apply plus3 X::Int Y::Int Z::Int => (X +Int Y) +Int Z

     syntax KsFunction ::= "isEven"
     rule Ks.arity isEven => 1
     rule Ks.apply isEven X::Int => (X %Int 2) ==Int 0

     configuration
          <k> $PGM:K </k>
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
     rule isOdd => Ks.compose($(plus 1), isEven) [anywhere]

     syntax Int ::= twice(Int) [function]
     rule twice(X) => 2 *Int X

endmodule

