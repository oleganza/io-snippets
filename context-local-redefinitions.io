#!/usr/bin/env io
/*

"abc"  -> String

String -> [Object, Plugins]
Plugins 

*/

A := Object clone do(
  self localExtend(String,
    myMethod := method(
      self .. " from A"
    )
  ) 
)

B := Object clone do(
  self localExtend(String,
    myMethod := method(
      self .. " from B"
    )
  )
)



MyClass := Object clone do(
  meth := method(1)
  val := 1
)

Namespace := Object clone do(
  new := method(call delegateToMethod(clone, "do"))
  override := method(mod,
    "overriding #{mod}" interpolate println
  )
)

MyModule := Namespace new(
  
  override(MyClass, 
    meth = method(2)
  )
  
)

MyModule slotNames println
MyModule type println

/*
n := 100*1000
(n/Date secondsToRun(n repeat(MyClass meth))) println
(n/Date secondsToRun(n repeat(MyClass val))) println
(n/Date secondsToRun(n repeat(1))) println
*/

