## Goals

  
- G2 : Allow the farmers to retrieve personalized suggestions (*On what are based suggestions ? Weather, location, soil humidity, crop, best practices given by others*)    
- G3 : Allow the farmers to access data about weather and soil conditions and predictions (*In what area ? 10/150 km What kind of data exactly ?*)
- G5 : Allow farmers to discuss on forums (*Check if it is part of G6 or if the means are separated*)



- G.1 : Allow farmers to get advices for optimizing their production  
  * G.1.1 : Allow farmers to retrieve personalized suggestions if they perform poorly  
  * G.1.2 : Allow farmers to discuss with other farmers about their issues
    - G1.2.1 : Allow farmers to create a discussion forum
    - G1.2.2 : Allow farmers to look for a specific topic among discussion forums
    - G1.2.3 : Allow farmers to send messages on a forum already created
    - G1.2.4 : Allow farmers to contact another farmer privately
* Allow farmers to send a specific help request   


- G2 : Allow farmers to get data that impact their production 
* Allow farmers to access data about weather conditions and predictions  
  - G2.1 : 
* Allow farmers to access data about soil moisture
* Allow farmers to access data about soil organic carbon


- G3 : Allow policy makers to globally enhance the productivity of the farmers of their area   
* Allow policy makers to identify well and poorly performing farmers of their area, according to a chosen metric
* Allow policy makers to incent well performing farmers
* Allow policy makers to fetch best practices among farmers and provide them to others
* Allow policy makers to send personalized suggestions to poorly performing farmers


## Domain Properties / Assumptions
- DP1 : Every farmer has a smartphone (with geo-tracking,...  properties)
- DP2 : Soil moisture data are updated every 2 days
- DP : Rainfall conditions are daily updated 
- DP : Rainfall previsions (24/48/72h) are daily updated
- DP : Data fetched on the different governmental sites are trustworthy reliable
- DP3 : Farmers are fair when providing data, suggestions & problems
- DP4 : There are at least 2 farmers and 1 policy maker
- DP5 : Data from sensors are accurate (in a ... extent)
- DP6 : Data from the Web are accurate (in a ... extent)
- DP7 : Sensors are always available, or at least, there is a sufficient number of them to properly describe an area (precision of the DP ?)
- DP8 : farmers should have received credencials to log in the application


## Requirements
- R1: When a farmer asks for personalized suggestions, the system should retrieve the weather, soil and location data
- R2: If a farmer performs well, the system request his best practices
- R3: At each end of cropping, the system should request production data of farmers.
- R4: The system fetches (in real time or every ...?) the data about soil and irrigation
- R5: The system should compute the performance indicators based on the data provided by farmers
- R6: When a policy maker asks for poor-performing farmers, the system should retrieve the associated farmers (based on area and the specified metric) (Is the help given by policy makers a financial support ?)
- R7: When a policy maker asks for well-performing farmers, the system should retrieve the associated farmers (based on area and the specified metric) (Should the system handle the incentive that policy makers can give ?)
- R8: The system should grant farmers access to their personal and production data
- 

## Assumptions:
- Cropping seasons are the same on the whole Telengana State and follow the Kharif/Rabi calendar (see Recommended System of Breeder Seed Indent and Supply)
- 
