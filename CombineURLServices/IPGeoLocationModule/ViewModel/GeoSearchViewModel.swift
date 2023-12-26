//
//  GeoSearchViewModel.swift
//
//  Created by Matthew Ferguson
//

import Foundation
import UIKit
import CoreData
import Combine
import SwiftUI
import DataFlowFunnelCD

extension GeoSearchView
{
    @MainActor class GeoSearchViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        
        @Published public var ipGeoLocation = IPLocation()
        @Published public var networkNotAvailable = false
        @Published var managedIpGeoLocations: [IpGeoLocationGenericNode] = []
        @Published var ipAddressInput: String = ""
        
        private var refDataFlowFunnel:DataFlowFunnel = DataFlowFunnel.shared
    
        //MARK: - Setup data fetchcontrollers
        
        fileprivate lazy var fetchIpGeoLocationRequestController: NSFetchedResultsController<IpGeoLocation> = {
            let fetchIpGeoLocations: NSFetchRequest<IpGeoLocation> = IpGeoLocation.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending:false )
            fetchIpGeoLocations.sortDescriptors = [sortDescriptor]
            
            //Initialize Fetched Results Controller
            let fetchIpGeoLocationRequest = NSFetchedResultsController(
                fetchRequest: fetchIpGeoLocations,
                managedObjectContext:DataFlowFunnel.shared.getPersistentContainerRef().viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            fetchIpGeoLocationRequest.delegate = self
            return fetchIpGeoLocationRequest
        }()
        
        fileprivate lazy var fetchReachabilityStatusController: NSFetchedResultsController<ReachabilityStatus> = {
            let fetchReachabilityStatus: NSFetchRequest<ReachabilityStatus> = ReachabilityStatus.fetchRequest()
        
            let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending:false)
            fetchReachabilityStatus.sortDescriptors = [sortDescriptor]
        
            //Initialize Fetched Results Controller
            let fetchAllReachabilityStatusRequest = NSFetchedResultsController(
                fetchRequest: fetchReachabilityStatus,
                managedObjectContext:DataFlowFunnel.shared.getPersistentContainerRef().viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
        
            fetchAllReachabilityStatusRequest.delegate = self
            return fetchAllReachabilityStatusRequest
        }()
        
        func setupFetchControllers() {
            
            do {
                try self.fetchReachabilityStatusController.performFetch()
                let statusCollection = self.fetchReachabilityStatusController.fetchedObjects!
                if statusCollection.count > 0 {
                    if let networkReachMO = statusCollection.first {
                        if networkReachMO.status == "success" {
                            networkNotAvailable = false
                        } else {
                            networkNotAvailable = true
                        }
                    }
                }
            } catch {
                // error popup?
                let fetchError = error as NSError
                print("GeoSearchView VM Unable to Perform fetchReachabilityStatusController: \(fetchError), \(fetchError.localizedDescription)")
            }
            
            do {
                try self.fetchIpGeoLocationRequestController.performFetch()
                _ = self.fetchIpGeoLocationRequestController.fetchedObjects!
            } catch {
                // error popup?
                let fetchError = error as NSError
                print("GeoSearchView VM Unable to Perform fetchIpGeoLocationRequestController Request: \(fetchError), \(fetchError.localizedDescription)")
            }
        }
        
        // Start the ip search with a decoupled request. type is geosearch.
        public func requestIpGeoServices() {
            DataFlowFunnel.shared.addOperation( 
                CreateNetworkRequestGeoSearchViewOperation(newIpAddress: ipAddressInput,
                                                           typeofrequest: NetworkRequestType.geosearch.rawValue )
            )
        }

        
        private func processSuccessfulIpGeoPacket(ipgeolocation: IpGeoLocation) {

            managedIpGeoLocations.removeAll()
            
            if let status = ipgeolocation.status {
                if status == "fail" {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "status", value: status)
                        //load an operation
                    self.managedIpGeoLocations.append(ipLocNode)
                    
                    if let message = ipgeolocation.message {
                        let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "message", value: message)
                        self.managedIpGeoLocations.append(ipLocNode)
                    }
                    
                } else {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "status", value: status)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
            } else {
                var ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "status", value: "failed")
                self.managedIpGeoLocations.append(ipLocNode)
                ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "message", value: "Problem receiving service data")
                self.managedIpGeoLocations.append(ipLocNode)
            }
            
            if ipgeolocation.status != "fail" {
                
                if let message = ipgeolocation.message {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "message", value: message)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let country = ipgeolocation.country {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "country", value: country)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let countryCode = ipgeolocation.countryCode {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "countryCode", value: countryCode)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let region = ipgeolocation.region {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "region", value: region)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let regionName = ipgeolocation.regionName {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "regionName", value: regionName)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let city = ipgeolocation.city {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "city", value: city)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let query = ipgeolocation.query {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "query", value: query)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let zip = ipgeolocation.zip {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "zip", value: zip)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                let lat = ipgeolocation.lat
                let ipLocNodeLAT = IpGeoLocationGenericNode(ipLocationItem: "lat", value: String(lat))
                self.managedIpGeoLocations.append(ipLocNodeLAT)
                
                
                let lon = ipgeolocation.lon
                let ipLocNodeLON = IpGeoLocationGenericNode(ipLocationItem: "lon", value: String(lon))
                self.managedIpGeoLocations.append(ipLocNodeLON)
                
                if let timezone = ipgeolocation.timezone {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "timezone", value: timezone)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let isp = ipgeolocation.isp {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "isp", value: isp)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
                
                if let org = ipgeolocation.org {
                    let ipLocNode = IpGeoLocationGenericNode(ipLocationItem: "org", value: org)
                    self.managedIpGeoLocations.append(ipLocNode)
                }
            }
            

        }
         
        private func setNetworkStatus(to: Bool) -> Void {
            self.networkNotAvailable = to
        }
        
        
        //MARK: - NSFetchedResultsControllerDelegate Supported Callback

        nonisolated func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            
        }

        nonisolated func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        }

        nonisolated func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
        {
            // what type of MO change
            switch (type)
            {
                //.insert ------------------------
                case .insert:
                    switch anObject {
                        case let tempReachabilityStatusTerm as ReachabilityStatus:
                            
                            let reachabilityStatus = tempReachabilityStatusTerm.status!
                            if reachabilityStatus == kReachWiFi {
                                Task{ await setNetworkStatus(to: false) }
                            } else if reachabilityStatus == kReachWWAN {
                                Task{ await setNetworkStatus(to: false) }
                            } else if reachabilityStatus == kUnReachable {
                                Task{ await setNetworkStatus(to: true) }
                            }
                            
                        break
                        case let insertedIpGeoLocation as IpGeoLocation:
                            Task{
                                await processSuccessfulIpGeoPacket(ipgeolocation: insertedIpGeoLocation)
                            }
                        break
                        default:
                        break
                    }
                break
                // .delete ------------------------
                case .delete:
                break
                // .update ------------------------
                case .update:
                    switch anObject {
                        case let updatedIpGeoLocation as IpGeoLocation:
                            Task{
                                await processSuccessfulIpGeoPacket(ipgeolocation: updatedIpGeoLocation)
                            }
                        break
                        default:
                        break
                    }
                break
                //  .move ------------------------
                case .move:
                break
                @unknown default:
                    fatalError()
            }
        }
    }
}
