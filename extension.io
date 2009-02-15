# Originally written by Oleg Andreev, oleganza@gmail.com
# June, 29 2008
# This code is released as a Public Domain technology.

Extension := Object clone do(
  new := method(name, # code
    lib := self clone
    lib name ::= name
    lib setupCode  ::= call message argAt(1)
    lib revertCode ::= call message argAt(2)
    lib
  )
  setup := method(
    self setupCode  := call message argAt(0)
    self
  )
  revert := method(
    self revertCode  := call message argAt(0)
    self
  )
  #doc Extension install(destination=nil) Runs extension's setup code against the destination object. If destination is omitted, current object is used (i.e. "call sender").
  install := method(destination,
    destination := if(destination, destination, call sender)
    self setupCode doInContext(destination, destination)
    self
  )
  #doc Extension uninstall Runs extension's revert code against the destination object.
  uninstall := method(destination,
    destination := if(destination, destination, call sender)
    self revertCode doInContext(destination, destination)
    self
  )
)

# Some tests
if(isLaunchScript, 
  
  SequenceExtension := Extension new("Sequence#length as an alias for #size") setup(
    Sequence length := Sequence getSlot("size")
  ) revert(
    Sequence removeSlot("length")
  )
  
  # Should throw an exception "Sequence does not respond to 'length'"
  try( "42" length) error println
  
  # Install extension to the current scope
  SequenceExtension install
  
  # Now length should return 2
  "42" length println

  # Uninstall extension from the current scope
  SequenceExtension uninstall

  # Should throw an exception "Sequence does not respond to 'length'"
  try( "42" length) error println
)
