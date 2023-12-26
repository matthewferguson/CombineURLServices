//
//  IPLocationDataReducer.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import Foundation
import Combine
import CoreData
import DataFlowFunnelCD


class IPLocationDataReducer : NSObject {
    
    var isRunningOperations:Bool = false
    var cancellable = Set<AnyCancellable>()
    private let ipLocationService:IPLocationDataPublisher = IPLocationService()
    private static let decoder = JSONDecoder()
    
    fileprivate lazy var fetchIPLocationNetworkRequestController: NSFetchedResultsController<NetworkRequest> = {
         let fetchRequestIPLocationNetworkRequest: NSFetchRequest<NetworkRequest> = NetworkRequest.fetchRequest()
        
         let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending:false)
        fetchRequestIPLocationNetworkRequest.sortDescriptors = [sortDescriptor]
        
        //Initialize Fetched Results Controller
        let fetchIPLocationNetworkRecordRequest = NSFetchedResultsController(
             fetchRequest: fetchRequestIPLocationNetworkRequest,
             managedObjectContext:DataFlowFunnel.shared.getPersistentContainerRef().viewContext,
             sectionNameKeyPath: nil,
             cacheName: nil)

        fetchIPLocationNetworkRecordRequest.delegate = self
        return fetchIPLocationNetworkRecordRequest
     }()
    
    
    override init(){
        super.init()
    }
    
    
    public func setupFetchControllersReducer() {
        do {
             try self.fetchIPLocationNetworkRequestController.performFetch()
        } catch {
            // error popup?
            let fetchError = error as NSError
            print("IPLocationDataReducer Unable to Perform Fetch Request: \(fetchError), \(fetchError.localizedDescription)")
        }
    }


    public func updateSuccessfulGeoSearchServiceNetworkRequest(withid: UUID) {
        DataFlowFunnel.shared.addOperation( DeleteIpGeoLocationNetworkRequestOperation(withid: withid) )
    }
    
        
    public func processGeoSearchRequest(insertedServiceRequest: NetworkRequest) {

        var operations:[Operation] = []
        operations.append(DeleteOlderIpGeoLocationEntriesOperation())
        DataFlowFunnel.shared.addOperations(operations, waitUntilFinished: true)
        
        if let checkUrl = insertedServiceRequest.urlRequested {
            if checkUrl == String() {
                /// the url being processed is an empty string from text field.
                return
            } else {
                let managedContext =  DataFlowFunnel.shared.getPersistentContainerRef().viewContext
                let fetchRequest = NSFetchRequest<IpGeoLocation>(entityName: "IpGeoLocation")
                fetchRequest.predicate = NSPredicate(format: "query = %@", checkUrl)
                managedContext.performAndWait {
                    do {
                        
                        let existingSpecificIPCollection = try managedContext.fetch(fetchRequest)
                        if let existingSpecificIPEntity = existingSpecificIPCollection.first {
                            DataFlowFunnel.shared.addOperation (UpdateIpGeoLocationOperation(withIpGeoLocation: existingSpecificIPEntity))
                        }
                        else{
                            /// Start a new network request
                            Task {
                                if let url = insertedServiceRequest.urlRequested {
                                    if let tempId = insertedServiceRequest.id {
                                        self.fetchIpGeoLocation(ipAddressInput: url, ident: tempId)
                                    } else {
                                        // Send an error packet
                                    }
                                }
                            }

                        }
                    } catch let error as NSError {
                        print("processGeoSearchRequest: Failed to execute do conditional block \(error), \(error.userInfo)")
                    }
                }
                
            }
        } else {
            return
        }
    
    }
    

    public func fetchIpGeoLocation(ipAddressInput:String , ident: UUID ) {
        
            let queryUrl = URL(string: "http://ip-api.com/json/" + ipAddressInput)!
            self.ipLocationService.publisher(url: queryUrl)
                .retry(2)
                    // decode the response from tryMap into a custom data structure
                .decode(type: IPLocation.self, decoder: Self.decoder )
                .replaceError(with: IPLocation.error )
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {status in switch status {
                        case .finished:
                            print("Completed the Service");
                        break
                        case .failure(let error):
                            print("Received error \(error)");
                        break
                        }
                    },
                    receiveValue: { ipgeolocation in
                        DataFlowFunnel.shared.addOperation(
                            CreateIpGeoLocationOperation(newIpLocation: ipgeolocation, ident: ident)
                        )
                    })
                .store(in: &self.cancellable)
    }
}
