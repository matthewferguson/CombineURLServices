# CombineURLServices

iOS Code Challenge to demonstrate the use of Combine URL Services, API, Core Data, and Background processing within a Mobile REDUX Architecture.  Using Reducers and Core Data the Data Flow will be decoupled from the views.  Mobile REDUX Architecture using Core Data to decouple the data dependencies and open and running delegates.    

Use Cases and UI/UX Specifications. 

1. Single screen with IP address (e.g. 255.255.255.255 format) text input field. 
2. Standard Numeric Keyboard. Keyboard shows once the text area is tapped. 
3. Single search button initiates a search of text input field string "content".
4. Restful API : https://ip-api.com/docs/api:json 
5. Check, identify, and inform user interface if the network is lost. Handle API search communication errors.  
6. Search results display a dynamic list of returned data from ip-api.com services. 


Solution Details (WIP)

- Mobile REDUX Architecture using Core Data to decouple the data dependencies and open and running delegates. 
- The use of Reducers (REDUX) and Core Data to provide a Data Flow will decouple the struct views of SwiftUI. Allowing SwiftUI to be a temporary in memory view as intended. 

Swift Packages installed within the Xcode 15 SPM:

Reachability 
Swift Package Index https://swiftpackageindex.com/ashleymills/Reachability.swift
Github : https://github.com/ashleymills/Reachability.swift
