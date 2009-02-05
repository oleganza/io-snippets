# Usage:
#   Object doFile("RubySymbols.io")
# or
#   MyProto doFile("RubySymbols.io")

: := method(
  m := call message
  m2 := m next
  n := m2 name
  m setNext(m2 next)
  m setCachedResult(n) # for the next calls
  n
)

if (isLaunchScript,
  :a println
  x := :symbol
  x println 
  (:a == "a") println 
)
