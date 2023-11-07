//
//  AppDelegate.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 10/17/23.
//

import Foundation
import UIKit
import CoreData
//import DataFlowFunnelCD


class AppDelegate: NSObject, UIApplicationDelegate {
    
//    var fishingBoatBackgroundProcessing:FishingBoatDemarcation?
//    var refDataFlowFunnel:DataFlowFunnel = DataFlowFunnel.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
//        self.refDataFlowFunnel.setModelName(to: "PondFishingSwiftUIModel" )
//        self.refDataFlowFunnel.setTargetBundleIdentifier(bundleId: "com.matthewferguson.PondFishingSwiftUI")
////        DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
//        
//        self.removeUserDataOnTerminate()
//        self.resetDataStateOnTerminate()
//        DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
//
//        // start the fishing boat operations
//        self.fishingBoatBackgroundProcessing = FishingBoatDemarcation()
//        
        return true
    }
    
    
    // MARK: - Core Data stack
//    
//    func removeUserDataOnTerminate() {
//        
//            let moc = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fetchRequestUser : NSFetchRequest<Boat> = Boat.fetchRequest()
//            moc.performAndWait {
//                do{
//                    let resultsArray:Array<Boat> = try fetchRequestUser.execute()
//                    //let resultsArray = try fetchRequestUser.execute()
//                    for user in resultsArray {
//                        moc.delete(user)
//                        try moc.save()
//                    }
//                } catch let error as NSError {
//                    print("Could not execute AppDelegate::fetchRequestUser. \(error), \(error.userInfo)")
//                }
//            }
//      
//    
//            let moc2 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fetchRequestPond : NSFetchRequest<Pond> = Pond.fetchRequest()
//            moc2.performAndWait {
//                do{
//                    let resultsArray:Array<Pond> = try fetchRequestPond.execute()
//                    for singleRecordInPond in resultsArray {
//                        moc2.delete(singleRecordInPond)
//                        try moc2.save()
//                    }
//                } catch let error as NSError {
//                    print("Could not execute AppDelegate::fetchRequestPond. \(error), \(error.userInfo)")
//                }
//            }
//
//            let moc1 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fetchRequestFishMarket : NSFetchRequest<FishMarket> = FishMarket.fetchRequest()
//            moc1.performAndWait {
//                do{
//                    let resultsArray:Array<FishMarket> = try fetchRequestFishMarket.execute()
//                    for singleRecordInPond in resultsArray {
//                        moc1.delete(singleRecordInPond)
//                        try moc1.save()
//                    }
//                } catch let error as NSError {
//                    print("Could not execute AppDelegate::fetchRequestFishMarket. \(error), \(error.userInfo)")
//                }
//            }
//    }
//    
//    
//    
//    func removeUserData() {
//        
//       let operationDeleteUser = BlockOperation {
//            let moc = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fetchRequestUser : NSFetchRequest<Boat> = Boat.fetchRequest()
//            moc.performAndWait {
//                do{
//                    let resultsArray:Array<Boat> = try fetchRequestUser.execute()
//                    for user in resultsArray {
//                        moc.delete(user)
//                        try moc.save()
//                    }
//                } catch let error as NSError {
//                print("Could not execute AppDelegate::fetchRequestUser. \(error), \(error.userInfo)")
//                }
//            }
//       }
//        DataFlowFunnel.shared.addOperation(operationDeleteUser)
//            
//            
//        let operationDeletePondValues = BlockOperation
//        {
//            let moc2 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fetchRequestPond : NSFetchRequest<Pond> = Pond.fetchRequest()
//            moc2.performAndWait {
//                do{
//                    let resultsArray:Array<Pond> = try fetchRequestPond.execute()
//                    for singleRecordInPond in resultsArray {
//                        moc2.delete(singleRecordInPond)
//                        //try moc2.save()
//                    }
//                    try moc2.save()
//                } catch let error as NSError {
//                    print("Could not execute AppDelegate::fetchRequestPond. \(error), \(error.userInfo)")
//                }
//            }
//        }
//        DataFlowFunnel.shared.addOperation(operationDeletePondValues)
//        
//        
//        
//        let operationDeleteFishMarketValues = BlockOperation
//        {
//            let moc1 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fetchRequestFishMarket : NSFetchRequest<FishMarket> = FishMarket.fetchRequest()
//            moc1.performAndWait {
//                do{
//                    let resultsArray:Array<FishMarket> = try fetchRequestFishMarket.execute()
//                    for singleRecordInPond in resultsArray {
//                        moc1.delete(singleRecordInPond)
//                        try moc1.save()
//                    }
//                } catch let error as NSError {
//                    print("Could not execute AppDelegate::fetchRequestFishMarket. \(error), \(error.userInfo)")
//                }
//            }
//        }
//        DataFlowFunnel.shared.addOperation(operationDeleteFishMarketValues)
//        
//    }
//    
//  
//    
//    /// reset all core data persistents at shutdown and start.
//    
//    func resetDataStateOnTerminate() {
//            
//            let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let pond:Pond = Pond(context: managedContext)
//            pond.numberOfFish = 10000
//            managedContext.performAndWait
//            {
//                do{
//                    try managedContext.save()
//                } catch let error as NSError {
//                    print("Error on saving the Pond MO in resetDataStateOnTerminate: == \(error),\(error.localizedDescription)")
//                }
//            }
//
//            
//            let managedContext1 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fishMarket:FishMarket = FishMarket(context: managedContext1)
//            fishMarket.numberOfFish = 0
//            managedContext1.performAndWait
//            {
//                do{
//                    try managedContext1.save()
//                } catch let error as NSError {
//                    print("Error on saving the FishMarket MO in resetDataStateOnTerminate: == \(error),\(error.localizedDescription)")
//                }
//            }
//        
//    }
//
//    /// reset all core data persistents at shutdown and start.
//    
//    func resetDataState() {
//        
//        let operationResetPond = BlockOperation
//        {
//            
//            // sleep for 150 milliseconds
//            Thread.sleep(forTimeInterval: Double(0.015) )
//            
//            let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let pond:Pond = Pond(context: managedContext)
//            pond.numberOfFish = 999
//            managedContext.performAndWait
//            {
//                do{
//                    try managedContext.save()
//                } catch let error as NSError {
//                    print("Error on saving the User MO in didLoginWith: == \(error),\(error.userInfo)")
//                }
//            }
//        }
//        DataFlowFunnel.shared.addOperation(operationResetPond)
//        
//        let operationResetFishMarket = BlockOperation
//        {
//            // sleep for 150 milliseconds
//            Thread.sleep(forTimeInterval: Double(0.015) )
//            
//            let managedContext1 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
//            let fishMarket:FishMarket = FishMarket(context: managedContext1)
//            fishMarket.numberOfFish = 0
//            managedContext1.performAndWait
//            {
//                do{
//                    try managedContext1.save()
//                } catch let error as NSError {
//                    print("Error on saving the User MO in didLoginWith: == \(error),\(error.userInfo)")
//                }
//            }
//        }
//        DataFlowFunnel.shared.addOperation(operationResetFishMarket)
//    }
    
}
