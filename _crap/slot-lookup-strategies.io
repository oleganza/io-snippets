#!/usr/bin/env io
# Compare different slot lookup optimization strategies.
# Oleg Andreev <oleganza@gmail.com> June, 25 2008.

# For sake of simplicity we don't model multiple protos.
# Every object has a single proto.

SimpleObject := Object clone do(
  init := method(
    self _slots := Object clone
    self _proto := nil
  )
  _setPrototype := method(p,
    self _proto := p
    self
  )
  _clone := method(
    SimpleObject clone _setPrototype(self)
  )
  _lookupSlot := method(name,
    if(_slots hasLocalSlot(name),
      _slots getSlot(name),
      _proto _lookupSlot(name)
    )
  )
  _setSlot := method(name, value,
    _slots setSlot(name, getSlot("value"))
  )
)

ObjectWithCachedSlots := SimpleObject clone do(
  init := method(
    self _cached_slots := Object clone
    resend
  )
  _lookupSlot := method(name,
    if(_slots hasLocalSlot(name),
      _slots getSlot(name),
      if(_cached_slots hasLocalSlot(name),
        _cached_slots getSlot(name),
        _proto _lookupSlot(name)
      )
    )
  )
)



!! := method(
  if(r := call sender doMessage(a := call message arguments first),
    "Okay: #{a}" interpolate println,
    Exception raise("Failed: #{a}" interpolate)
  )
)

test := method(cls,
  person := cls _clone
  person _setSlot("name", "Incognito")
  person _setSlot("walk", method("person walking"))
  !!(person _lookupSlot("name") == "Incognito")
  !!(person _lookupSlot("walk") call == "person walking")
  girl := person _clone
  olya := girl _clone
  !!(girl _lookupSlot("name") == "Incognito")
  girl _setSlot("name", "Some girl")
  !!(girl _lookupSlot("name") == "Some girl")
  !!(olya _lookupSlot("name") == "Some girl")
  olya _setSlot("name", "Olya")
  !!(olya _lookupSlot("name") == "Olya")
  olya
)

test(SimpleObject)
test(ObjectWithCachedSlots)


/*Benchmark compare(
  
) before(
  
) do(
  
)
*/



