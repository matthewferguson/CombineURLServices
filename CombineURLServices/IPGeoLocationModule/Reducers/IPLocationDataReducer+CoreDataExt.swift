//
//  IPLocationDataReducer+CoreDataExt.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson 
//

import Foundation
import UIKit
import CoreData
import DataFlowFunnelCD


extension IPLocationDataReducer: NSFetchedResultsControllerDelegate
{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // this can be used to prep a facade pattern.  Create memory to handle data handling.
        // or stop UI updates in UIKit ViewControllers
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //this area can be used to update UI
    }
    
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange anObject: Any,
                           at indexPath: IndexPath?,
                           for type: NSFetchedResultsChangeType,
                           newIndexPath: IndexPath?) {
        
        switch (type)
        {
            // ****** INSERT *******
            case .insert:
                switch anObject {
                    case let insertedServiceRequest as NetworkRequest:
                        switch insertedServiceRequest.type {
                            case NetworkRequestType.geosearch.rawValue:
                                Task {
                                    self.processGeoSearchRequest(insertedServiceRequest: insertedServiceRequest)
                                }
                            break
                            default:
                            break
                        }
                    break
                    default:
                    break
                }
            break
            // ****** UPDATE *******
            case .update:
                switch anObject {
                    case let insertedServiceRequest as NetworkRequest:
                        switch insertedServiceRequest.type {
                            case NetworkRequestType.geosearch.rawValue:
                                if NetworkRequestStatus.success.rawValue == insertedServiceRequest.status {
                                    //print("success change = \(String(describing:insertedServiceRequest.id?.uuidString))")
                                    Task {
                                        // log the submitted geosearch
                                        self.updateSuccessfulGeoSearchServiceNetworkRequest(withid: insertedServiceRequest.id! )
                                    }
                                }
                                else if NetworkRequestStatus.delete.rawValue == insertedServiceRequest.status {
                                    //print("delete change = \(String(describing:insertedServiceRequest.id?.uuidString))")
                                    Task {
                                        // log the deletion action.
                                        DataFlowFunnel.shared.addOperation( DeleteIpGeoLocationNetworkRequestOperation(withid: insertedServiceRequest.id! ) )
                                    }
                            }
                            break
                            default:
                            break
                        }
                    break
                    default:
                    break
                }
            break
            // ****** DELETE *******
            case .delete:
            break
            // ****** MOVE ********
            case .move: 
            break
            @unknown default:
                fatalError()
        }
    }
}
