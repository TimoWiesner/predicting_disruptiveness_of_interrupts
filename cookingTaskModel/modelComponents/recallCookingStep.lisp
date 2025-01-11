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
     :recently-retrieved nil
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