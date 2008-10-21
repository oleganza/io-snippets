#!/usr/bin/env io
# Useless, but harmless ruby-like classes implementation in Io.
# 0. Class is created using 'Class clone'
# 1. Instance methods are defined in the "prototype" slot of the class. 
# 2. Subclasses are created using 'Klass clone' (name must be set explicitely)
# 3. Instances are created using 'Klass allocate' or 'Klass new(argsForInitialize)'
#
# Author: Oleg Andreev (oleganza)
# License: WTFPL

Class := Object clone do(
  name ::= "Class"
  superclass ::= nil
  prototype ::= Object clone do(
    initialize := method()
    class ::= nil
  )
  clone := method(
    subclass := super(clone) 
    subclass setPrototype(prototype clone)
    subclass prototype setClass(self)
    subclass setSuperclass(self)
    subclass
  )
  allocate := method(
    self prototype clone
  )
  new := method(
    instance := allocate
    instance doMessage(call message clone setName("initialize") setNext(nil))
    instance
  )
  asString := method(name)
)


#
# Test
#

if(isLaunchScript,
  A := Class clone setName("A")
  A println
  A name println
  A superclass println
  Class superclass println # nil
  B := A clone setName("B")
  A prototype aMethod := method("a")
  B prototype bMethod := method("b")
  B prototype initialize := method(x,y, self x := x; self y := y)
  b := B new(1,2)
  b aMethod println
  b x println
  b y println
  b class println
)
