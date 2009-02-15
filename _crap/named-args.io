#!/usr/bin/env io

### LIBRARY

named_arguments := method(x,
  args := getSlot("x") argumentNames
  body := getSlot("x") message 
  args println
  body println
  method(
    
  )
)

### TEST

info := named_arguments(method(name, age, email, 
  "#{name} is #{age} year old. Email is #{email}." interpolate
))

# transform the call into info("Oleg Andreev", 22, "oleganza@gmail.com")
info( email: "oleganza@gmail.com", name: "Oleg Andreev", age: 22 ) println


