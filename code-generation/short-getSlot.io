#!/usr/bin/env io

Object : := method(
  m1 := call message
  "--" println
  m1 name println
  m2 := m1 next
  m3 := m2 next
  n := m2 name
  m1 setName("getSlot")
  m1 setArguments(list(Message clone setName(n)))
  m1 setNext(m3)
  m1 println
  m3 println
  call target getSlot(n)
)

meth := method(a, a*2)

#:meth println

m := message(:meth message)
(doMessage(m) == getSlot("meth")) println
(doMessage(m) == getSlot("meth")) println
m println

N := 100*1000

Date secondsToRun(
  N repeat(
    getSlot("meth")
    getSlot("Object")
    getSlot("List")
    getSlot("SomethingBlahBlah")
  )
) println # 0.147

Date secondsToRun(
  N repeat(
    :meth
    :Object
    :List
    :SomethingBlahBlah
  )
) println # 0.153

