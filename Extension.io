# Originally written by Oleg Andreev, oleganza@gmail.com
# June, 29 2008
# License: WTFPL

Extension := Object clone do(
  name       ::= nil
  setupCode  ::= nil
  revertCode ::= nil  
  new := method(name, # code
    self clone \
         setName(name)  \
         setSetupCode(call message argAt(1)) \
         setRevertCode(call message argAt(2))
  )
  setup := method(
    setSetupCode(call message argAt(0))
  )
  revert := method(
    setRevertCode(call message argAt(0))
  )
  #doc Extension install(destination=nil) Runs extension's setup code against the destination object. If destination is omitted, current object is used (i.e. "call sender").
  install := method(destination,
    destination := if(destination, destination, call sender)
    setupCode doInContext(destination, destination)
    self
  )
  #doc Extension uninstall Runs extension's revert code against the destination object.
  uninstall := method(destination,
    destination := if(destination, destination, call sender)
    revertCode doInContext(destination, destination)
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
  
  # Should catch an exception "Sequence does not respond to 'length'"
  try( "42" length) error println
  
  # Install extension to the current scope
  SequenceExtension install
  
  # Now length should return 2
  "42" length println

  # Uninstall extension from the current scope
  SequenceExtension uninstall

  # Should catch an exception "Sequence does not respond to 'length'"
  try( "42" length) error println
)
