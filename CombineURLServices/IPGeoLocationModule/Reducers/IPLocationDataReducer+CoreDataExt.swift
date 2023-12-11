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
                            case "iplookup":
                                if let url = insertedServiceRequest.urlRequested {
                                    Task {
                                        self.fetchIpGeoLocation(ipAddressInput: url)
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
            // ****** UPDATE *******
            case .update:
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
