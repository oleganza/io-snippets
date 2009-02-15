#!/usr/bin/env io

Class := Object clone do(
  new := method(call delegateTo(prototype))
  class := nil
  superclass := Object
  prototype := Object clone do(
    class := nil
    new := method(supercls,
      instance := prototype clone
      instance class = self
      call message argsEvaluatedIn(instance)
      instance
    )
    inherit := method( 
      subcls := clone
      subcls prototype appendProto(prototype)
      subcls prototype class = self
      subcls superclass := self
      call message argsEvaluatedIn(subcls prototype)
      subcls
    )
  )
  prototype prototype := prototype
)

Class class = Class
Class prototype class = Class


A := Class new(Object,
  instance_method := method("instance method A")
  instance_method1 := method("instance method A1")
  class do(
    class_method := method("class method A")
    class_method1 := method("class method A1")
  )
)

B := A inherit(
  instance_method := method("instance method B")
  instance_method2 := method("instance method B2")
  class do(
    class_method := method("class method B")
    class_method2 := method("class method B2")
  )
)

A class_method println
A new instance_method println
B class_method println
B new instance_method println
B class_method1 println
B new instance_method1 println
B class_method2 println
B new instance_method2 println
