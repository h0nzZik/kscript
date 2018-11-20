module KS-CORE-SORTS
     // Only KS-CORE-SYNTAX can define symbols of sort KsTerm
     syntax KsTerm
     // Extension point. Feel free to define symbol of this sort.
     syntax KsFunction
     // Extension point. Feel free to subsort or define symbol.
     syntax KsBasicValue

     syntax KsValue ::= KsBasicValue | KsFunction

endmodule

module KS-CORE-SYNTAX
     imports KS-CORE-SORTS
     imports BOOL
     imports INT
     imports LIST

     syntax Int ::= "Ks.arity" KsFunction [function, klabel(Ks.functionArity)]
     syntax Bool ::= "Ks.isValue" "(" KsTerm  ")" [function, klabel(Ks.isValue)]

     syntax KsTermList ::= List{KsTerm, " "}
     syntax KsTermList ::= "Ks.TermList.from" "(" List ")" [function]
     syntax List ::= "List.from" "(" KsTermList ")" [function]
     syntax Int ::= "Ks.TermList.length" "(" KsTermList ")" [function, klabel(Ks.TermList.length)]

     // Nothing else is KsTerm!
     syntax KsTerm ::= KsValue
                      | "($" KsTermList ")"
                      | KsTerm "|>" KsTerm [left]

     syntax KItem ::= "Ks.apply" KsTermList
endmodule

module KS-CORE
     imports KS-CORE-SYNTAX

     syntax Int ::= "Ks.termArity" KsTerm [function, klabel(Ks.termArity)]
     rule Ks.termArity B:KsBasicValue => 0
     rule Ks.termArity F:KsFunction => Ks.arity F
     rule Ks.termArity ($ F XS) => (Ks.termArity F) -Int Ks.TermList.length(XS)
     rule Ks.termArity (T |> F) => Ks.termArity ($ F T)

     rule Ks.isValue(($ Ts)) => ((Ks.termArity ($ Ts)) >=Int 1)
     rule Ks.isValue(V:KsValue) => true
     rule Ks.isValue(_) => false [owise]

     rule List.from(.KsTermList) => .List
     rule List.from(T Ts) => ListItem(T) List.from(Ts)

     rule Ks.TermList.from(.List) => .KsTermList
     rule Ks.TermList.from(ListItem(T::KsTerm) L::List) => T Ks.TermList.from(L)

     rule Ks.TermList.length(.KsTermList) => 0
     rule Ks.TermList.length(_ XS) => 1 +Int Ks.TermList.length(XS)

     rule (T |> F) => ($ F T)
     rule ($ ((T |> F) => ($ F T)) _)

     rule Ks.apply V:KsBasicValue => V

     rule ($ ($ F Xs ) Y Ys) => ($ ($ F Ks.TermList.from(List.from(Xs) ListItem(Y))) Ys)
          requires (Ks.termArity ($ F Xs)) >=Int 1

     syntax KItem ::= "Ks.frozenApply" "(" KsTermList ")"

     rule ($ F::KsTerm Args::KsTermList) => Ks._apply.eval(F Args)
          requires ((notBool isKsFunction(F)) andBool ((Ks.termArity F) ==Int 0))
                    orBool (isKsFunction(F) andBool ((Ks.termArity ($ F Args)) ==Int 0))

     syntax KItem ::= "Ks._apply.eval" "(" KsTermList ")"

     rule Ks._apply.eval(Xs) => Ks._apply._eval(List.from(Xs), .List)

     syntax KItem ::= "Ks._apply._eval" "(" List "," List ")"
     syntax KItem ::= "Ks._apply._evalFreeze" "(" List "," List ")"

     rule Ks._apply._eval(ListItem(X::KsTerm) Xs, Ys) => X ~> Ks._apply._evalFreeze(Xs, Ys)
     rule Y::KsTerm ~> Ks._apply._evalFreeze(Xs, Ys) => Ks._apply._eval(Xs, Ys ListItem(Y))
          requires Ks.isValue(Y)

     rule Ks._apply._eval(.List, Xs) => Ks._apply.evalDone(Ks.TermList.from(Xs))

     syntax KItem ::= "Ks._apply.evalDone" "(" KsTermList ")"

     rule Ks._apply.evalDone(Ys) => Ks.apply Ys


endmodule

module KS-PRELUDE-SORTS
     imports INT
     imports BOOL

     syntax KsList
     syntax KsBasicValue ::= Int | Bool | KsList
endmodule

module KS-PRELUDE-SYNTAX
     imports KS-PRELUDE-SORTS
     imports KS-CORE-SORTS
     imports LIST
     imports INT
     imports BOOL

     syntax KsBasicValue ::= "Ks.unit"
                            | "Ks.val" KItem

     // A -> A
     syntax KsFunction ::= "Ks.id"
     // A -> List A -> List A
     syntax KsFunction ::= "List.cons"
     // Bool -> A -> List A -> List A
     syntax KsFunction ::= "List.cons?"
     // (A -> B) -> List A -> List B
     syntax KsFunction ::= "List.map"

     // (A -> Bool) -> List A -> List A
     syntax KsFunction ::= "List.filter"

     syntax KsList ::= "{}" [klabel(List.nil)]
                     | "(" KsTerm ":" KsList ")"
                     | "[[" FunCommaList "]]" [function]

     syntax FunCommaList ::= List{KsTerm, ","}

endmodule

module KS-PRELUDE-BASE
     imports KS-CORE-SYNTAX
     imports KS-PRELUDE-SYNTAX
endmodule

module KS-PRELUDE-ID
     imports KS-PRELUDE-BASE

     rule Ks.arity Ks.id => 1
     rule Ks.apply Ks.id T::KsTerm => T
endmodule

module KS-PRELUDE-CONS
     imports KS-PRELUDE-BASE

     rule [[ .FunCommaList ]] => {}
     rule [[ X, Xs ]] => ( X : [[Xs]])

     rule Ks.arity List.cons => 2
     rule Ks.apply List.cons V Vs::KsList => (V : Vs)

     rule Ks.arity List.cons? => 3
     rule Ks.apply List.cons? true::Bool V::KsTerm Vs::KsList => (V : Vs)
     rule Ks.apply List.cons? false::Bool V::KsTerm Vs::KsList => Vs

endmodule

module KS-PRELUDE-MAP
     imports KS-PRELUDE-BASE

     rule Ks.arity List.map => 2

     rule Ks.apply List.map F {}
          => {}

     rule Ks.apply List.map F (X : Xs::KsList)
          => ($ List.cons ($ F X) ($ List.map F Xs))
endmodule

module KS-PRELUDE-FILTER
     imports KS-PRELUDE-BASE

     rule Ks.arity List.filter => 2
     rule Ks.apply List.filter F {}
          => {}

     rule Ks.apply List.filter P (X : Xs::KsList)
          => ($ List.cons? ($ P X) X ($ List.filter P Xs))
endmodule

module KS-PRELUDE
     imports KS-PRELUDE-ID
     imports KS-PRELUDE-CONS
     imports KS-PRELUDE-MAP
     imports KS-PRELUDE-FILTER
endmodule

module KS-SORTS
     imports KS-CORE-SORTS
     imports KS-PRELUDE-SORTS
endmodule

module KS-SYNTAX
     imports KS-CORE-SYNTAX
     imports KS-PRELUDE-SYNTAX
endmodule

module KS
     imports KS-CORE
     imports KS-PRELUDE
endmodule
