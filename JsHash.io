
{} := method(
  m  := call message
  map := message(Map with)
  with := map next
  m arguments foreach(kv, 
    with appendArg(kv clone setNext(nil)) # string "key"
    with appendArg(kv next next)          # value
  )
  m setName("Map") setNext(with) # the essence of this macro is here. Comment this line and get 360 times slower code.
  self doMessage(map, call sender)
)

if (isLaunchScript,
  
  (Map with("1", 2, "3", 4) == (Map with("1", 2, "3", 4))) println # false ??
  Map with("1", 2, "3", 4) asJson println
  n := 1000
  Date secondsToRun(n repeat(Map with("a", 1, "b", 2))) println
  Date secondsToRun(n repeat({"a": 1, "b": 2})) println
)
 
