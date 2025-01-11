;; compareToUnfinished
(p look-for-suggestion-ing-step
    =goal>
     ISA        suggestion
     step       find-next-step-sugg
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
==>
    +visual-location>
     ISA        visual-location
     screen-y   376
     screen-x   lowest
     - color    GREEN
     value      =ingredient
    =imaginal>
    =goal>
     ISA        suggestion
     step       attend-sugg-ing-step
)

(p suggestion-ing-step-failure-decline
    =goal>
     ISA        suggestion
     step       attend-sugg-ing-step
    ?visual-location>
     state      error
==>
    =goal>
     ISA        suggestion
     step       decision-decline
    -imaginal>
)

(p suggestion-ing-step-failure-ignore
    =goal>
     ISA        suggestion
     step       attend-sugg-ing-step
    ?visual-location>
     state      error
==>
    =goal>
     ISA        suggestion
     step       recall-cooking-step
     ignore     t
     -imaginal>
)

(p attend-suggestion-ing-step
    =goal>
     ISA        suggestion
     step       attend-sugg-ing-step
    =visual-location>
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        suggestion
     step       look-for-sugg-prep-step
)

(p look-for-suggestion-prep-step
    =goal>
     ISA        suggestion
     step       look-for-sugg-prep-step
==>
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
    =goal>
     ISA        suggestion
     step       attend-sugg-prep-step
)

(p attend-suggestion-prep-step
    =goal>
     ISA        suggestion
     step       attend-sugg-prep-step
    =visual-location>
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        suggestion
     step       compare-sugg-prep-step
)

(p suggestion-prep-step-fit
    =goal>
     ISA        suggestion
     step       compare-sugg-prep-step
    =imaginal>
     ISA        recipe-step
     preparation =preparation
    =visual>
    value       =preparation
==>
    =goal>
     ISA        suggestion
     step       decision-accept
    -imaginal>
)

(p suggestion-prep-step-failure
    =goal>
     ISA        suggestion
     step       compare-sugg-prep-step
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
     preparation =preparation
    =visual>
    - value       =preparation
==>
    =goal>
     ISA        suggestion
     step       attend-sugg-ing-step
    =imaginal>
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
     value      =ingredient
     - color    GREEN
)