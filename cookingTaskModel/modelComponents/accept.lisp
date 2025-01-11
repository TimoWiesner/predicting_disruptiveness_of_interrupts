;; accept
(p start-decision-accept
    =goal>
     ISA        suggestion
     step       decision-accept
==>
    +visual-location>
     ISA        visual-location
     value      "accept"
     kind       OVAL
    =goal>
     ISA        suggestion
     step       attend-accept
)

(p attend-suggestion-accept
    =goal>
     ISA        suggestion
     step       attend-accept
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
     step       motor-action-accept
    =visual-location>
)

(p remember-target-location-accept
    =goal>
     ISA        suggestion
     step       motor-action-accept
     location   n
    =visual>
     ISA        visual-object
     screen-pos =location
==>
    =goal>
     step       move-mouse-accept
     location   =location
)

(p move-mouse-accept
    =goal>
     ISA        suggestion
     step       move-mouse-accept
     location   =location
    ?manual>
     state      free
==>
    =goal>
     step       check-clickable-accept-attend
     location   n
    +manual>
     ISA        move-cursor
     cmd        move-cursor
     loc        =location

)
;; wait loop, til the button is clickable again
(p check-clickable-accept-attend
    =goal>
     ISA        cooking
     step       check-clickable-accept-attend
    =visual-location>
==>
    =goal>
     step       check-clickable-accept
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =visual-location>
)

(p check-clickable-accept
    =goal>
     ISA        suggestion
     step       check-clickable-accept
    =visual>
     ISA        visual-object
     color      RED
==>
    =goal>
     step       wait-clickable-accept
)

(p wait-clickable-accept
    =goal>
     ISA        suggestion
     step       wait-clickable-accept
==>
    =goal>
     step       check-clickable-accept-attend
)

(p click-accept
    =goal>
     ISA        suggestion
     step       check-clickable-accept
    =visual>
     ISA        visual-object
     - color    RED
    ?manual>
     state      free
==>
    =goal>
     step       wait-for-click-accept
    +manual>
     ISA        click-mouse
     cmd        click-mouse
)

(p wait-for-click-accept
   =goal>
      isa      suggestion
      step     wait-for-click-accept
   ?manual>
      state    free
  ==>
   =goal>
      step    recall-cooking-step
)