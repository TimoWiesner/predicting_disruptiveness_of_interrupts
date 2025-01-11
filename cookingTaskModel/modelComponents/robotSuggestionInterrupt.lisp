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