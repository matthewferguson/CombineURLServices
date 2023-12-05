//
//  AppDelegate.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 10/17/23.
//

import Foundation
import UIKit
import CoreData
import DataFlowFunnelCD


class AppDelegate: NSObject, UIApplicationDelegate {

    var refDataFlowFunnel:DataFlowFunnel = DataFlowFunnel.shared
    var myReachability: NetworkReachability = NetworkReachability()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.refDataFlowFunnel.setModelName(to: "CombineURLServices" )
        self.refDataFlowFunnel.setTargetBundleIdentifier(bundleId: "com.matthewferguson.CombineURLServices")
        
        removeAllUserDataOnInitialize()
        
        DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        
        self.myReachability.startNotifier()
        
        if  self.myReachability.currentReachableId == kReachWWAN {
            DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        } else if self.myReachability.currentReachableId == kReachWiFi {
            DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        } else {
            DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        }
        
        DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        
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
                print("Could not execute AppDelegate::fetchRequestUser. \(error), \(error.userInfo)")
            }
        }
    }
}
