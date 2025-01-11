;; recallRecipeSteps
(p look-at-recipe-recall
    =goal>
     ISA        suggestion
     step       look-recipe-recall
    ?retrieval>
     buffer     empty
     state      free
==>
    =goal>
     step       attend-recipe-sugg
    +visual-location>
     ISA        visual-location
     value      "Recipe:"
)
(p attend-recipe-recall
    =goal>
     ISA        suggestion
     step       attend-recipe-sugg
    =visual-location>
    ?visual>
     state      free
==>
    =goal>
     step       find-recipe-name-sugg
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
)

(p find-recipe-recall
    =goal>
     ISA        suggestion
     step       find-recipe-name-sugg
    =visual>
     ISA        visual-object
==>
    =goal>
     step       attend-recipe-name-sugg
    +visual-location>
      ISA       visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p attend-recipe-name-recall
    =goal>
     ISA        suggestion
     step       attend-recipe-name-sugg
    =visual-location>
    ?visual>
     state      free
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        suggestion
     step       remember-recipe-recall
)

(p recipe-recall
    =goal>
     ISA        suggestion
     step       remember-recipe-recall
    =visual>
     ISA        visual-object
     value      =recipe
==>
    =goal>
     ISA        suggestion
     step       find-next-step-sugg
    +retrieval>
     ISA        recipe
     name       =recipe
)