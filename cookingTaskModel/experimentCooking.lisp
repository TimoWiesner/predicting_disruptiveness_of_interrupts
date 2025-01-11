; lisp version of the cooking expirement
;          by Timo Wiesner
;        Universität zu Lübeck

; load act-r-model to perform the task
(load-act-r-model "ACT-R:cookingTaskModel;Model2.lisp")


;################################################################################################################
;                         Init
;################################################################################################################

; init variables
; display variables
(defvar *visible* nil)
(defvar *window* nil)
(defvar *step1Ing* nil)
(defvar *step2Ing* nil)
(defvar *step3Ing* nil)
(defvar *step4Ing* nil)
(defvar *step1Prep* nil)
(defvar *step2Prep* nil)
(defvar *step3Prep* nil)
(defvar *step4Prep* nil)
(defvar *recipeTag* nil)
(defvar *recipe-name* nil)
(defvar *bread* nil)
(defvar *lettuce* nil) 
(defvar *meat* nil) 
(defvar *onion* nil) 
(defvar *tomato* nil) 
(defvar *cook* nil)
(defvar *cut* nil) 
(defvar *mix* nil)
(defvar *robot* nil)
(defvar *suggestionIng* nil)
(defvar *suggestionPrep* nil)
(defvar *accept* nil)
(defvar *decline* nil)
(defvar *succesfullyCompleted* nil)
(defvar *doneText* nil)
(defvar *continueBtn* nil)


; logic Variables
(defvar *currentIng* nil)
(defvar *currentPrep* nil)
(defvar *robotIng* nil)
(defvar *robotPrep* nil)
(defvar *currNumRecipes* nil)
(defvar *numRecipes* nil)
(defvar *tmpRecipe* nil)
(defvar *experimentRun* nil)
(defvar *done* nil)
(defvar *realisticRobot* nil)
(defvar *recipeOrder* nil)


; timer variables
(defvar *robotRandomWait* nil)
(defvar *waitDuration* nil)


; screen update variables
(defvar *step1Done* nil)
(defvar *step2Done* nil)
(defvar *step3Done* nil)
(defvar *step4Done* nil)
(defvar *buttonClicked* nil)
(defvar *buttonTimerDone* nil)
(defvar *activeTimer* nil)
(defvar *newSuggestion* nil)
(defvar *suggestionDone* nil)
(defvar *activeSuggestion* nil)
(defvar *recipeDone* nil)
(defvar *nextRecipe* nil)
(defvar *displayContinue* nil)
(defvar *experimentFinished* nil)


; data variables
(defvar *trialStartTime* nil)


; define data-types
(defstruct recipe name steps)
(defstruct recipe-step ingredient preparation status)

; define recipes
(defparameter *recipes* 
  (list (make-recipe :name "soup" 
                     :steps (list (make-recipe-step :ingredient "tomato" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "tomato" :preparation "mix" :status "ToDo")
                                  (make-recipe-step :ingredient "tomato" :preparation "mix" :status "ToDo")
                                  (make-recipe-step :ingredient "meat" :preparation "cut" :status "ToDo")))
        (make-recipe :name "salad" 
                     :steps (list (make-recipe-step :ingredient "tomato" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "lettuce" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "tomato" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "onion" :preparation "cut" :status "ToDo")))
        (make-recipe :name "hamburger" 
                     :steps (list (make-recipe-step :ingredient "bread" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "lettuce" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "tomato" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "meat" :preparation "cook" :status "ToDo")))
        (make-recipe :name "meatballs" 
                     :steps (list (make-recipe-step :ingredient "meat" :preparation "cook" :status "ToDo")
                                  (make-recipe-step :ingredient "tomato" :preparation "mix" :status "ToDo")
                                  (make-recipe-step :ingredient "onion" :preparation "cut" :status "ToDo")
                                  (make-recipe-step :ingredient "bread" :preparation "mix" :status "ToDo")))))


; input for robot suggestions
; define Ingredient and Preparation list for the random robot suggestion
(defvar *ingredientList* (list "bread" "lettuce" "meat" "onion" "tomato"))
(defvar *preparationList* (list "cook" "cut" "mix"))

; define list of real cooking steps for realistic suggestion
(defvar *realisticSteps* (list (list "tomato" "cut") (list "tomato" "mix") (list "meat" "cut") (list "lettuce" "cut") (list "onion" "cut") (list "bread" "cut") (list "meat" "cook") (list "bread" "mix")))

