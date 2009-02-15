#!/usr/bin/env io
# oleganza
# 
# BNF engine on steroids

# BNF for arithmetics: 1 + 2/3 - 3*4

BNF := Object clone do(
  parse := method(string, index, context,
    
  )
  ConstantRule := Rule clone(
    value ::= nil
    parse := method(string, index, context,
      if(index == string findSeq(value, index),
        index 
      )
      
    )
  )
  AltRule := Rule clone do(
    
  )
)

message(
  arithmeticBNF := BNF Rule clone do( 
    expression := alt(lower_expression)
    lower_expression := alt(higher_expression, seq(higher_expression, ws, lower_operator, ws, higher_expression))
    higher_expression := alt(number, seq(number, ws, higher_operator, ws, higher_expression))
    ws := alt(" ", seq(" ", ws))
    lower_operator := alt("+", "-")
    higher_operator := alt("*", "/")
    number := alt(digit, seq(digit, number))
    digit := alt("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
  )
  
  arithmeticBNF
  
) println



