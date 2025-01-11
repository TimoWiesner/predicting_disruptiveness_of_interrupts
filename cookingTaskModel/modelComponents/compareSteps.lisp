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