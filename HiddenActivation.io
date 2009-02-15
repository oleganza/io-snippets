#!/usr/bin/env io
# Warning! Use getSlot if you want to accept method as an argument.

withDirectAccessToArgument := method(x, x)
withIndirectAccessToArgument := method(x, getSlot("x"))

withDirectAccessToArgument(method(1+1)) println # 1 + 1 was calculated
withIndirectAccessToArgument(method(1+1)) call println

# Results:
# 2
# 2