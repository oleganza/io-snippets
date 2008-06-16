#!/usr/bin/env ruby

$VERBOSE = nil

class LangProxy
  attr_accessor :string
  def initialize(word, rest)
    @string = word
    @string += " " + rest.string if rest
  end
  def to_s
    @string
  end
end

def method_missing(a, b = nil)
  LangProxy.new(a.to_s, b)
end

puts quick brown fox jumps over the lazy dog
