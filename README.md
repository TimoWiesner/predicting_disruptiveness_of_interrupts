# Predicting disruptiveness of Interrupts using cognitive models
This is the git repository for my thesis "Predicting disruptiveness of interrupts using cognitive models".
It includes the code for the cooking experiment and the developed ACT-R models.
In the "ExcelCharts" folder the results of the separate experiment iterations can be found.

## Set up the experiment
To set up the experiment ACT-R needs to be installed which can be found here -> http://act-r.psy.cmu.edu/software/ 
The entire "cookingTaskModel" folder then needs to be dragged into the ACT-R mainfolder, after that ACT-R can be started.
Then the "experimentCooking.lisp" file can be loaded via the "Load ACT-R code" button in the ACT-R interface. By default the more successful second model approach will be loaded. To load the first model approach, the filepath inside the "experimentCooking.lisp" needs to changed to (load-act-r-model "ACT-R:cookingTaskModel;Model1.lisp").

## Run the experiment
After loading the experiment and the model, the experiment can be started via a command in the console. Simply use the "do-experiment" function. This function needs two parameters, the first one is a boolean parameter indicating whether a human (t) or the model (nil) is doing the task. The second parameter is also a boolean indicating whether the realistic robot (t) suggestions or the random robot (nil) suggestions are used.

An example usage of the command would be (do-experiment nil t) for a run where the model is doing the task with realistic robot suggestions.

To see what exactly is happening (and for the human experiment run) the visibility of the experiment window needs to be set to t. By default the visibility is set to nil to not influence the collected data of the models. This can be done in the "experimentCooking.lisp" file by changing the value of the first declared variable *visible.

## Get the results
After a run the collected data can be found in the data folder, where meta-files are created for every recipe (meta1 - meta8). After a run, the data files need to be deleted or saved elsewhere to avoid errors in the data. If this is not done, the data from successive runs will be appended to the existing meta-files.
### Side note: 
LISP-commands in the console need to be wrapped in brackets. Also false in LISP is represented as nil and true is represented as t.
