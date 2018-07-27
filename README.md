# GettingCleaningDataProject

The purpose of this project is to collect, work with, and clean a data set which has been collected from the accelerometers from the Samsung Galaxy S smartphone. The goal is to prepare tidy data that can be used for later analysis.

For each record in the tidy data set it is provided:
======================================

- An identifier of the subject who carried out the experiment.
- Its activity label. 
- Average of the Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Average Triaxial Angular velocity from the gyroscope. 
- Average vector with time and frequency domain variables. 

The dataset includes the following files:
=========================================

- 'README.md'

- ‘run_analysis.R’: R script performed to run the analysis to collect, work and clean the data set

- ’tidydata.txt': Tidy data set

- 'CodeBook.Rmd': code book that describes the variables, the data, and any transformations

- 'CodeBook.html’: CodeBook.Rmd knit to HTML


Notes: 
======
- Features are normalized and bounded within [-1,1].
- Tidy data set contains the average of each variable for each activity and each subject.
