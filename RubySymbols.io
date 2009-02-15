#!/usr/bin/env io

Object : := method(
  m1 := call message
  m2 := m1 next
  m3 := m2 next
  n := m2 name
  m1 setCachedResult(n)
  m1 setNext(m3)
  n
) 

((:Oleg .. " " .. :Andreev) == "Oleg Andreev") println 

m := message(:a)
(m cachedResult == nil) println 
(doMessage(m) == "a") println   
(m cachedResult == "a") println 

N := 1000*1000

Date secondsToRun(
  N repeat(
    1 # no op
  )
) println # 0.029

Date secondsToRun(
  N repeat(
  "Quick"
  "brown"
  "fox"
  "jumps"
  "over"
  "the"
  "lazy"
  "dog"
  )
) println # 0.147

Date secondsToRun(
  N repeat(
  :Quick
  :brown
  :fox
  :jumps
  :over
  :the
  :lazy
  :dog
  )
) println # 0.153

