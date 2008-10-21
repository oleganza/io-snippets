#!/usr/bin/env io

LangProxy := Object clone do(
  string ::= ""
  forward = method(
    string = string .. " " .. call message name
    self
  )
  asString = method(string)
)

forward = method(
  LangProxy clone setString(call message name asMutable)
)

quick brown fox jumps over the lazy dog println
