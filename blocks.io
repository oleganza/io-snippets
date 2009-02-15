#!/usr/bin/env io
# Transform blocks into messages with the preserved scope.
# See transcript from #io IRC channel below.
# Oleg Andreev <oleganza@gmail.com> June, 25 2008.

Object splatBlock := method(
  msg := call message
  methargs := msg arguments first arguments clone
  blk := call sender doMessage(methargs pop)
  newmsg := Message fromString(msg arguments first name)
  methargs foreach(a, newmsg appendArg(a))
  blk argumentNames foreach(a, newmsg appendArg(Message fromString(a)))
  newmsg appendArg(blk message)
  newmsg setNext(msg next)
  call relayStopStatus(call target doMessage(newmsg, blk scope))
)

Object & := Object getSlot("splatBlock")

verify := method(
  succ := List clone
  flrs := List clone
  time := Date secondsToRun(
    call message arguments foreach(arg,
      if (call sender doMessage(arg),
        "." print; succ append(arg),
        "F" print; flrs append(arg)
      )
    )
  )
  "" println
  "#{succ size + flrs size} tests, #{flrs size} failures in #{time} seconds" interpolate println
  "" println
  if(flrs size > 0, "Failures:" println)
  flrs foreach(i, f, 
    "#{i}) #{f}" interpolate println
  )
  flrs
)

"Passing block without arguments" println

verify(
  list(1, 2) map(*2)                             == list(2, 4),
  list(1, 2) map(x, x*2)                         == list(2, 4),
  list(1, 2) map(i, x, x*2)                      == list(2, 4),
  y := 3; list(1, 2) map(i, x, x*y)              == list(3, 6),
  
  b := block(x, x*2); list(1, 2) &map(b)         == list(2, 4),
  b := block(i, x, x*2); list(1, 2) &map(b)      == list(2, 4),
  b := block(*2); list(1, 2) &map(b)             == list(2, 4),
  y := 5; b := block(*y); list(1, 2) &map(b)     == list(5, 10),
  b := block(x, x*2); list(1, 2) &map(b) sum     == 6,
  y := 4; b := block(x, x*y); list(1, 2) &map(b) == list(4, 8)
)

List inject := method(initial, # container, element, code
  result := initial

  container := call argAt(1) name
	element := call argAt(2) name
	code := call argAt(3)

	self foreach(v,
		call sender setSlot(container, result)
		call sender setSlot(element, v)
		ss := stopStatus(c := code doInContext(call sender, call sender))
		if(ss isReturn, ss return c)
		if(ss stopLooping, break)
		if(ss isContinue, continue)
		result = c
	)
	result
)

"Passing block after the arguments" println

verify(
  list(1, 2) inject(0, c, x, c + x)           == 3,
  list(1, 2) inject(10, c, x, c + x)          == 13,
  
  list(1, 2) &inject(0, block(c, x, c + x))   == 3,
  list(1, 2) &inject(10, block(c, x, c + x))  == 13
)

doFile("benchmark.io")

blk := block(x, x * 2)
lst := list(1, 2, 3)
Benchmark compare(
  lst map( * 2),
  lst &map(blk)
) println


# Run:
#
# $ io blocks.io 
# Passing block without arguments
# ..........
# 10 tests, 0 failures in 0.0006911754608154 seconds
# 
# Passing block after the arguments
# ....
# 4 tests, 0 failures in 0.0013711452484131 seconds


