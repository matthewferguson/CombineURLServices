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

    
    public func fetchIpGeoLocation(ipAddressInput:String) {
        
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
                        //print("\n ------- fetchIpGeoLocation() Data received ------\n \(ipgeolocation.debugDescription)\n\n -------\n \(type(of: ipgeolocation))")
                        DataFlowFunnel.shared.addOperation(CreateIpGeoLocationOperation(newIpLocation: ipgeolocation))
                    })
                .store(in: &self.cancellable)
    }
}
