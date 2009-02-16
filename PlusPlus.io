#!/usr/bin/env io

Message OperatorTable addAssignOperator("++", "incrementOperator")
Object incrementOperator := method(call message arguments)
 
if(isLaunchScript,
  if (getSlot("__reloaded__") not,
    setSlot("__reloaded__", 1)
    doFile(System launchScript)
    exit
  )
  
  i := 42
  (i ++) println
  i println
)