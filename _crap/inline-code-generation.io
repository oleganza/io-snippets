#!/usr/bin/env io
# oleganza: meth2 inlines its argument and makes execution 30+ times faster

N := 10000

meth0 := method(x, x)

meth1 := method(
  call evalArgAt(0)
)

meth2 := method(
  cm := call message
  m := cm arguments first
  cm setName(m name)
  cm setArguments(list())
  if(m hasCachedResult not, 
     cm setCachedResult(m cachedResult))
  # Exchange nexts
  m last setNext(cm next)
  cm setNext(m next)
  first := cm clone
  first setNext(nil)
  call sender doMessage(first)
)

(meth0(2*2) == 4) println # true
(meth1(2*2) == 4) println # true
(meth2(2*2) == 4) println # true

a0 := Date secondsToRun(
  N repeat(
    meth0(2*2)
  )
) println # 0.0482

a1 := Date secondsToRun(
  N repeat(
    meth1(2*2)
  )
) println # 0.0490

b := Date secondsToRun(
  N repeat(
    meth2(2*2)
  )
) println # 0.0014

(a0 / b) println # 32..33
(a1 / b) println # 32..33
