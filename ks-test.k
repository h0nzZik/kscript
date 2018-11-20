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

endmodule