;################################################################################################################
;                         Experiment
;################################################################################################################

; experiment main function
(defun do-experiment (human realisticRobot)
  (setf *experimentRun* t)
  ; experiment init
  (init-experiment realisticRobot)
  (if human
      (when (visible-virtuals-available?)
        ; experiment for human testing
        (wait-for-human))
    ; experiment for model testing
    (wait-for-model)
  )
)

; experiment init
(defun init-experiment (realisticRobot)
  ; init variables
  (setf *done* nil)
  (setf *currNumRecipes* 1)
  (setf *numRecipes* 8)
  (setf *realisticRobot* realisticRobot)
  ; choose start recipe
  (setf *tmpRecipe* (choose-random-recipe))
  (log-recipe *tmpRecipe*)
  (log-robot)
  ; display recipe
  (create-display-items *tmpRecipe*)
  (add-base-items-to-display)
  ; start trial timer
  (setf *trialStartTime* (get-time nil))
  (log-start)
  ; start robot suggestion process
  (start-robot-suggestion-process)
)

; experiment for model testing
(defun wait-for-model ()
  (install-device *window*)
  (start-hand-at-mouse)
  ; visual update of ui
  (update-screen-loop)
)

; experiment for human testing
(defun wait-for-human ()
  ; visual update for ui
  (update-screen-loop-human)
  (while (not *done*)
    (process-events))
  ;; wait for 1 second to pass after done
  (let ((start-time (get-time nil)))
    (while (< (- (get-time nil) start-time) 1000)
      (process-events)
    )
  )
)


;################################################################################################################
;                         Experiment logic functions
;################################################################################################################


; button actions
; ingredient button
(defun click-ingredient (ing)
  (log-click-ingredient ing)
  ; select ingredient
  (setf *currentIng* ing)
  (setf *buttonClicked* t)
  ; activate cooldown
  (two-sec-timer)
)

; preparation button
(defun click-preparation (prep)
  (log-click-preparation prep)
  ; select preparation
  (setf *currentPrep* prep)
  ; check ingredient preparation combo
  (check-step *tmpRecipe* *currentIng* *currentPrep*)
  (setf *buttonClicked* t)
  ; activate cooldown
  (five-sec-timer)
  ; unselect step
  (setf *currentIng* nil)
  (setf *currentPrep* nil)
)

; robot accept button
(defun accept-robot ()
  ; handle attended suggestion
  (log-robot-sugg-accept *robotIng* *robotPrep*)
  (setf *suggestionDone* t)
  (setf *activeSuggestion* nil)
  ; check accepted robot suggestion step
  (check-step *tmpRecipe* *robotIng* *robotPrep*)
  ; start new robot suggestion process
  (start-robot-suggestion-process)
)

; robot decline button
(defun decline-robot ()
  ; handle attended suggestion
  (log-robot-sugg-decline *robotIng* *robotPrep*)
  (setf *suggestionDone* t)
  (setf *activeSuggestion* nil)
  (setf *buttonClicked* t)
  ; activate cooldown
  (one-sec-timer)
  ; start new robot suggestion process
  (start-robot-suggestion-process)
)
; placeholder function for disabled buttons
(defun click-disabled ()
  (log-click-disabled-btn)
)

; continue button after completed recipe
(defun continue-cooking ()
  ; choose new recipe
  (setf *tmpRecipe* (choose-random-recipe))
  (setf *nextRecipe* t)
  ; keep track of completed recipes
  (incf *currNumRecipes*)
  ; start new recipe
  (log-recipe *tmpRecipe*)
  (log-robot)
  (setf *trialStartTime* (get-time nil))
  (log-start)
  (setf *done* nil)
  ; start robot suggestion process
  (start-robot-suggestion-process)
)

