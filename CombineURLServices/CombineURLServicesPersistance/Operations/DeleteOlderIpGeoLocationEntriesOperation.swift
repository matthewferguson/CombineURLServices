//
//  DeleteOlderIpGeoLocationEntriesOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 12/18/23.
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class DeleteOlderIpGeoLocationEntriesOperation: Operation {
    
    override init() {
        super.init()
    }

    override func main() {
        guard !isCancelled else { return }
        let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let request = NSFetchRequest<IpGeoLocation>(entityName: "IpGeoLocation")
        let fiveMinutesAgo = Date().addingTimeInterval(-5 * 60)
        request.predicate = NSPredicate(format: "timestamp <= %@", fiveMinutesAgo as CVarArg)
        do{
            let resultOfFetchCollection = try managedContext.fetch(request)
            for (singleipgeo) in resultOfFetchCollection {
                managedContext.delete(singleipgeo)
            }
        } catch {
            print("Error:DeleteOlderIpGeoLocationEntriesOperation")
        }
        
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error on saving the DeleteOlderIpGeoLocationEntriesOperation MO: == \(error),\(error.userInfo)")
            }
        }
        
    }
}
