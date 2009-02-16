#!/usr/bin/env io
# 
# Message OperatorTable addAssignOperator("++", "incrementOperator")
# 
# Number ++ := method(call message arguments)
# 

Message OperatorTable addAssignOperator("->", "assign")
Object assign := method(name, content,
    "assign called" println
)
a -> 3

# 
# if(isLaunchScript,
#   
#   i := 42
#   (i ++) println
#   i println
#   
# )