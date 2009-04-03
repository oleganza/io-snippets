#!/usr/bin/env io
# oleganza
# April 3, 2009

# Note: this file does not define Module := Object clone ... to avoid cluttering the namespace.
# You can define your local name using:  Module := doFile("path/to/Module.io")

Object clone do(
  Object := method(self)
  
  if(isLaunchScript,

    A := clone do(
      B := Object clone do(
        c := method(C)
      )
      C := Object clone do(
        b := method(B)
      )
    )

    (A B c == A C) println
    (A C b == A B) println
  )
)
