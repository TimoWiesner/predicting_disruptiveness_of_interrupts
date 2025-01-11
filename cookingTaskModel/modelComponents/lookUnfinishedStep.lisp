;; lookUnfinishedStep
(p find-unfinished-recipe-step
    =goal>
     ISA        cooking
     step       find-next-step
==>
    +visual-location>
     ISA        visual-location
     screen-y   376
     screen-x   lowest
     - color    GREEN
    =goal>
     ISA        cooking
     step       attend-recipe-step-ingredient
)

(p attend-recipe-step-ingredient
    =goal>
     ISA        cooking
     step       attend-recipe-step-ingredient
    =visual-location>
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        cooking
     step       remember-recipe-step-ingredient
)

(p remember-recipe-step-ingredient
    =goal>
     ISA        cooking
     step       remember-recipe-step-ingredient
    =visual>
     ISA        visual-object
     value      =ingredient
    ?imaginal>
     state      free
==>
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
    +imaginal>
     ISA        recipe-step
     ingredient =ingredient
    =goal>
     ISA        cooking
     step       attend-recipe-step-preparation
)

(p attend-recipe-step-preparation
    =goal>
     ISA        cooking
     step       attend-recipe-step-preparation
    =visual-location>
    ?visual>
     state      free
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        cooking
     step       remember-recipe-step-preparation
)

(p remember-recipe-step-preparation
    =goal>
     ISA        cooking
     step       remember-recipe-step-preparation
    =visual>
     ISA        visual-object
     value      =preparation
    =imaginal>
     ISA        recipe-step
==>
    =imaginal>
     preparation =preparation
     status     "ToDo"
    =goal>
     ISA        cooking
     step       look-out-for-suggestion
)