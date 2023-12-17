//
//  CreateNetworkRequestGeoSearchViewOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//
//  Purpose is to support the IP Geo Location View Model request
//      for RESTful API call for an IP address as input from View.
//      Create a NetworkRequest, Core Data, as decouple data flow that
//      the modules' Reducer works.
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class CreateNetworkRequestGeoSearchViewOperation: Operation {
    
    var newIPText:String = String() // ip text injection
    var setTypeOfRequest:Int64 = NetworkRequestType.geosearch.rawValue
    var setStatusOfRequest:Int64 = NetworkRequestStatus.submittal.rawValue
    
    init( newIpAddress:String, typeofrequest:Int64) {
        self.newIPText = newIpAddress
        self.setTypeOfRequest = typeofrequest
        super.init()
    }

    override func main() {
        guard !isCancelled else { return }
        let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let networkRequestMO:NetworkRequest = NetworkRequest(context: managedContext)
        networkRequestMO.urlRequested = self.newIPText
        networkRequestMO.type = setTypeOfRequest
        networkRequestMO.timestamp = Date()
        networkRequestMO.status = setStatusOfRequest
        networkRequestMO.id = UUID()
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error on saving the CreateNetworkRequestGeoSearchViewOperation MO: == \(error),\(error.userInfo)")
            }
        }
    }
}
