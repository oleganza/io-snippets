#!/usr/bin/env io
# Simple benchmark for Io language
# Oleg Andreev <oleganza@gmail.com> June, 25 2008

Benchmark := Object clone do(
  Results := Object clone do(
    list ::= list()
    base ::= 0
    print := method(
      "Fastest expression: #{base round} calls/sec" interpolate println
      list foreach(tuple, 
        "#{tuple first} #{tuple second asString(0,2)}x slower" interpolate println
      )
      self
    )
  )
  Comparison := method(
    ComparisonObject clone setContext(call sender) setArgs(call evalArgs) setArgNames(call message arguments)
  )
  ComparisonObject := Object clone do(
    init := method(
      args ::= list()
      argNames ::= list()
      context ::= nil
      locals := nil
    )
    setContext := method(x,
      context = getSlot("x")
      locals = getSlot("x") clone
      self
    )
    setup := method(
      call message arguments first doInContext(getSlot("context"), getSlot("locals"))
      self
    )
    
  )
  compare := method(
    results := call message arguments map(x, smartProbe(x, call sender))
    results = results sortKey(x, x second) sort(>)
    base := results first second
    results = results map(x, list(x first, base / x second))
    Results clone setList(results) setBase(base)
  )
  smartProbe := method(msg, ctx,
    probeTime := 0.2
    n := 1
    t := probe(msg, ctx, n)
    if(t < 1, n = (probeTime / t) round)
    t = probe(msg, ctx, n)
    list(msg, n / t)
  )
  probe := method(msg, ctx, n, 
    Date secondsToRun(
      n repeat(
        msg doInContext(ctx, ctx)
      )
    )
  )
)

if(isLaunchScript, 
  Benchmark compare(
    list(1, 2, 3) map(*2),
    list(1, 2, 3) map(x, x*2),
    list(1, 2, 3) map(i, x, x*2),
    x := 1; y := 2; z := 3; x*2; y*2; z*2
  ) println
)
