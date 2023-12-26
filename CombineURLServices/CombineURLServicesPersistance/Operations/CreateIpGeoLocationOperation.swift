//
//  CreateIpGeoLocationOperation.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson 
//

import Foundation
import CoreData
import DataFlowFunnelCD

final class CreateIpGeoLocationOperation: Operation {
    
    private var newIpLocation: IPLocation = IPLocation()
    private var requestID: UUID = UUID()
    
    init( newIpLocation:IPLocation, ident: UUID ) {
        self.newIpLocation = newIpLocation
        self.requestID = ident
        super.init()
    }

    override func main() {
        
        guard !isCancelled else { return }
        let managedContext = DataFlowFunnel.shared.getPersistentContainerRef().viewContext
        let ipgeolocationMO:IpGeoLocation = IpGeoLocation(context: managedContext)
    
        ipgeolocationMO.city = self.newIpLocation.city
        ipgeolocationMO.country = self.newIpLocation.country
        ipgeolocationMO.countryCode = self.newIpLocation.countryCode
        ipgeolocationMO.id = self.newIpLocation.id
        ipgeolocationMO.isp = self.newIpLocation.isp
        ipgeolocationMO.lat = self.newIpLocation.lat ?? 0.0
        ipgeolocationMO.lon = self.newIpLocation.lon ?? 0.0
        ipgeolocationMO.message = self.newIpLocation.message
        ipgeolocationMO.org = self.newIpLocation.org
        ipgeolocationMO.query = self.newIpLocation.query
        ipgeolocationMO.region = self.newIpLocation.region
        ipgeolocationMO.regionName = self.newIpLocation.regionName
        ipgeolocationMO.status = self.newIpLocation.status
        ipgeolocationMO.timestamp = Date()
        ipgeolocationMO.timezone = self.newIpLocation.timezone
        ipgeolocationMO.zip = self.newIpLocation.zip
    
        managedContext.performAndWait {
            do {
                try managedContext.save()
                DataFlowFunnel.shared.addOperation(
                    UpdateNetworkRequestOperation(withid: self.requestID,
                                                  withstate: NetworkRequestStatus.success.rawValue )
                )
            } catch let error as NSError {
                print("Error on saving the CreateNetworkRequestGeoSearchViewOperation MO: == \(error),\(error.userInfo)")
            }
        }
    }
}
