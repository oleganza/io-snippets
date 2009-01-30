#!/usr/bin/env io

Number ! := method(self*(self - 1)!) // add method to the prototype
0 ! := 1  // add method ! to zero (overrides prototype's !)

0! println
1! println
2! println
3! println
4! println
5! println
6! println
