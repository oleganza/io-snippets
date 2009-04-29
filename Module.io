#!/usr/bin/env io
# oleganza
# April 29, 2009

# This is not actually a library file, but rather an example.

if(isLaunchScript,

  A := clone do(
    B := clone do(
      c := method(C)
    )
    C := clone do(
      b := method(B)
    )
  )

  (A B c == A C) println
  (A C b == A B) println
)

nil
