;;clickContinueResetGoal
(p no-unfinished-step-found
    =goal>
     ISA        cooking
     step       attend-recipe-step-ingredient
    ?visual-location>
     state      error
==>
    +visual-location>
     ISA        visual-location
     value      "continue"
     kind       OVAL
    =goal>
     ISA        cooking
     step       attend-continue-btn
)

(p attend-continue-btn
    =goal>
     ISA        cooking
     step       attend-continue-btn
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
     step       motor-action-continue
    =visual-location>
)

(p remember-target-location-continue
    =goal>
     ISA        cooking
     step       motor-action-continue
     location   n                       
    =visual>
     ISA        visual-object
     screen-pos =location
==>
    =goal>
     step       move-mouse-continue
     location   =location
)

(p move-mouse-continue
    =goal>
     ISA        cooking
     step       move-mouse-continue
     location   =location
    ?manual>
     state      free
==>
    =goal>
     step       check-clickable-continue-attend
     location   n
    +manual>
     ISA        move-cursor
     cmd        move-cursor
     loc        =location

)
;; wait loop, til the button is clickable again
(p check-clickable-continue-attend
    =goal>
     ISA        cooking
     step       check-clickable-continue-attend
    =visual-location>
==>
    =goal>
     step       check-clickable-continue
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =visual-location>
)

(p check-clickable-continue
    =goal>
     ISA        cooking
     step       check-clickable-continue
    =visual>
     ISA        visual-object
     color      RED
==>
    =goal>
     step       wait-clickable-continue
)

(p wait-clickable-continue
    =goal>
     ISA        cooking
     step       wait-clickable-continue
==>
    =goal>
     step       check-clickable-continue-attend
)

(p click-continue
    =goal>
     ISA        cooking
     step       check-clickable-continue
    =visual>
     ISA        visual-object
     - color    RED
    ?manual>
     state      free
==>
    =goal>
     step       wait-for-click-continue
    +manual>
     ISA        click-mouse
     cmd        click-mouse
)

(p wait-for-click-continue
   =goal>
      isa      cooking
      step     wait-for-click-continue
   ?manual>
      state    free
  ==>
   =goal>
      ISA     cooking
      step    look-around
      status  n
      location n
)