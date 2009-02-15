#!/usr/bin/env io

driversCollision := method(first, second, light,
  firstAction := first actionOn(light)
  secondAction := second actionOn(light other);
  firstAction isGo and secondAction isGo
)

test := method(world,
  a := world Driver clone
  b := world Driver clone
  l := world Light clone makeYellow
  driversCollision(a, b, l) println
)

run := method(
  test(World)
)

World := Object clone
World do(
  Light := clone do(
    green ::= nil
    yellow ::= nil
    red ::= nil
    makeGreen  := method(green = true;  yellow = false; red = false; self)
    makeYellow := method(green = false; yellow = true;  red = false; self)
    makeRed    := method(green = false; yellow = false; red = true;  self)
    other := method(
      self proto clone setGreen(red) setYellow(yellow) setRed(green)
    )
  )
  Driver := clone do(
    actionOn := method(light,
      if(light green, 
         actionOnGreen, 
         if(light yellow, 
            actionOnYellow, 
            actionOnRed
         )
      ) 
    )
    actionOnGreen  := method(Action go)
    actionOnYellow := method(Action stop)
    actionOnRed    := method(Action stop)
  )
  Action := clone do(
    go   := method(GoAction)
    stop := method(StopAction)
    isGo ::= nil
  )
  Action GoAction   := Action clone setIsGo(true)
  Action StopAction := Action clone setIsGo(false)
)

FuzzyWorld := World clone
FuzzyWorld do(
  FuzzyValue := Object clone do(
    new := method(pairs,
      o := clone
      o __pairs = pairs
      o
    )
    __pairs := List clone # ((prob1, val1), (prob2, val2))
    == := method(value,
      ps := __pairs map(p, (p first, p second == value))
      self proto new(ps)
    )
    asFuzzyBoolean := method(
      
    )
  )
  FuzzyBoolean := FuzzyValue clone do(
    setProbability := method(p,
      setPairs(list(list(p, true), list(1 - p, false)))
    )
    or := method(other,
      
    )
  )
  if := method(boolean, a, b,
    FuzzyObject clone setPairs(list(list(boolean probability, a), list(1 - boolean probability, b)))
  )
)

run




