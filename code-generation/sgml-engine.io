#!/usr/bin/env io

SGML

text := """
<html>
  <body>
    <ul>
      <li>Make a dinner</li>
      <li>Get a diploma</li>
      <li>Learn French</li>
      <li>Pass exams for driver license</li>
    </ul>
  </body>
</html>
"""

template := text asXML

content := list("Milk", "Bottle", "Bread")

page := template clone
ul := page elementsWithName("ul") first
li := ul elementsWithName("li") first
#ul println

ul setSubitems(content map(v,  li clone setSubitems(list(SGMLElement clone setText(v)))  ) )

page asString println


#xml elementsWithName("li") map(withText()) println
#xml  println
