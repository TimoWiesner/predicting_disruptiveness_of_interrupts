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
