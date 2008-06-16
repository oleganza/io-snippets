#!/usr/bin/env io

LangProxy := Object clone do(
  string := ""
  new := method(word,
    clone do(string = word asMutable)
  )
  forward = method(
    string = string .. " " .. call message name
    self
  )
  asString = method(string)
)

forward = method(
  LangProxy new(call message name)
)

quick brown fox jumps over the lazy dog println
