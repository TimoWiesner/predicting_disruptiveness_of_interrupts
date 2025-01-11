;; decline
(p start-decision-decline
    =goal>
     ISA        suggestion
     step       decision-decline
==>
    +visual-location>
     ISA        visual-location
     value      "decline"
     kind       OVAL
    =goal>
     ISA        suggestion
     step       attend-decline
)

(p attend-suggestion-decline
    =goal>
     ISA        suggestion
     step       attend-decline
    ?visual>
     state      free
    =visual-location>
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        suggestion
     step       motor-action-decline
    =visual-location>
)

(p remember-target-location-decline
    =goal>
     ISA        suggestion
     step       motor-action-decline
     location   n
    =visual>
     ISA        visual-object
     screen-pos =location
==>
    =goal>
     step       move-mouse-decline
     location   =location
)

(p move-mouse-decline
    =goal>
     ISA        suggestion
     step       move-mouse-decline
     location   =location
    ?manual>
     state      free
==>
    =goal>
     step       check-clickable-decline-attend
     location   n
    +manual>
     ISA        move-cursor
     cmd        move-cursor
     loc        =location

)
;; wait loop, til the button is clickable again
(p check-clickable-decline-attend
    =goal>
     ISA        cooking
     step       check-clickable-decline-attend
    =visual-location>
==>
    =goal>
     step       check-clickable-decline
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =visual-location>
)

(p check-clickable-decline
    =goal>
     ISA        suggestion
     step       check-clickable-decline
    =visual>
     ISA        visual-object
     color      RED
==>
    =goal>
     step       wait-clickable-decline
)

(p wait-clickable-decline
    =goal>
     ISA        suggestion
     step       wait-clickable-decline
==>
    =goal>
     step       check-clickable-decline-attend
)

(p click-decline
    =goal>
     ISA        suggestion
     step       check-clickable-decline
    =visual>
     ISA        visual-object
     - color    RED
    ?manual>
     state      free
==>
    =goal>
     step       wait-for-click-decline
    +manual>
     ISA        click-mouse
     cmd        click-mouse
)

(p wait-for-click-decline
   =goal>
      isa      suggestion
      step     wait-for-click-decline
   ?manual>
      state    free
  ==>
   =goal>
      step    recall-cooking-step
)