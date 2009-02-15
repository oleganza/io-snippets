#!/usr/bin/env io

test := method(
  
)
doFile("extension.io")



/*
method(
    m := call argAt(0) asMessageWithEvaluatedArgs(call sender)
    f := Future clone setRunTarget(self) setRunMessage(m)
    self actorRun
    self actorQueue append(f)
    f futureProxy
)
*/
