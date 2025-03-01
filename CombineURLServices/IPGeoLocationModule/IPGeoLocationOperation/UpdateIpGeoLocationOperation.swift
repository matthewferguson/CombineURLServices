//
//  UpdateIpGeoLocationOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import Foundation
import CoreData
import DataFlowFunnelCD

/*
 Purpose: When the tuple conditions occurs:
    1. When an IP address has been checked (by user actions)
    2. Under the refresh time limits.
    3. The IP string is the same as a past search.
 Then we need to display the same entity from CoreData. This
 update triggers an event on views/view model to update the
 screen with that returned data. This data will expire at some
 time and will be deleted. Creating a REST API call to retreive
 a refreshed data set for that IP address.
 */

final class UpdateIpGeoLocationOperation: Operation, @unchecked Sendable {
    
    private var localWithMessage: String  = String()
    private var localWithIpGeoLocation: IpGeoLocation = IpGeoLocation()
    
    public init(withIpGeoLocation: IpGeoLocation) {
        self.localWithIpGeoLocation = withIpGeoLocation
        super.init()
    }
    
    override func main() {
        guard !isCancelled else { return }
        let managedContext =  DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        managedContext.performAndWait {
            do {
                self.localWithMessage = self.localWithIpGeoLocation.message ?? String()
                localWithIpGeoLocation.setValue(self.localWithMessage, forKey: "message")
                try managedContext.save()
            }
            catch let error as NSError {
                print("Failed to execute save for IpGeoLocation entity message key \(error), \(error.userInfo)")
            }
        }
    }
    
}
