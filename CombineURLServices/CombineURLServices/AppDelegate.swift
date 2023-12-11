//
//  AppDelegate.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson 
//

import Foundation
import UIKit
import CoreData
import DataFlowFunnelCD


class AppDelegate: NSObject, UIApplicationDelegate {

    var refDataFlowFunnel:DataFlowFunnel = DataFlowFunnel.shared
    var myReachability: NetworkReachability = NetworkReachability()
    var refIPLocationReducer: IPLocationDataReducer = IPLocationDataReducer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.refDataFlowFunnel.setModelName(to: "CombineURLServices" )
        self.refDataFlowFunnel.setTargetBundleIdentifier(bundleId: "com.matthewferguson.CombineURLServices")
        
        // IPGeoLocationModule 
        self.refIPLocationReducer.setupFetchControllersReducer()
        
        
        //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        removeAllUserDataOnInitialize()
        //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        
        self.myReachability.startNotifier()
        if  self.myReachability.currentReachableId == kReachWWAN {
            //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        } else if self.myReachability.currentReachableId == kReachWiFi {
           //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        } else {
            //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        }
        
        //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        
        return true
    }
    
    
    
    // MARK: - Core Data stack
    
    func removeAllUserDataOnInitialize() {
        
        let moc = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let fetchRequestUser : NSFetchRequest<ReachabilityStatus> = ReachabilityStatus.fetchRequest()
        moc.performAndWait {
            do{
                let resultsArray:Array<ReachabilityStatus> = try fetchRequestUser.execute()
                for user in resultsArray {
                    moc.delete(user)
                    try moc.save()
                }
            } catch let error as NSError {
                print("Could not execute AppDelegate::removeAllUserDataOnInitialize::ReachabilityStatus. \(error), \(error.userInfo)")
            }
        }
        
        let moc2 = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let fetchRequestUser2 : NSFetchRequest<NetworkRequest> = NetworkRequest.fetchRequest()
        moc2.performAndWait {
            do{
                let resultsArray2:Array<NetworkRequest> = try fetchRequestUser2.execute()
                for user in resultsArray2 {
                    moc2.delete(user)
                    try moc2.save()
                }
            } catch let error as NSError {
                print("Could not execute AppDelegate::removeAllUserDataOnInitialize:NetworkRequest. \(error), \(error.userInfo)")
            }
        }
    }
}
