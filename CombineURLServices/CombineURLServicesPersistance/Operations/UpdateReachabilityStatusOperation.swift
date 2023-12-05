//
//  UpdateReachabilityStatusOperation.swift
//
//  Created by Matthew Ferguson
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class UpdateReachabilityStatusOperation: Operation {
    
    var newCurrentStatus: String = String()
    
    init( newStatus:String) {
        self.newCurrentStatus = newStatus
        super.init()
    }

    override func main() {
        guard !isCancelled else { return }
        let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let statusMO:ReachabilityStatus = ReachabilityStatus(context: managedContext)
        statusMO.status = self.newCurrentStatus
        statusMO.timestamp = Date()
        managedContext.performAndWait
        {
            do{
                try managedContext.save()
            } catch let error as NSError {
                print("Error on saving the ReachabilityStatus MO: == \(error),\(error.userInfo)")
            }
        }
    }
}
