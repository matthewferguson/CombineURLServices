//
//  CreateIpGeoLocationOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson 
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class DeleteIpGeoLocationNetworkRequestOperation: Operation {
    
    var id: UUID = UUID()
    
    init( withid: UUID ) {
        self.id = withid
        super.init()
    }

    override func main() {
        guard !isCancelled else { return }
        let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NetworkRequest")
        request.predicate = NSPredicate(format: "id = %@", self.id.uuidString)
        do{
            let resultOfFetch = try managedContext.fetch(request)
            if let entity = resultOfFetch.first as? NSManagedObject {
                managedContext.delete(entity)
            }
        } catch {
            print("Error Message")
        }
        
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error on saving the DeleteIpGeoLocationRequestOperation MO: == \(error),\(error.userInfo)")
            }
        }
    }
}
