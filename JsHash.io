
{} := method(
  m  := call message
  with := message(with) clone
  with setNext(m next)
  m arguments foreach(kv, 
    with appendArg(kv clone setNext(nil)) # string "key"
    with appendArg(kv next next)          # value
  )
  m setName("Map") setArguments(list()) setNext(with) # the essence of this macro is here. 
  self doMessage(message(Map), call sender)
)

if (isLaunchScript,
  
  (Map with("1", 2, "3", 4) == (Map with("1", 2, "3", 4))) println # false ??
  Map with("1", 2, "3", 4) asJson println
  {"1": 2, "3": 4} asJson println
  
  n := 30000
  Date secondsToRun(n repeat(Map with("a", 1, "b", 2))) println
  Date secondsToRun(n repeat({"a": 1, "b": 2})) println
)
 
