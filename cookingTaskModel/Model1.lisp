;; remembers correct recipe steps and compares

(clear-all)

(define-model cookingModel
(sgp :show-focus t :esc t :egs 0.5  :bll .5 :ans .2 :lf .05)
(install-device '("motor" "cursor" "mouse"))

(chunk-type ingredient ingredient)
(chunk-type preparation preparation)
(chunk-type recipe name ing1 prep1 ing2 prep2 ing3 prep3 ing4 prep4)

(chunk-type recipe-step recipe ingredient preparation status)


(chunk-type cooking step status location ignore)
(chunk-type suggestion step status location ignore)


(add-dm
 (bread ISA ingredient ingredient bread)
 (salad ISA ingredient ingredient salad)
 (meat ISA ingredient ingredient meat)
 (onion ISA ingredient ingredient onion)
 (tomato ISA ingredient ingredient tomato)

 (cook ISA preparation preparation cook)
 (cut ISA preparation preparation cut)
 (mix ISA preparation preparation mix)

 (cookingTask ISA cooking step look-around status n location n ignore n)

)


(goal-focus cookingTask)

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


;; cookIngredient
(p start-cooking-step
    =goal>
     ISA        cooking
     step       find-next-step
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
==>
    +visual-location>
     ISA        visual-location
     screen-y   459
     value      =ingredient
     kind       OVAL
    =goal>
     ISA        cooking
     step       attend-step-ing
    =imaginal>
)

(p attend-cooking-step-ing
    =goal>
     ISA        cooking
     step       attend-step-ing
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
     step       motor-action-ing
    =visual-location>
)

(p remember-target-location-ing
    =goal>
     ISA        cooking
     step       motor-action-ing
     location   n
    =visual>
     ISA        visual-object
     screen-pos =location
==>
    =goal>
     step       move-mouse-ing
     location   =location
)

(p move-mouse-ing
    =goal>
     ISA        cooking
     step       move-mouse-ing
     location   =location
    ?manual>
     state      free
==>
    =goal>
     step       check-clickable-ing-attend
     location   n
    +manual>
     ISA        move-cursor
     cmd        move-cursor
     loc        =location

)
;; wait loop, til the button is clickable again
(p check-clickable-ing-attend
    =goal>
     ISA        cooking
     step       check-clickable-ing-attend
    =visual-location>
==>
    =goal>
     step       check-clickable-ing
    +visual>
     ISA        move-attention
     cmd        move-attention
     screen-pos =visual-location
    =visual-location>
)

(p check-clickable-ing
    =goal>
     ISA        cooking
     step       check-clickable-ing
    =visual>
     ISA        visual-object
     color      RED
==>
    =goal>
     step       wait-clickable-ing
)

(p wait-clickable-ing
    =goal>
     ISA        cooking
     step       wait-clickable-ing
==>
    =goal>
     step       check-clickable-ing-attend
)

(p click-ing
    =goal>
     ISA        cooking
     step       check-clickable-ing
    =visual>
     ISA        visual-object
     - color    RED
    ?manual>
     state      free
==>
    =goal>
     step       wait-for-click-ing
    +manual>
     ISA        click-mouse
     cmd        click-mouse
)

(p wait-for-click-ing
   =goal>
      isa      cooking
      step     wait-for-click-ing
   ?manual>
      state    free
  ==>
   =goal>
      step    look-out-for-suggestion
      status  t
)


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
     status     nil
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


;; robotSuggestionInterrupt
(p look-out-for-suggestion
    =goal>
     ISA        cooking
     step       look-out-for-suggestion
     ignore     n
==>
    =goal>
     ISA        cooking
     step       suggestion-found
    +visual-location>
     ISA        visual-location
     screen-y   559
)

(p look-out-for-suggestion-ignore
    =goal>
     ISA        cooking
     step       look-out-for-suggestion
     ignore     t
==>
    =goal>
     ISA        cooking
     step       find-next-step
)

(p suggestion-found-failure
    =goal>
     ISA        cooking
     step       suggestion-found
    ?visual-location>
     state      error
==>
    =goal>
     ISA        cooking
     step       find-next-step
)

(p suggestion-found
    =goal>
     ISA        cooking
     step       suggestion-found
    =visual-location>
     ISA        visual-location
==>
    =goal>
     ISA        cooking
     step       save-step
    -imaginal>
)

;; saveCookingStep
(p save-cooking-step
    =goal>
     ISA        cooking
     step       save-step
    ?imaginal>
     state      free
==>
    =goal>
     step       store-step
    +imaginal>
     ISA        cooking
)

(p store-cooking-step
    =goal>
     ISA        cooking
     step       store-step
     status     =goal-status
     location   =goal-location
     ignore     =goal-ignore
    =imaginal>
     ISA        cooking
==>
    =goal>
     ISA        suggestion
     step       find-suggestion
     status     n
     location   n
     ignore     =goal-ignore
    =imaginal>
     ISA        cooking
     step       find-next-step
     status     =goal-status
     location   =goal-location
    -imaginal>
)


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
     step       look-recipe-recall
)


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


;; compareSteps
(p compare-steps
    =goal>
     ISA        suggestion
     step       find-next-step-sugg
    =imaginal>
     ISA        recipe-step
    ?retrieval>
     buffer     full
==>
    =goal>
     step       compare
    =imaginal>
)

(p compare-first
    =goal>
     ISA        suggestion
     step       compare
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
     preparation =preparation
    =retrieval>
     ISA        recipe
     ing1       =ingredient
     prep1      =preparation
==>
    =goal>
     step       decision-accept
)

(p compare-second
    =goal>
     ISA        suggestion
     step       compare
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
     preparation =preparation
    =retrieval>
     ISA        recipe
     ing2       =ingredient
     prep2      =preparation
==>
    =goal>
     step       decision-accept
)

(p compare-third
    =goal>
     ISA        suggestion
     step       compare
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
     preparation =preparation
    =retrieval>
     ISA        recipe
     ing3       =ingredient
     prep3      =preparation
==>
    =goal>
     step       decision-accept
)

(p compare-fourth
    =goal>
     ISA        suggestion
     step       compare
    =imaginal>
     ISA        recipe-step
     ingredient =ingredient
     preparation =preparation
    =retrieval>
     ISA        recipe
     ing4       =ingredient
     prep4      =preparation
==>
    =goal>
     step       decision-accept
)

(p compare-failure
    =goal>
     ISA        suggestion
     step       compare
    =imaginal>
     ISA        recipe-step
    =retrieval>
     ISA        recipe
==>
    =goal>
     step       decision-decline
)

;; without comparing just ignore
(p compare-just-ignore
    =goal>
     ISA        suggestion
     step       find-next-step-sugg
    =imaginal>
     ISA        recipe-step
    ?retrieval>
     buffer     full
==>
    =goal>
     step       recall-cooking-step
     ignore     t
    -imaginal>
)



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


;; recallCookingStep
(p recall-cooking-step
    =goal>
     ISA        suggestion
     step       recall-cooking-step

==>
    =goal>
     step       return-to-cooking-step
    +retrieval>
     ISA        cooking
     step       find-next-step
)

(p return-to-cooking-step
    =goal>
     ISA        suggestion
     step       return-to-cooking-step
     ignore     =goal-ignore
    =retrieval>
     ISA        cooking
     step       =goal-step
     status     =goal-status
     location   =goal-location
==>
    =goal>
     ISA        cooking
     step       =goal-step
     status     =goal-status
     location   =goal-location
     ignore     =goal-ignore
)

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
     location   n                       ;;?
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

;; prefere cooking, when step in imaginal
(spp start-cooking-step :u 1)
(spp continue-cooking-step :u 3)

;; connect steps with recipe
(spp add-first-recipe-step-ing :u 8)
(spp add-first-recipe-step-prep :u 7)
(spp add-second-recipe-step-ing :u 6)
(spp add-second-recipe-step-prep :u 5)
(spp add-third-recipe-step-ing :u 4)
(spp add-third-recipe-step-prep :u 3)
(spp add-fourth-recipe-step-ing :u 2)
(spp add-fourth-recipe-step-prep :u 1)

;; prefer compare, when retrieved recipe


;; compare utilities
(spp compare-just-ignore :u 0.5)
(spp compare-steps :u 1)
(spp compare-failure :u -1)

)