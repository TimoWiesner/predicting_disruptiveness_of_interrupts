;; addRecipeStepsToRecipe
(p connect-recipe-to-steps
    =goal>
     ISA        cooking
     step       connect-recipe-to-steps
    =imaginal>
     ISA        recipe
     name       =recipe
==>
    =goal>
     ISA        cooking
     step       find-recipe-step
    =imaginal>
)

(p find-first-step
    =goal>
     ISA        cooking
     step       find-recipe-step
==>
    +visual-location>
     ISA        visual-location
     screen-y   376
     screen-x   lowest
    =goal>
     ISA        cooking
     step       attend-recipe-step
)

(p attend-step
    =goal>
     ISA        cooking
     step       attend-recipe-step
    =visual-location>
==>
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        cooking
     step       add-step
)


(p add-first-recipe-step-ing
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =ingredient
    =imaginal>
     ISA        recipe
     ing1       N
     prep1      N
     ing2       N
     prep2      N
     ing3       N
     prep3      N
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     ing1       =ingredient
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p add-first-recipe-step-prep
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =preparation
    =imaginal>
     ISA        recipe
     prep1      N
     ing2       N
     prep2      N
     ing3       N
     prep3      N
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     prep1      =preparation
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)


(p add-second-recipe-step-ing
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =ingredient
    =imaginal>
     ISA        recipe
     ing2       N
     prep2      N
     ing3       N
     prep3      N
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     ing2       =ingredient
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p add-second-recipe-step-prep
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =preparation
    =imaginal>
     ISA        recipe
     prep2      N
     ing3       N
     prep3      N
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     prep2      =preparation
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p add-third-recipe-step-ing
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =ingredient
    =imaginal>
     ISA        recipe
     ing3       N
     prep3      N
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     ing3       =ingredient
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p add-third-recipe-step-prep
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =preparation
    =imaginal>
     ISA        recipe
     prep3      N
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     prep3      =preparation
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p add-fourth-recipe-step-ing
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =ingredient
    =imaginal>
     ISA        recipe
     ing4       N
     prep4      N
==>
    =goal>
     step       attend-recipe-step
    =imaginal>
     ISA        recipe
     ing4       =ingredient
    +visual-location>
     ISA        visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p add-fourth-recipe-step-prep
    =goal>
     ISA        cooking
     step       add-step
    =visual>
     ISA        visual-object
     value      =preparation
    =imaginal>
     ISA        recipe
     prep4      N
==>
    =goal>
     step       finish-connecting
    =imaginal>
     ISA        recipe
     prep4      =preparation
)

(p finish-connecting
    =goal>
     ISA        cooking
     step       finish-connecting
    =imaginal>
     ISA        recipe
==>
    =goal>
     step       look-out-for-suggestion
    -imaginal>
)