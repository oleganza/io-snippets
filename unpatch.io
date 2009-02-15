
Unpatch := Object clone do(
  
  
  World := Object clone do(
    
  )
  
)

if(isLaunchScript, 

  MRI1.8.7 := Object clone do(
    install := method(
      Sequence chars := "japanese shit"  
    )
    usage := method(
      "abc" chars
    )
  )
  
  AS := Object clone do(
    install := method(
      Sequence chars := "utf8 shit"  
    )
    usage := method(
      "abc" chars
    )
  )
  
  MRI1.8.7 install
  AS install

  MRI1.8.7 usage println
  AS usage println

)