; add commands for the buttons
(add-act-r-command "click-ingredient" 'click-ingredient "Ingredient button action")
(add-act-r-command "click-preparation" 'click-preparation "Preparation button action")
(add-act-r-command "accept-robot" 'accept-robot "Accept robot offer button action")
(add-act-r-command "decline-robot" 'decline-robot "Decline robot offer action")
(add-act-r-command "click-disabled" 'click-disabled "An empty function for disabled buttons")
(add-act-r-command "continue-cooking" 'continue-cooking "A button function to start the next recipe or end the experiment")


; logic functions
; check and mark the recipe step with the given ingredient and preparation as 'Done' and modifies the corresponding step in the recipe and updates the ui, if all steps are marked 'Done', the recipe is considered finished
(defun check-step (recipe ing prep)
  (let ((step-marked nil))  ; flag to indicate if a step has been marked
    ;; loop through each step in the recipe
    (dolist (step-index (loop for step in (recipe-steps recipe)
                              for i from 1
                              collect (list step i)))
      (let ((step (first step-index))
            (index (second step-index)))
        ;; check if the step matches the ingredient and preparation and has status "ToDo"
        (when (and (not step-marked)
                   (string= (recipe-step-ingredient step) ing)
                   (string= (recipe-step-preparation step) prep)
                   (string= (recipe-step-status step) "ToDo"))
          ;; mark step as "Done"
          (setf (recipe-step-status step) "Done")

          ;; log the step as done
          (log-step-done ing prep)
          
          ;; update the ui for the corresponding step
          (ecase index
            (1 (setf *step1Done* t))
            (2 (setf *step2Done* t))
            (3 (setf *step3Done* t))
            (4 (setf *step4Done* t)))
          
          ;; set the flag to indicate a step has been marked as "Done"
          (setf step-marked t))))

    ;; check if all steps are marked "Done"
    (when (every (lambda (s) (string= (recipe-step-status s) "Done"))
                 (recipe-steps recipe))
      ;; if all steps are "Done", call the finish-recipe function
      (finish-recipe))))

; random robot suggestion
(defun random-robot-suggestion (ingredients preparations)
  ; generate random suggestion and return
  (let ((ingredient (nth (random (length ingredients)) ingredients))
        (preparation (nth (random (length preparations)) preparations)))
    (list ingredient preparation)))

; realistic robot suggestion
(defun realistic-robot-suggestion (realisticSteps)
  ; select realistic step out of the list and return
  (let ((realStep (nth (random (length realisticSteps)) realisticSteps)))
  (list (first realStep) (second realStep)))
)

;; random wait robot suggestion
(defun random-wait-suggestion ()
    ;; seed the random number generator
     (let ((*random-state* (make-random-state t)))
       
      ;; start wait for random ammount between 2 and 10
      (setf *robotRandomWait* (+ 2 (random 8)))
     )
)

; useful wait function, duration in seconds
(defun wait-until-time-passed (duration)
  (sleep duration)
)

; function to generate and display a new suggestion after the random robot wait is done
(defun handle-suggestion ()
  (wait-until-time-passed *robotRandomWait*) ;; wait until the time is passed
  ; prevent suggestions after recipe completion
  (when (not *done*)
    ; seed for random number generator
    (let ((*random-state* (make-random-state t)))
      ;; call robot-suggestion and store the result
      (let ((suggestion (if *realisticRobot* 
                            (realistic-robot-suggestion *realisticSteps*) ; realistic suggestion
                          (random-robot-suggestion *ingredientList* *preparationList*)) ; random suggestion
            ))
        ;; set robot suggestion variables
        (setf *robotIng* (first suggestion))
        (setf *robotPrep* (second suggestion))
        (setf *newSuggestion* t)
        ;; log the suggestion
        (log-robot-sugg *robotIng* *robotPrep*)
        (setf *activeSuggestion* t)))))

; function for the suggestion
(defun start-robot-suggestion-process ()
  (random-wait-suggestion) ;; set a random wait time
  (bordeaux-threads:make-thread #'handle-suggestion)) ;; run the suggestion handler in a separate thread

; disable cooking buttons for cooldown
(defun disable-buttons ()
  (modify-button-for-exp-window *bread* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *lettuce* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *meat* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *tomato* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *onion* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *cook* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *cut* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *mix* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *continueBtn* :color 'red :action "click-disabled")
)

; disable robot buttons for cooldown
(defun disable-buttons-robot ()
  (modify-button-for-exp-window *accept* :color 'red :action "click-disabled")
  (modify-button-for-exp-window *decline* :color 'red :action "click-disabled")
)

; enable cooking buttons after cooldown
(defun enable-buttons ()
  (modify-button-for-exp-window *bread* :color 'light-gray :action (list "click-ingredient" "bread"))
  (modify-button-for-exp-window *lettuce* :color 'light-gray :action (list "click-ingredient" "lettuce"))
  (modify-button-for-exp-window *meat* :color 'light-gray :action (list "click-ingredient" "meat"))
  (modify-button-for-exp-window *tomato* :color 'light-gray :action (list "click-ingredient" "tomato"))
  (modify-button-for-exp-window *onion* :color 'light-gray :action (list "click-ingredient" "onion")) 
  (modify-button-for-exp-window *cook* :color 'light-gray :action (list "click-preparation" "cook"))
  (modify-button-for-exp-window *cut* :color 'light-gray :action (list "click-preparation" "cut"))
  (modify-button-for-exp-window *mix* :color 'light-gray :action (list "click-preparation" "mix"))
  (modify-button-for-exp-window *continueBtn* :color 'light-gray :action (list "continue-cooking"))
)

; enable robot buttons after cooldown
(defun enable-buttons-robot ()
  (modify-button-for-exp-window *accept* :color 'light-gray :action (list "accept-robot"))
  (modify-button-for-exp-window *decline* :color 'light-gray :action (list "decline-robot"))
)

; timer functions for cooldown
(defun start-timer (duration)
  (setf *activeTimer* t)
  (setf *waitDuration* duration)
  ;; start a thread to wait for the specified time and set the timer done flag
  (bordeaux-threads:make-thread
    (lambda ()
      (wait-until-time-passed *waitDuration*)
      (setf *buttonTimerDone* t)
      (setf *activeTimer* nil)
    )
  )
)


; 5 second timer for prep button
(defun five-sec-timer ()
  (start-timer 5)) ;; start a 5-second timer

; 2 second timer for ing button
(defun two-sec-timer ()
  (start-timer 2)) ;; start a 2-second timer 

; 1 second timer for robot decline
(defun one-sec-timer ()
  (start-timer 1)) ;; start a 1-second timer 

; when the recipe is done
(defun finish-recipe ()
 (log-task-done)
 (setf *recipeDone* t)
 (setf *done* t)
 ; if less then 8 recipes are completed continue task, else finish the experiment
 (if (< *currNumRecipes* *numRecipes*)
      (setf *displayContinue* t)
    (setf *experimentFinished* t)
 )
)


;################################################################################################################
;                         Display functions
;################################################################################################################


; create-display-items for first init of all needed items on the display
; it takes the first recipe and creates the items accordingly
(defun create-display-items (recipe)
  ; reset variables
  (setf *currentIng* nil)
  (setf *currentPrep* nil)
  ; init window
  (setf *window* (open-exp-window "clickTest" :visible *visible* :width 700 :height 500))
  (add-word-characters ":")
  (clear-exp-window *window*)

  ; get the first recipe from the list
  (let* ((step1 (first (recipe-steps recipe)))
         (step2 (second (recipe-steps recipe)))
         (step3 (third (recipe-steps recipe)))
         (step4 (fourth (recipe-steps recipe)))
         (step1IngText (recipe-step-ingredient step1))
         (step2IngText (recipe-step-ingredient step2))
         (step3IngText (recipe-step-ingredient step3))
         (step4IngText (recipe-step-ingredient step4))
         (step1PrepText (recipe-step-preparation step1))
         (step2PrepText (recipe-step-preparation step2))
         (step3PrepText (recipe-step-preparation step3))
         (step4PrepText (recipe-step-preparation step4)))

    ; create text
    ; recipe text
    (setf *recipeTag* (create-text-for-exp-window *window* "Recipe:" :x 10 :y 10))
    (setf *recipe-name* (create-text-for-exp-window *window* (recipe-name recipe) :x 60 :y 10))

    ; step texts
    (setf *step1Ing* (create-text-for-exp-window *window* step1IngText :x 60 :y 70))
    (setf *step1Prep* (create-text-for-exp-window *window* step1PrepText :x 120 :y 70))
    (setf *step2Ing* (create-text-for-exp-window *window* step2IngText :x 220 :y 70))
    (setf *step2Prep* (create-text-for-exp-window *window* step2PrepText :x 280 :y 70))
    (setf *step3Ing* (create-text-for-exp-window *window* step3IngText :x 380 :y 70))
    (setf *step3Prep* (create-text-for-exp-window *window* step3PrepText :x 440 :y 70))
    (setf *step4Ing* (create-text-for-exp-window *window* step4IngText :x 540 :y 70))
    (setf *step4Prep* (create-text-for-exp-window *window* step4PrepText :x 600 :y 70))

    ; create buttons
    ; ingredients
    (setf *bread* (create-button-for-exp-window *window* :text "bread" :x 100 :y 150 :action (list "click-ingredient" "bread")))
    (setf *lettuce* (create-button-for-exp-window *window* :text "lettuce" :x 200 :y 150 :action (list "click-ingredient" "lettuce")))
    (setf *meat* (create-button-for-exp-window *window* :text "meat" :x 300 :y 150 :action (list "click-ingredient" "meat")))
    (setf *onion* (create-button-for-exp-window *window* :text "onion" :x 400 :y 150 :action (list "click-ingredient" "onion")))
    (setf *tomato* (create-button-for-exp-window *window* :text "tomato" :x 500 :y 150 :action (list "click-ingredient" "tomato")))

    ; preparations
    (setf *cook* (create-button-for-exp-window *window* :text "cook" :x 200 :y 300 :action (list "click-preparation" "cook")))
    (setf *cut* (create-button-for-exp-window *window* :text "cut" :x 300 :y 300 :action (list "click-preparation" "cut")))
    (setf *mix* (create-button-for-exp-window *window* :text "mix" :x 400 :y 300 :action (list "click-preparation" "mix")))

    ; create robot suggestion text and buttons
    (setf *robot* (create-text-for-exp-window *window* "Robot suggestion:" :x 30 :y 200))
    (setf *suggestionIng* (create-text-for-exp-window *window* "bread" :x 200 :y 200))
    (setf *suggestionPrep* (create-text-for-exp-window *window* "cut" :x 260 :y 200))
    (setf *accept* (create-button-for-exp-window *window* :text "accept" :x 250 :y 250 :action (list "accept-robot")))
    (setf *decline* (create-button-for-exp-window *window* :text "decline" :x 350 :y 250 :action (list "decline-robot"))))

    ; finish screen of a succesful recipe
    (setf *succesfullyCompleted* (create-text-for-exp-window *window* "Recipe completed!" :x 350 :y 250 :font-size 30))
    (setf *doneText* (create-text-for-exp-window *window* "Done!" :x 400 :y 300 :font-size 30))
    (setf *continueBtn* (create-button-for-exp-window *window* :text "continue" :x 400 :y 400 :action (list "continue-cooking")))
)

; initially displayed items
(defun add-base-items-to-display ()
  (add-items-to-exp-window *window* *recipeTag* *recipe-name* *step1Ing* *step2Ing* *step3Ing* *step4Ing* *step1Prep* *step2Prep* *step3Prep* *step4Prep* *bread* *lettuce* *meat* *onion* *tomato* *cook* *cut* *mix* *robot*)
)

; display the next recipe
(defun load-next-recipe (recipe)
  (let* ((step1 (first (recipe-steps recipe)))
         (step2 (second (recipe-steps recipe)))
         (step3 (third (recipe-steps recipe)))
         (step4 (fourth (recipe-steps recipe)))
         (step1IngText (recipe-step-ingredient step1))
         (step2IngText (recipe-step-ingredient step2))
         (step3IngText (recipe-step-ingredient step3))
         (step4IngText (recipe-step-ingredient step4))
         (step1PrepText (recipe-step-preparation step1))
         (step2PrepText (recipe-step-preparation step2))
         (step3PrepText (recipe-step-preparation step3))
         (step4PrepText (recipe-step-preparation step4)))

    ; modify text
    ; recipe
    (modify-text-for-exp-window *recipe-name* :text (recipe-name recipe))

    ; step texts
    (modify-text-for-exp-window *step1Ing* :text step1IngText :color 'black)
    (modify-text-for-exp-window *step1Prep* :text step1PrepText :color 'black)
    (modify-text-for-exp-window *step2Ing* :text step2IngText :color 'black)
    (modify-text-for-exp-window *step2Prep* :text step2PrepText :color 'black)
    (modify-text-for-exp-window *step3Ing* :text step3IngText :color 'black)
    (modify-text-for-exp-window *step3Prep* :text step3PrepText :color 'black)
    (modify-text-for-exp-window *step4Ing* :text step4IngText :color 'black)
    (modify-text-for-exp-window *step4Prep* :text step4PrepText :color 'black)
  )
)

; display suggestion
(defun display-robot-suggestion (ingredient preparation)
  (modify-text-for-exp-window *suggestionIng* :text ingredient)
  (modify-text-for-exp-window *suggestionPrep* :text preparation)
  (add-items-to-exp-window *window* *suggestionIng* *suggestionPrep* *accept* *decline*)
)

; display continue button
(defun display-continue-btn()
  (add-items-to-exp-window *window* *continueBtn*)
)

; display DONE, to symbolize, the experiment is finished
(defun finish-experiment ()
  (add-items-to-exp-window *window* *doneText*)
  ; finish the experiment run
  (setf *experimentRun* nil)
)

; modification of the text color to symbolize that the step is completed (step1) 
(defun display-step1-done ()
  (modify-text-for-exp-window *step1Ing* :color 'green)
  (modify-text-for-exp-window *step1Prep* :color 'green)
)

; modification of the text color to symbolize that the step is completed (step2) 
(defun display-step2-done ()
  (modify-text-for-exp-window *step2Ing* :color 'green)
  (modify-text-for-exp-window *step2Prep* :color 'green)
)

; modification of the text color to symbolize that the step is completed (step3) 
(defun display-step3-done ()
  (modify-text-for-exp-window *step3Ing* :color 'green)
  (modify-text-for-exp-window *step3Prep* :color 'green)
)

; modification of the text color to symbolize that the step is completed (step4) 
(defun display-step4-done ()
  (modify-text-for-exp-window *step4Ing* :color 'green)
  (modify-text-for-exp-window *step4Prep* :color 'green)
)

; a function to handle all screen updates correspondingly
(defun update-screen ()

  (when *step1Done*
    (display-step1-done)
    (setf *step1Done* nil)
  )

  (when *step2Done*
    (display-step2-done)
    (setf *step2Done* nil)
  )

  (when *step3Done*
    (display-step3-done)
    (setf *step3Done* nil)
  )

  (when *step4Done*
    (display-step4-done)
    (setf *step4Done* nil)
  )

  (when *buttonClicked*
    (disable-buttons)
    (if *activeSuggestion*
      (disable-buttons-robot)
    )
    (setf *buttonClicked* nil)
  )

  (when *buttonTimerDone*
    (enable-buttons)
    (if *activeSuggestion*
      (enable-buttons-robot)
    )
    (setf *buttonTimerDone* nil)
  )

  (when *newSuggestion*
    (display-robot-suggestion *robotIng* *robotPrep*)
    (if *activeTimer*
      (disable-buttons-robot)
    )
    (setf *newSuggestion* nil)
  )

  (when *suggestionDone*
    (remove-items-from-exp-window *window* *suggestionIng* *suggestionPrep* *accept* *decline*)
    (setf *suggestionDone* nil)
  )

  (when *recipeDone*
    (remove-items-from-exp-window *window* *recipeTag* *recipe-name* *step1Ing* *step2Ing* *step3Ing* *step4Ing* *step1Prep* *step2Prep* *step3Prep* *step4Prep* *bread* *lettuce* *meat* *onion* *tomato* *cook* *cut* *mix* *robot*)
    (if *activeSuggestion* 
      (remove-items-from-exp-window *window* *suggestionIng* *suggestionPrep* *accept* *decline*)
    )
    (add-items-to-exp-window *window* *succesfullyCompleted*)
    (setf *recipeDone* nil)
  )

  (when *displayContinue*
    (display-continue-btn)
    (setf *displayContinue* nil)
  )

  (when *nextRecipe*
    (remove-items-from-exp-window *window* *continueBtn* *succesfullyCompleted*)
    (load-next-recipe *tmpRecipe*)
    (add-base-items-to-display)
    (setf *nextRecipe* nil)
  )

  (when *experimentFinished*
    (finish-experiment)
    (setf *experimentFinished* nil)
  )
  
)


;################################################################################################################
;                         Seperate Thread for Timer/Suggestion check-up
;################################################################################################################

; update screen in a short loop to avoid semaphore deadlocks regarding the timer threads (model)
(defun update-screen-loop ()
  (bt:make-thread
   (lambda ()
      (while *experimentRun*
        (update-screen)
        ; run act-r
        (run 0.05 t)
      )
    )
  )
)

; update screen in a short loop to avoid semaphore deadlocks regarding the timer threads (human)
(defun update-screen-loop-human ()
  (bt:make-thread
   (lambda ()
      (while *experimentRun*
        (update-screen)
        ; wait for screen update
        (sleep 0.05)
      )
    )
  )
)


;###############################################################################################################
;                         Logging functions
;###############################################################################################################



; Data collection functions
(defun save-text-to-file (text)
  "Save the given string to a .txt file at the specified filepath. 
   Append to the file if it exists, otherwise create it."
  (let ((filepath (format nil "LispExperiment2/data/meta~d.txt" *currNumRecipes*)))
    (with-open-file (stream filepath
                           :direction :output
                           :if-exists :append  ;; Append if file exists
                           :if-does-not-exist :create)  ;; Create if it doesn't exist
      (format stream "~a~%" text) ;; Append the string followed by a newline
    )
  )
)  

(defun log-recipe (recipe)
  (let* ((formatted-steps (mapcar (lambda (step)
                                    (format nil "(~a, ~a)"
                                            (recipe-step-ingredient step)
                                            (recipe-step-preparation step)))
                                  (recipe-steps recipe)))
         (steps-string (reduce (lambda (a b)
                                 (concatenate 'string a ", " b))
                               formatted-steps)))
    ;; Now build the full text to log
    (let ((text (format nil "Recipe = ~a ~a~%" (recipe-name recipe) steps-string)))
      (save-text-to-file text))))

(defun log-robot ()
  (let ((text (if *realisticRobot*
                (format nil "Robot = Realistic robot")
              (format nil "Robot = Random robot~%"))))
    (save-text-to-file text)
  )
)

(defun log-start ()
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] Task started~%" timeInTrial)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-click-ingredient (ing)
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] Ingredient selected: ~a~%" timeInTrial ing)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-click-preparation (prep)
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] Preparation selected: ~a~%" timeInTrial prep)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-click-disabled-btn ()
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] !!disabled button clicked!!~%" timeInTrial)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-robot-sugg (robotIng robotPrep)
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] new robot offer presented: (~a,~a)~%" timeInTrial robotIng robotPrep)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-robot-sugg-decline (robotIng robotPrep)
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] robot offer declined: (~a,~a)~%" timeInTrial robotIng robotPrep)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-robot-sugg-accept (robotIng robotPrep)
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (- currentTime *trialStartTime*)))
      (let ((text (format nil "[~d] robot offer accepted: (~a,~a)~%" timeInTrial robotIng robotPrep)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-step-done (ing prep)
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (+ (- currentTime *trialStartTime*) 5000))) ;; add 5000ms to simulate the preparation time in log until step is really completed
      (let ((text (format nil "[~d] step (~a,~a) done~%" timeInTrial ing prep)))
        (save-text-to-file text)
      )     
    )
  )
)

(defun log-task-done ()
  (let ((currentTime (get-time nil)))
    (let ((timeInTrial (+ (- currentTime *trialStartTime*) 5000))) ;; add 5000ms to simulate the preparation time in log until recipe is really completed
      (let ((score (float (/ timeInTrial 1000))))
        (setf score (- 60 score))
        (let ((text (format nil "[~d] Task done!~%Score = ~d~%" timeInTrial score)))
          (save-text-to-file text)
        )
      )     
    )
  )
)

;################################################################################################################
;                         Useful functions
;################################################################################################################


; function to copy all the steps exactly from the recipe list
(defun deep-copy-recipe (recipe)
  (make-recipe
   :name (recipe-name recipe)
   :steps (mapcar (lambda (step)
                    (make-recipe-step
                     :ingredient (recipe-step-ingredient step)
                     :preparation (recipe-step-preparation step)
                     :status (recipe-step-status step)))
                  (recipe-steps recipe))))

; choose a random recipe of the list
(defun choose-random-recipe ()
  ; if list is empty, re-initialize recipe list
  (when (null *recipeOrder*)
    (initialize-recipe-order))
  (deep-copy-recipe (pop *recipeOrder*)))

; shuffles a list randomly
(defun shuffle-list (list)
  (let ((copy (copy-list list)))
    (loop for i from (length copy) downto 2
          do (rotatef (nth (1- i) copy) (nth (random i) copy)))
    copy))

; initialize random list of recipes, to ensure every recipe is included twice in the experiment
(defun initialize-recipe-order ()
  (let ((repeated-recipes (concatenate 'list *recipes* *recipes*)))
    (setf *recipeOrder* (shuffle-list repeated-recipes))))
