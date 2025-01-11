;; rememberRecipe
(p start-looking
    =goal>
     ISA        cooking
     step       look-around
==>
    =goal>
     step       attend-recipe
    +visual-location>
     ISA        visual-location
     value      "Recipe:"
)

(p attend-recipe
    =goal>
     ISA        cooking
     step       attend-recipe
    =visual-location>
    ?visual>
     state      free
==>
    =goal>
     step       find-recipe-name
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
)

(p find-recipe
    =goal>
     ISA        cooking
     step       find-recipe-name
    =visual>
     ISA        visual-object
==>
    =goal>
     step       attend-recipe-name
    +visual-location>
      ISA       visual-location
     > screen-x current
     screen-x   lowest
     screen-y   current
)

(p attend-recipe-name
    =goal>
     ISA        cooking
     step       attend-recipe-name
    =visual-location>
    ?visual>
     state      free
    ?imaginal>
     state      free
==>
    +imaginal>
     ISA        recipe
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =goal>
     ISA        cooking
     step       remember-recipe
)

(p remember-recipe
    =goal>
     ISA        cooking
     step       remember-recipe
    =visual>
     ISA        visual-object
     value      =recipe
    =imaginal>
     ISA        recipe
==>
    =imaginal>
     ISA        recipe
     name       =recipe
     ing1       N
     prep1      N
     ing2       N
     prep2      N
     ing3       N
     prep3      N
     ing4       N
     prep4      N
    =goal>
     ISA        cooking
     step       connect-recipe-to-steps
)