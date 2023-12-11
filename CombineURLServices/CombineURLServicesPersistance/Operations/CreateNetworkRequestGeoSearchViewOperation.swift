//
//  CreateNetworkRequestGeoSearchViewOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class CreateNetworkRequestGeoSearchViewOperation: Operation {
    
    var newIPText: String = String()
    var setTypeOfRequest = String()
    
    init( newIpAddress:String, typeofrequest: String) {
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
        
        networkRequestMO.message = String()
        networkRequestMO.id = String()
    
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error on saving the CreateNetworkRequestGeoSearchViewOperation MO: == \(error),\(error.userInfo)")
            }
        }
    }
}
