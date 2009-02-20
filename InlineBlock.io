#!/usr/bin/env io 

# Example:
#   List map(block(x, x*2)) == List map{x, x*2}
# 
# Procedure:
#   1. If map takes no arguments, look for { } message
#   2. If {} message is found, construct a block and rewrite this message into map(block), 
#      where block message has cached result.

InlineBlock := Object clone do(
  mapWithBlock := method(block,
    l := List clone
    foreach(x, l append(block call(x))) 
    l
  )
  mapWithInlineBlock := method(x,
    "mapWithInlineBlock!" println
    if(x isNil not, return mapWithBlock(x))
    m := call message
    brackets := m next
    if(brackets name != "curlyBrackets", return mapWithBlock(block(nil)))
    blockMessage := message(block) clone
    blockMessage setArguments(brackets arguments)
    block := blockMessage doInContext(call sender, call sender)
    blockMessage setCachedResult(block)
    m setArguments(list(blockMessage))
    m setNext(brackets next)
    m setName("mapWithBlock")
    mapWithBlock(block)
  )
) removeAllProtos  # <- this is to implement an empty module


if(isLaunchScript,
  List appendProto(InlineBlock)
  list(1,2,3) mapWithBlock(block(x,x*2)) println
  list(1,2,3) mapWithInlineBlock println
  list(1,2,3) mapWithInlineBlock{x, x*2} println
  
  // should run mapWithInlineBlock once
  4 repeat(list(4,5) mapWithInlineBlock{x, x*2} println)
)
