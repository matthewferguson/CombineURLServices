//
//  UpdateIpGeoLocationNetworkRequestOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class UpdateIpGeoLocationNetworkRequestOperation: Operation {
    
    private var idToUpdate: UUID  = UUID()
    private var stateToUpdate: Int64 = 0
    
    public init(withid: UUID, withstate: Int64) {
        self.idToUpdate = withid
        self.stateToUpdate = withstate
        super.init()
    }
    
    override func main() {
        guard !isCancelled else { return }
        let managedContext1 =  DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let fetchRequest = NSFetchRequest<NetworkRequest>(entityName: "NetworkRequest")
        fetchRequest.predicate = NSPredicate(format: "id = %@", self.idToUpdate.uuidString)
        managedContext1.performAndWait {
            do {
                let networkRequestCollectionEntity = try managedContext1.fetch(fetchRequest)
                if let updateSingleNetworkRequestEntity =
                    networkRequestCollectionEntity.first {
                    updateSingleNetworkRequestEntity.setValue(self.stateToUpdate, forKey: "status")
                    try managedContext1.save()
                }
            }
            catch let error as NSError {
                print("Failed to execute \(error), \(error.userInfo)")
            }
        }
    }
    
}
