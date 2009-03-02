#!/usr/bin/env io
# Replace a method and keep ability to call previous version using "super"
# Note: this is just a silly lazy trick. In real life you usually override multiple 
# methods by cloning the object and defining methods right in the clone 
# without any metaprogramming.

MethodOverrideable := Object clone do(
  overrideMethod := method(slotName, newMethod,
    proto := Object clone 
    proto setSlot(slotName, self getSlot(slotName))
    self appendProto(proto) setSlot(slotName, getSlot("newMethod"))
    self
  )
)

if(isLaunchScript,
  
  o := Object clone appendProto(MethodOverrideable) do(
    twice := method(x, x*2)
  )
  
  o overrideMethod("twice", method(x, super(twice(x)) + 100))
  o twice(3) println  # should print 106 (==3*2 + 100)
)
