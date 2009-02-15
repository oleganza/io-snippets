#!/usr/bin/env io
Loki 

exit


Loki Implementation clone linkToAs( Sequence, "nsieve" ) with(

	bytes := _self data.ptr castAs(ByteArray) bytes
	n := valueArgAt(0) data.d

	cnt := int <- 0

	Loop as(i := int <- 2) while(i<n) by(i++) with(
		(bytes[i] == 0) ifTrue(
			Loop for(k := i+i; k<n; k += i) with(
				bytes[k] <- 1
			)
			cnt++
		)
	)
	
	_self state numberWithDouble(cnt asFloat64)
	
)

nsieve := method(n,
	primes := Sequence clone setSize(n+1) zero
	cnt := primes nsieve(n)
	( "Primes up to" .. n asString alignRight(9, " ") .. cnt asString alignRight(9, " ") ) println
)

n := 3

nsieve( (2**(n))*10000 )
nsieve( (2**(n-1))*10000 )
nsieve( (2**(n-2))*10000 )
