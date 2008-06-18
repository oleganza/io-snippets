#!/usr/bin/env io

Number primrec1 := method( 
  n := 1; 
  for(i, 2, self, n := n doMessage(call argAt(0) clone appendCachedArg(i))); 
  n 
);

Number primrec2 := method( 
  n := 1; 
  Number __iterator__ := 0
  m := call argAt(0) clone appendArg(message(__iterator__))
  for(i, 2, self, Number __iterator__ = i; n := n doMessage(m)); 
  n 
);

6 primrec2(*) println

# 1.0845768451690674
# 0.4916119575500488
Date secondsToRun(100000 primrec1( * )) println
Date secondsToRun(100000 primrec2( * )) println

/*
http://johnnowak.com/heap/io-challenge.txt

The Snarky "Write a Basic Higher Order Function in Io" Challenge!

Goal: Write a combinator named 'primrec' that, given some function 'f' and
      some number 'n' >= 1, computes the following (where 'f' is infix):

           1 f 2 f 3 f 4 ... f n

     The Io version should be called as such:

           5 primrec(*)  # takes a message as an argument, yields 120

     It is required that 'primrec' use constant space. The associativity
     of the function passed to it is not important.

Examples:

      Scheme
  
            (define (primrec f n)
              (let r ((i (- n 1)) (total n))
                (if (zero? i)
                    total
                    (r (- i 1) (f i total)))))
      
            (primrec * 5)  ; 120

      Objective Caml

            let primrec f n =
              let rec r i total =
                if i = 0 then total
                else r (i - 1) (f total i)
              in r (n - 1) n
      
            primrec ( * ) 5  (* 120 *)

      5th

            primrec(F) = dup 1 - until(zero?, keep(F) 1 -) drop

            5 primrec(*)  ; 120
*/


