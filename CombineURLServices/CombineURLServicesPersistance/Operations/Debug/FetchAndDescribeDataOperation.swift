//
//  FetchAndDescribeDataOperation.swift
//
//  Created by Matthew Ferguson
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class FetchAndDescribeDataOperation: Operation {
    
    override init() {
        super.init()
    }

    override func main() {
        
        guard !isCancelled else { return }
        
        let managedContext =  DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        print( "--------------------------------------------------------")
        print("Framework Context PersistentContainer viewContext ConcurrencyType: ")
        switch (managedContext.concurrencyType){
        case .mainQueueConcurrencyType:
            print("         .mainQueueConcurrencyType")
        case .privateQueueConcurrencyType:
            print("         .privateQueueConcurrencyType")
        case .confinementConcurrencyType:
            print("         .confinementConcurrencyType")
        @unknown default:
            fatalError()
        }
        
        let managedContext1 =  DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let fetchRequest = NSFetchRequest<ReachabilityStatus>(entityName: "ReachabilityStatus")
        managedContext1.performAndWait {
            do {
                print( "--------------------------------------------------------")
                print("Framework description call all ReachabilityStatus description")
                let statusCollection = try managedContext1.fetch(fetchRequest)
                for (index, singleStatus) in statusCollection.enumerated()
                {
                    print("------ START: Single Network Status ----------")
                    print("Single Status at location index == \(index):")
                    print("     singleStatus.timestamp == \(String(describing: singleStatus.timestamp))")
                    //print("     singleStatus.status == \(String(describing: singleStatus.status))" )
                    switch singleStatus.status {
                    case kReachWWAN:
                        print("     singleStatus.status == kReachWWAN")
                        break
                    case kUnReachable:
                        print("     singleStatus.status == kUnReachable")
                        break
                    case kReachWiFi:
                        print("     singleStatus.status == kReachWiFi")
                        break
                    default:
                        break
                    }
                }
                print("------- END: Single Network Status -------")
            }
            catch let error as NSError {
                print("Failed to execute \(error), \(error.userInfo)")
            }
        }
        
        let managedContext2 =  DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let fetchRequest2 = NSFetchRequest<NetworkRequest>(entityName: "NetworkRequest")
        managedContext2.performAndWait {
            do {
                print( "--------------------------------------------------------")
                print("Framework description call all NetworkRequest description")
                let networkRequestCollection = try managedContext2.fetch(fetchRequest2)
                for (index, networkRequest) in networkRequestCollection.enumerated()
                {
                    print("------ START: Network Request ----------")
                    print("Network Request at location index == \(index):")
                    print("     networkRequest.timestamp == \(String(describing: networkRequest.timestamp))")
                    print("     networkRequest.id == \(String(describing: networkRequest.id))" )
                    print("     networkRequest.status == \(String(describing: networkRequest.status))")
                    print("     networkRequest.type == \(String(describing: networkRequest.type))")
                    print("     networkRequest.urlRequested == \(String(describing: networkRequest.urlRequested))")
                }
                print("------- END: Single Network Status -------")
            }
            catch let error as NSError {
                print("Failed to execute \(error), \(error.userInfo)")
            }
        }
        
    }
}
