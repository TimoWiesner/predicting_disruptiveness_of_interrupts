;; cookPreparation
(p continue-cooking-step
    =goal>
     ISA        cooking
     step       find-next-step
     status     t
    =imaginal>
     ISA        recipe-step
     preparation =preparation
==>
    +visual-location>
     ISA        visual-location
     screen-y   609
     value      =preparation
     kind       OVAL
    =goal>
     ISA        cooking
     step       attend-step-prep
    =imaginal>
)

(p attend-cooking-step-prep
    =goal>
     ISA        cooking
     step       attend-step-prep
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
     step       motor-action-prep
    =visual-location>
)

(p remember-target-location-prep
    =goal>
     ISA        cooking
     step       motor-action-prep
     location   n
    =visual>
     ISA        visual-object
     screen-pos =location
==>
    =goal>
     step       move-mouse-prep
     location   =location
)

(p move-mouse-prep
    =goal>
     ISA        cooking
     step       move-mouse-prep
     location   =location
    ?manual>
     state      free
==>
    =goal>
     step       check-clickable-prep-attend
     location   n
    +manual>
     ISA        move-cursor
     cmd        move-cursor
     loc        =location
)
;; wait loop, til the button is clickable again
(p check-clickable-prep-attend
    =goal>
     ISA        cooking
     step       check-clickable-prep-attend
    =visual-location>
==>
    =goal>
     step       check-clickable-prep
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =visual-location>
)

(p check-clickable-prep
    =goal>
     ISA        cooking
     step       check-clickable-prep
    =visual>
     ISA        visual-object
     color      RED
==>
    =goal>
     step       wait-clickable-prep
    =visual>
)

(p wait-clickable-prep
    =goal>
     ISA        cooking
     step       wait-clickable-prep
==>
    =goal>
     step       check-clickable-prep-attend
)

(p click-prep
    =goal>
     ISA        cooking
     step       check-clickable-prep
    =visual>
     ISA        visual-object
     - color    RED
    ?manual>
     state      free
==>
    =goal>
     step       wait-for-click-prep
    +manual>
     ISA        click-mouse
     cmd        click-mouse
)

(p wait-for-click-prep
   =goal>
      isa      cooking
      step    wait-for-click-prep
   ?manual>
      state    free
  ==>
   =goal>
      step    finish-step
      ignore  n
)

(p finish-recipe-step
    =goal>
     ISA        cooking
     step       finish-step
    =imaginal>
     ISA        recipe-step
==>
    =goal>
     step       look-out-for-suggestion
     status     n
    =imaginal>
     ISA        recipe-step
     status        "done"
    -imaginal>
)