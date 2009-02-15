
### LIBRARY

VarArgs := Object clone do(
  setup := method(obj, 
    obj = if(obj, obj, Object)
    ioMethod := getSlot("method")
    obj method := ioMethod(
      call message arguments foreach(v
        if()
      )
    )
  )
)


### TEST

VarArgs setup

m := method(x, y, *args, z, 
  list(x, y, args, z)
)

# => 
# 1. Rewrite method to method(x,y,args,z)
# 2. Rewrite call message to 
# m_raw(1, 2, list(3, 4, 5, 6), 7)
m(1, 2, 3, 4, 5, 6, 7) println

