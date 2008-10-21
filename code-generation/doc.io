#!/usr/bin/env io
# Inline docs for Io libraries featuring console-friendly and html-building friendly API.
# See "Test" section below for examples.
#
# Author: Oleg Andreev (oleganza)
# License: WTFPL

Message do(
  extractTail := method(
    line := self next
    line ifNil(return nil)
    tail := line lastBeforeEndOfLine
    self setNext(tail next)
    tail setNext(nil)
    line
  )
)

Object Doc := Object clone do(
  registeredObjects := List clone
  // Container for Docs
  docsCollection := List clone do(
    Pair := List clone do(
      asString := method(
        "#{first}\n\t#{second}" interpolate
      )
    )
    init := method(
      self methods := List clone
    )
    add := method(msg,
      desc := doMessage(msg last)
      msg last previous setNext(nil)
      name := msg
      append(list(name, desc) setProto(Pair))
      self
    )
    find := method(prefix,
      results := List clone
      if(prefix asString == "", return clone)
      foreach(lst, 
        if(lst first asString beginsWithSeq(prefix), results append(lst))
      )
      results
    )
  )
  // sets doc
  doc := method(
    line := call message extractTail
    docs := if(self getLocalSlot("__docs__"), self getLocalSlot("__docs__"), self setSlot("__docs__", Doc docsCollection clone))
    Doc registeredObjects append(self)
    docs add(line)
    nil
  )
  man := method(
    content := if(call message arguments first,
      call message arguments first,
      call message extractTail
    ) 
    if(self getLocalSlot("__docs__"), nil, 
      "No documentation for the receiver." interpolate println; return nil)
    if(content == nil, content = "")
    __docs__ find(content asString) foreach(println)
    nil
  )
)

Object appendProto(Doc)
// Add docs for doc itself
Object do(
  doc doc someMethod(a,b) "Some description" "Adds some description to a method"
  doc man "Show all methods descriptions for the receiver"
  doc man some "Show all docs for methods starting with 'some' prefix"
)
// Add docs for Docs API
Object Doc do(
  doc registeredObjects "List of all the objects containing documentation"
)


#
# Test
#

if(isLaunchScript,
  FakeLibrary := Object clone do(
    doc hello "Returns 'hello' string"
    hello := method(
      "hello"
    )

    doc double(x) "Returns x*2"
    double := method(x,
      x*2
    )
  
    doc new(name, email, age) "Creates a new object with the specified attributes"
    doc new(mapObject) "Creates a new object with the \nattributes passed in a map object"
    new := method(name, email, age,
      nil
      // TODO: do something with name, email and age
    )
  )

  // Use brackets to write several man calls on a line
  Object man(doc); FakeLibrary man(new)
  
  // You may omit brackets (useful in the terminal): 
  Object man doc some # emits docs for "Object doc some*"
  Object man doc  # emits docs for "Object doc*"
  FakeLibrary man new  # emits docs for "FakeLibrary new*"
)
