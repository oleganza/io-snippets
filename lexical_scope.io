#!/usr/bin/env io
# oleganza 
# July, 1 2008

Module := Object clone do(
  module := method(
    mod := self clone
    mod doMessage(call message argAt(0))
    mod
  )
)

A := Module module(
  B := module(
    slot := 42
    meth := method(x,
      C meth(x)
    )
  )
  C := module(
    meth := method(x,
      x * B slot
    )
  )
)

if(isLaunchScript,
  (A C clone meth(2) == 84) println
  (A B clone meth(2) == 84) println
)