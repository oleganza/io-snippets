
debugCallSite := method(callObj,
  "Message " .. callObj sender call message name .. " sent in " .. (callObj sender call target contextWithSlot(callObj sender call message name)) println
)

Object m := method(
  debugCallSite(call)
)

A := Object clone do(
  a := method(
    "some receiver" m
  )
)

B := Object clone do(
  b := method(
    A clone a
  )
)


B clone b
