;; cookIngredient
(p start-cooking-step
    =goal>
     ISA        cooking
     step       find-next-step
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
==>
    +visual-location>
     ISA        visual-location
     screen-y   459
     value      =ingredient
     kind       OVAL
    =goal>
     ISA        cooking
     step       attend-step-ing
    =imaginal>
)

(p attend-cooking-step-ing
    =goal>
     ISA        cooking
     step       attend-step-ing
    ?visual>
     state      free
    =visual-location>
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        cooking
     step       motor-action-ing
    =visual-location>
)

(p remember-target-location-ing
    =goal>
     ISA        cooking
     step       motor-action-ing
     location   n
    =visual>
     ISA        visual-object
     screen-pos =location
==>
    =goal>
     step       move-mouse-ing
     location   =location
)

(p move-mouse-ing
    =goal>
     ISA        cooking
     step       move-mouse-ing
     location   =location
    ?manual>
     state      free
==>
    =goal>
     step       check-clickable-ing-attend
     location   n
    +manual>
     ISA        move-cursor
     cmd        move-cursor
     loc        =location

)
;; wait loop, til the button is clickable again
(p check-clickable-ing-attend
    =goal>
     ISA        cooking
     step       check-clickable-ing-attend
    =visual-location>
==>
    =goal>
     step       check-clickable-ing
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =visual-location>
)

(p check-clickable-ing
    =goal>
     ISA        cooking
     step       check-clickable-ing
    =visual>
     ISA        visual-object
     color      RED
==>
    =goal>
     step       wait-clickable-ing
)

(p wait-clickable-ing
    =goal>
     ISA        cooking
     step       wait-clickable-ing
==>
    =goal>
     step       check-clickable-ing-attend
)

(p click-ing
    =goal>
     ISA        cooking
     step       check-clickable-ing
    =visual>
     ISA        visual-object
     - color    RED
    ?manual>
     state      free
==>
    =goal>
     step       wait-for-click-ing
    +manual>
     ISA        click-mouse
     cmd        click-mouse
)

(p wait-for-click-ing
   =goal>
      isa      cooking
      step     wait-for-click-ing
   ?manual>
      state    free
  ==>
   =goal>
      step    look-out-for-suggestion
      status  t
)