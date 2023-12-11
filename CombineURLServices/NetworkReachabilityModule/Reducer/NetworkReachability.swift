
//
//  NetworkReachability.swift
//  Created by Matthew Ferguson on 8/1/17.
//  Updated April 21, 2018, Nov 2023.


import Foundation

//  SystemConfiguration - Allow applications to access a device’s network
//  configuration settings. Determine the reachability of the device,
//  such as whether Wi-Fi or cell connectivity are active.
//import SystemConfiguration
import Reachability
import DataFlowFunnelCD


class NetworkReachability : NSObject {
    
    //MARK:- Properties
    var currentReachableId: String = kUnReachable
    var reachability: Reachability?
    
    //MARK:- Init
    override init() {
        super.init()
        // first init the dataController for use in setup and beyond
        self.setupReachability()
    }

    // MARK:- Reachability
    private func setupReachability() -> Void {

        do {
            self.reachability = try Reachability()
        } catch {
            print("setupReachability(): - Could not initialize the Reachability")
        }
        
        self.reachability?.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.updateWhenReachable(reachability)
            }
        }
        self.reachability?.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.updateWhenNotReachable(reachability)
            }
        }
    
    }
    
    
    func startNotifier() {
        do {
            try self.reachability?.startNotifier()
        }
        catch {
            print("Error: startNotifier()")
            return
        }
    }

    
    func stopNotifier() {
        self.reachability?.stopNotifier()
        print("Error:startNotifier: stopNotifier()")
    }
    
    
    
    func updateWhenReachable(_ localReachability: Reachability) {
        if localReachability.connection == .wifi {
            self.currentReachableId = kReachWiFi
        }
        else if localReachability.connection == .cellular {
            self.currentReachableId = kReachWWAN
        }
        else {
            self.currentReachableId = kUnReachable
        }
        
        // BUZ install CRUD Operation
        DataFlowFunnel.shared.addOperation(UpdateReachabilityStatusOperation(newStatus: self.currentReachableId))
        //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
    }

    
    func updateWhenNotReachable(_ localReachability: Reachability) {
        
        self.currentReachableId = kUnReachable
        // BUZ install CRUD Operation
        DataFlowFunnel.shared.addOperation(UpdateReachabilityStatusOperation(newStatus: self.currentReachableId))
        //DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
    }
    
    
    // callback when there are changes
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .unavailable {
            updateWhenReachable(reachability)
        }
        else {
            updateWhenNotReachable(reachability)
        }
    }

}