/*
(#io @ freenode)

The initial talk:

oleganza :
the contest is over? results are here: http://pastie.org/220505
[21:59] johnnowak :
hah
[] johnnowak:
HOFs are one of the cases where io's automatic activation of methods kills you
[] johnnowak:
you could write it to use a block/method *and* call it with primrec(*) if io required methods to be explicitly envoked
[] johnnowak:
you'd have to change the language completely though.
[22:06] wifs left the chat room. (Read error: 110 (Connection timed out))
[22:11] WardCunningham joined the chat room.
[22:12] michaell_ left the chat room. (Read error: 110 (Connection timed out))
[22:14] doctormach left the chat room. ("Leaving")
[22:15] michaell joined the chat room.
[22:18] Fullmoon left the chat room.
[22:24] yanbe joined the chat room.
[22:25] WardCunningham left the chat room. (Read error: 104 (Connection reset by peer))
[22:36] WardCunningham joined the chat room.
[22:38] jer :
johnnowak, you could write currying support for Io, but the only way to do it right is to get rid of the "" message
[] jer:
which fucks up grouping
[22:39] johnnowak :
jer: well that doesn't require currying, just a nice way of accessing a slot without activating 
[22:39] oleganza :
which message? empty string
[] oleganza:
?
[] oleganza:
johnnowak: what's the problem with getSlot("name")? Is it a matter of purity or i miss something important?
[22:40] johnnowak :
oleganza: there's no issue
[] johnnowak:
not with purity anyway
[] johnnowak:
the only issue as i see it is that io encourages much more complex method definitions to enable you to use the "nice" syntax... at least in this particular case
[] johnnowak:
the block version is much more straightforward than the message version
[] johnnowak:
i suppose a getSlot operator would get you must of the way there
[] johnnowak:
*most
[] johnnowak:
certainly the common lisp folk put up with a # here and there
[22:47] oleganza :
what setNext does? what method chaining is?
[] oleganza:
sorry for possible stupid questions
[] oleganza:
* possibly
[22:48] jer :
johnnowak, err, too many thoughts going through my head, that's what i meant, not currying
[] jer:
i've been thinking about a way to handle currying in io lately
[] jer:
without much success w/o breaking things or not getting true semantics
[22:49] johnnowak :
!eval x := message(foo bar); x setNext(message(baz)); x
[22:49] Haemus :
foo baz
[22:50] oleganza :
!eval x := message(foo bar baz); x setNext(message(blah)); x
[22:50] Haemus :
foo blah
[22:50] david_koontz joined the chat room.
[22:50] johnnowak :
jer: partial application and n-ary methods don't go together nicely
[22:50] oleganza :
!eval x := message(foo(a, b) bar(x,y)); x setNext(message(blah)); x
[22:50] Haemus :
foo(a, b) blah
[22:52] johnnowak :
jer: a better solution might be something like the "cut" macro for scheme. for example, if i wanted a function that returns twice its argument, i could do (cut * 2 <>). the "<>" is sort of an anonymous way of saying "this needs an argument"
[] johnnowak:
2 cut(*, <>) call(5)    # 10
[] johnnowak:
to be honest, i think a concise block syntax is better in almost all cases
[] johnnowak:
[|x| 2 * x]
[] johnnowak:
actually...
[] johnnowak:
the syntax should just be |x| 2 * x and you'd use parens for grouping if necessary. that would let you write things like this:
[] johnnowak:
list(1, 2, 3, 4, 5) map(|x| x * x) 
[] johnnowak:
maybe something like that could be hacked in?
[] johnnowak:
it would be an error for |x| to begin somewhere other than the beginning of a message chain
[] johnnowak:
although that doesn't give you a way to denote blocks of no arguments...
[] johnnowak:
perhaps just an empty || , or a single |
[22:58] jer :
see, it would be a lot simpler (less hackery) to make that [x, 2 * x]
[] jer:
and that syntax is more concise with the rest of io
[22:58] oleganza :
!eval y:=1; list(1,2,3) map(x, y = y+1; x*x); y
[22:58] Haemus :
4
[22:59] johnnowak :
jer: that would be fine too
[22:59] jer :
i like the approach i took with moose
[22:59] johnnowak :
i suppose that's just a matter of using squareBrackets for block?
[22:59] jer :
supporting passing code blocks as messages OR as blocks
[] jer:
based on the "connected block" notion
[] jer:
ie
[] jer:
list(1,2) map(x, x * x)
[] jer:
or
[] jer:
list(1,2) map: [x| x * x]
[23:00] johnnowak :
i find that confusing
[23:00] jer :
i did it for a reason
[23:00] johnnowak :
as now concatenation means either a message send or the passing of an argument
[23:01] jer :
people often bitch in here, you know yourself, about that sort of behaviour with io, wanting to pass in a block
[] jer:
basically what a connected block does is disassemble the block, set the context, pass in the message and the arguments to the method
[] jer:
this is all done in the runtime
[] jer:
a method need not know how to handle that case
[] jer:
so any method can take a connected block
[23:04] michaell_ joined the chat room.
[23:06] oleganza :
maybe suggest a Message asBlock method?
[23:06] jer :
oleganza, could do that easily enough
[23:06] oleganza :
you may keep map(x, x*x) syntax
[] oleganza:
and also do something like this: map("arg", (x, x*x)) instead of map("arg"): [x| x*x]
[] oleganza:
!eval m := method(call message argAt(1)); m(a, (b, c))
[23:07] Haemus :
(b, c)
[23:10] johnnowak :
aye, the problem with map(x, x * x) is that 'x' is just a message name... it won't close over anything
[23:11] oleganza :
just like in method(x, x*x)
[23:11] johnnowak :
ah nevermind, i'm silly
[23:11] ikaros joined the chat room.
[23:12] michaell left the chat room. (Read error: 110 (Connection timed out))
[23:15] yaroslav joined the chat room.
[23:17] jtza8 joined the chat room.
[23:17] rfh joined the chat room.
[23:18] jer :
oleganza, problem with static manipulation of the message tree is it falls down on complex hierarchies
[] jer:
trust me, i know
[] jer:
that's about all i do with io lol
[23:19] oleganza :
what static manipulation is?
[] oleganza:
could you pls show some examples. I'm not completely understand the topic
[] oleganza:
* err. "I'm not"  -> "I don't" 
[23:19] johnnowak :
jer: you mean macros?
[23:20] jer :
oleganza, you provided an example
[] jer:
looking at a SPECIFIC index in library code
[] jer:
any time you need to look at a specific index, you can define it as a formal parameter, except in rare cases
[23:21] oleganza :
it can do "call message lastArg" as well. But i got an idea.
[] oleganza:
how is it supposed to be fixed? IMO, connected block doesn't solve the problem? or does it?
[23:22] jer :
it doesn't
[] jer:
but it helps out with people wanting to pass scope
[] jer:
which is all i designed it for
[23:23] jtza8 left the chat room.
[23:23] jer :
problem is, it adds an additional pointer to each object
[] jer:
but i shrunk IoObject HUGE
[] jer:
clever embedded programming space saving techniques helped a lot
[23:27] oleganza :
what additional pointer?
[23:29] jer :
yes
[] jer:
on each message
[23:30] obvio171 joined the chat room.
[23:38] obvio171 left the chat room. ("Cacildis!")
[23:39] oleganza :
now i start to understand the problem. We want to have both opportunities: a block statically defined in a place of the call and a block, passed from somewhere else containing the correct scope inside. I.e.: both map(x, x*2) and map(myblock) should work with as little additional logic inside map as possible?
[23:39] thoughtpolice joined the chat room.
[23:40] johnnowak :
i'd argue that map(x, x * 2) just shouldn't work 
[23:40] oleganza :
maybe map((x, x*2))?
[23:40] johnnowak :
no, parens are used for precedence 
[] johnnowak:
!eval message(((foo)))
[23:41] Haemus :
(foo)
[23:41] johnnowak :
erm
[] johnnowak:
!eval message(((((foo)))))
[23:41] Haemus :
(((foo)))
[23:41] johnnowak :
well how about that
[] johnnowak:
that's bizarre
[23:41] oleganza :
!eval () := method(call message arguments); (1,2,3)
[23:41] Haemus :
list(1, 2, 3)
[23:41] johnnowak :
!eval message(foo)
[23:41] Haemus :
foo
[23:41] johnnowak :
!eval message((foo))
[23:41] Haemus :
foo
[23:41] johnnowak :
so (foo) == foo
[] johnnowak:
but (((foo))) != ((foo))
[]
• johnnowak groans
[23:42] oleganza :
Io> message((foo))
[] oleganza:
==> foo
[] oleganza:
Io> message((foo, foo))
[] oleganza:
==> (foo, foo)
[23:45] thoughtpolice left the chat room. (Remote closed the connection)
[23:45] thoughtpolice joined the chat room.
[23:47] oleganza :
[] := getSlot("block"); map([x, x*x])
[] oleganza:
in case, one would like a short-hand version of block()
[23:50] Fullmoon joined the chat room.
[23:50] thoughtpolice left the chat room. (Remote closed the connection)
[23:50] thoughtpolice joined the chat room.
[23:55] jer :
oleganza, but then you have to rewrite map to accept both blocks and messages
[23:55] oleganza :
)yep
[] oleganza:
not good.
[] oleganza:
maybe, we need a "Block asMessage" method? =)
[] oleganza:
like & in ruby: [1,2,3].map(&myblock)
[23:59] jer :
!eval block(a + b) message
[23:59] Haemus :
a +(b)
[00:01] jer :
right now you can do
[00:02] oleganza :
thanks 
[00:02] jer :
list(1, 2, 3) performWithArgList(myBlock message name, myBlock arguments)
[] jer:
only caveat is
[] jer:
myBlock has to be in the same scope
[] jer:
or at least in the inheritence tree
[00:02] oleganza :
that kills the idea
[00:02] jer :
right
[00:02] Fullmoon left the chat room.
[00:02] jer :
but it gives you a way to wrap it
[00:03] Atomixx joined the chat room.
[00:03] bugQ :
!eval method(5*(3+4))
[00:03] Haemus :
# doString:1 method(    5 * 3 + 4 )
[00:03] bugQ :
yay more weirdness.
[] bugQ:
!eval method(5*(3+4)) call
[00:04] Haemus :
35
[00:04] oleganza :
ok, we have two cases: 1) plain message & call sender; 2) block with "scope" and "message" . We also want one of the two things: 1) make method's body completely transparent for both cases 2) or have an easy way to distinguish one from another
[00:04] bugQ :
Method asString peels off some parens that should be
[] bugQ:
*shoudn't
[] bugQ:
*shouldn't, even
[] bugQ:
and that's Block asString.
[00:06] oleganza :
for the first desire we have to get a regular block object inside a method. So, map(x, x*x) syntax becomes completely impossible.
[] oleganza:
this is the way ruby works: with "&block" syntax and "yield" keyword.
[00:12] jer :
bugQ, there's no way to differentiate between 5 *(3+4) and 5 * 3 + 4
[] jer:
since you're following precedence
[] jer:
and the parens come right after an operator
[] jer:
err ignore following precedence
[] jer:
not what i meant to write
[] jer:
but wait, you're right, that shouldn't happen
[00:12] bugQ :
5*3+4 == 19, 5*(3+4) == 35
[00:13] jer :
nod
[] jer:
just on crack, been a long day
[00:13] bugQ :
:)
[] bugQ:
!eval method((3+4)*5)
[00:17] Haemus :
# doString:1 method(    (3 + 4) * 5 )
[00:18] oleganza :
if we want to preserve map(x, x*x) syntax along with map(myblock asSomeSpecialMessage), we have to assign scope to a block's message (huh!) and use it transparently (how?) when doing "a2 doInContext(call sender, call sender)"  (an excerpt from A0_List.io)

*/

