#!/usr/bin/env io

function := method(
  call message
)

member := function(elem, lst,
  match(lst,
    list() -> false,
    list(elem, *tail) -> true,
    list(_, *tail) -> tailCall(elem, tail)
  )
)

message(a -> b) next println

member(0, list()) println
member(1, list(1,2,3)) println
member(2, list(1,2,3)) println
member(3, list(1,2,3)) println
member(4, list(1,2,3)) println
