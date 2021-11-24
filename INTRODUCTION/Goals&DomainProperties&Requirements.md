## Goals

  
- G2 : Allow the farmers to retrieve personalized suggestions (*On what are based suggestions ? Weather, location, soil humidity, crop, best practices given by others*)    
- G3 : Allow the farmers to access data about weather and soil conditions and predictions (*In what area ? 10/150 km What kind of data exactly ?*)
- G4 : Allow policy makers to access the performance indicators of their dedicated farmers (*What are the perf indicators ?*)
  - G4.1 : Allow the farmers to release their production data (*ensure that the policy makers are the only ones interested by these data*)
  - G4.2 : Allow the captors to send their humidity data 
- G5 : Allow farmers to discuss on forums (*Check if it is part of G6 or if the means are separated*)
  - G5.1 : Allow farmers to participate to a forum
  - G5.1 : Allow farmers to create a forum 
- G6 : Allow farmers to help or be helped (?) -> agronomists 
- 


## Domain Properties / Assumptions
- DP1 : Every farmer has a smartphone (with ... properties)
- DP2 : Data are up-to-date (in a ... days range)
- DP3 : Farmers are fair when providing data, suggestions & problems
- DP4 : There are at least 2 farmers and 1 policy maker
- DP5 : Data from sensors are accurate (in a ... extent)
- DP6 : Data from the Web are accurate (in a ... extent)
- DP7 : Sensors are always available, or at least, there is a sufficient number of them to properly describe an area (precision of the DP ?)
- 


## Requirements
- R1: When a farmer asks for personalized suggestions, the system should retrieve the weather, soil and location data
- R2: If a farmer performs well, the system request his best practices
- R3: Every ... (same timelapse for every farmer or depending on area, policy maker, farmer,... ?), the system requests production data of the farmer. (could the farmer give data from last month/year/... ?)
- R4: The system fetches (in real time or every ...?) the data about soil and irrigation
- R5: The system should compute the performance indicators based on the data provided by farmers
- R6: When a policy maker asks for poor-performing farmers, the system should retrieve the associated farmers (based on area and the specified metric) (Is the help given by policy makers a financial support ?)
- R7: When a policy maker asks for well-performing farmers, the system should retrieve the associated farmers (based on area and the specified metric) (Should the system handle the incentive that policy makers can give ?)
- R8: The system should grant farmers access to their personal and production data
- 
