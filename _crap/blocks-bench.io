URL
doURL("http://pastie.org/pastes/221525/download")

blk := block(x, x * 2)
lst := list(1, 2, 3)
Benchmark compare(
  lst map( * 2),
  lst &map(blk)
) println

# Results:
#
# Fastest expression: 11463 calls/sec
# lst &(map(blk)) 1.00x slower
# lst map(*(2)) 3.84x slower
#
# Oleg Andreev: WTF? Metaprogramming wrapper works faster than method it wraps around?
#
