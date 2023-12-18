# CombineURLServices

iOS Code Challenge to demonstrate the use of Combine URL Services, API Restful services, Core Data, and Background processing within a Mobile REDUX Architecture.  This solution uses Reducers, Core Data, SwiftUI, and struct View MVVM to manage the data flow and business logic needs for the Use Cases listed below.  This architecture will decouple the data flow from the SwiftUI views and will elimated the dependencies on Singltons and tight coupling that come with delegate use.  SwiftUI are structs and refresh to re-establish a new state.  Unlike the UIKit View Controller classes SwiftUI structs are temporary and the use of delegates and Singletons are a risk to use. 

Use Cases and UI/UX Specifications. 

1. Single screen with IP address (e.g. 255.255.255.255 format) text input field. 
2. Standard Numeric Keyboard. Keyboard shows once the text area is tapped. 
3. Single search button initiates a search of text input field string "content".
4. Restful API : https://ip-api.com/docs/api:json 
5. Check, identify, and inform user interface if the network is lost. Handle API search communication errors.  
6. Search results display a dynamic list of returned data from ip-api.com services. 


Solution Details (WIP)

- Mobile REDUX Architecture using Core Data to decouple the data dependencies and remove the use of Singletons and callback delegates. 
- The use of Reducers (REDUX) and Core Data to provide a Data Flow that is decoupled from the struct views of SwiftUI. Allowing SwiftUI to be a temporary in memory view as intended.
- Use https://github.com/matthewferguson/DataFlowFunnelCD package to manage the Core Data contention issues that exist in older and newer versions of iOS SDKs.  Also, centralizes the flow of SQL Creates and Updates using Operations.
- Use of Swift Operations and Core Data Fetch Controllers to further decouple the SwiftUI MVVM and Event Driven Data Flow.  

Swift Packages installed within the Xcode 15 SPM:

1. Reachability 
Swift Package Index https://swiftpackageindex.com/ashleymills/Reachability.swift
Github : https://github.com/ashleymills/Reachability.swift

2. DataFlowFunnelCD
Github : https://github.com/matthewferguson/DataFlowFunnelCD

