;; lookAtSuggestion
(p look-at-suggestion
    =goal>
     ISA        suggestion
     step       find-suggestion
==>
    =goal>
     step       attend-suggestion
    +visual-location>
     ISA        visual-location
     value      "suggestion:"
)

(p attend-suggestion
    =goal>
     ISA        suggestion
     step       attend-suggestion
    =visual-location>
    ?imaginal>
     state      free
    ?visual>
     state      free
==>
    =goal>
     step       find-suggestion-ing
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    +imaginal>
     ISA        recipe-step
)

(p find-suggestion-ing
    =goal>
     ISA        suggestion
     step       find-suggestion-ing
    =visual>
     ISA        visual-object
==>
    =goal>
     step       attend-suggestion-ing
    +visual-location>
      ISA       visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p attend-suggestion-ing
    =goal>
     ISA        suggestion
     step       attend-suggestion-ing
    =visual-location>
    ?visual>
     state      free
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     step       remember-suggestion-ing
)

(p remember-suggestion-ing
    =goal>
     ISA        suggestion
     step       remember-suggestion-ing
    =visual>
     ISA        visual-object
     value      =ingredient
    =imaginal>
     ISA        recipe-step
==>
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
    =goal>
     step       find-suggestion-prep
    =visual>
)

(p find-suggestion-prep
    =goal>
     ISA        suggestion
     step       find-suggestion-prep
    =visual>
     ISA        visual-object
==>
    =goal>
     step       attend-suggestion-prep
    +visual-location>
      ISA       visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p attend-suggestion-prep
    =goal>
     ISA        suggestion
     step       attend-suggestion-prep
    =visual-location>
    ?visual>
     state      free
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     step       remember-suggestion-prep
)

(p remember-suggestion-prep
    =goal>
     ISA        suggestion
     step       remember-suggestion-prep
    =visual>
     ISA        visual-object
     value      =preparation
    =imaginal>
     ISA        recipe-step
==>
    =imaginal>
     ISA        recipe-step
     preparation =preparation
    =goal>
     step       find-next-step-sugg
)
