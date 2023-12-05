//
//  FishingBoatsVM.swift
//  PondFishingSwiftUI
//
//  Created by Matthew Ferguson on 5/25/23.
//

import Foundation
import UIKit
import CoreData
import DataFlowFunnelCD

extension FishingBoatsView 
{
    @MainActor class FishingBoatsVM: NSObject, ObservableObject, NSFetchedResultsControllerDelegate
    {
        @Published var managedBoats: [BoatNode] = []
        
        fileprivate lazy var fetchBoatsRequestController: NSFetchedResultsController<Boat> = {
            let fetchRequestForUsers: NSFetchRequest<Boat> = Boat.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: "boatId", ascending:false)
            fetchRequestForUsers.sortDescriptors = [sortDescriptor]
            
            //Initialize Fetched Results Controller
            let fetchAllUsersRecordRequest = NSFetchedResultsController(
                fetchRequest: fetchRequestForUsers,
                managedObjectContext:DataFlowFunnel.shared.getPersistentContainerRef().viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            fetchAllUsersRecordRequest.delegate = self
            return fetchAllUsersRecordRequest
        }()
        
        
        fileprivate lazy var fetchBoatStorageRequestController: NSFetchedResultsController<BoatCatchStorage> = {
            let fetchRequestForBoatStorage: NSFetchRequest<BoatCatchStorage> = BoatCatchStorage.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: "catchTotal", ascending:false)
            fetchRequestForBoatStorage.sortDescriptors = [sortDescriptor]
            
            //Initialize Fetched Results Controller
            let fetchBoatStorageRecordRequest = NSFetchedResultsController(
                fetchRequest: fetchRequestForBoatStorage,
                managedObjectContext:DataFlowFunnel.shared.getPersistentContainerRef().viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            fetchBoatStorageRecordRequest.delegate = self
            return fetchBoatStorageRecordRequest
        }()
        
        func setupFetchControllers() {
            do {
                try self.fetchBoatsRequestController.performFetch()
                let boats = self.fetchBoatsRequestController.fetchedObjects!
                for (singleBoat) in boats 
                {
                    if let managedBoat = managedBoats.first(where: { Int64($0.boatId) == singleBoat.boatId })
                    {
                        let bs = singleBoat.boatstorage! as BoatCatchStorage
                        let insertedBoat = BoatNode(boatId: String(describing: managedBoat.boatId),
                                                    boatStorage: String(describing: bs.catchTotal),
                                                    state: BoatState(rawValue: managedBoat.state.rawValue)!)
                        self.managedBoats[Int(managedBoat.boatId)!] = insertedBoat
                    }
                }
            } catch {
                // error popup?
                let fetchError = error as NSError
                print("Fishing Boats VM Unable to Perform Fetch Request: \(fetchError), \(fetchError.localizedDescription)")
            }
            
            do {
                try self.fetchBoatStorageRequestController.performFetch()
                let boatsStorage = self.fetchBoatStorageRequestController.fetchedObjects!
                for (singleStorage) in boatsStorage
                {
                    let boat = singleStorage.associatedBoat
                    if let managedBoat = managedBoats.first(where: { Int64($0.boatId) == boat?.boatId })
                    {
                        let insertedBoat = BoatNode(boatId: String(describing: managedBoat.boatId),
                                                    boatStorage: String(describing: singleStorage.catchTotal),
                                                    state: BoatState(rawValue: managedBoat.state.rawValue)!)
                        self.managedBoats[Int(managedBoat.boatId)!] = insertedBoat
                    }
                }
            } catch {
                // error popup?
                let fetchError = error as NSError
                print("Fishing Boats VM Unable to Perform Fetch Request: \(fetchError), \(fetchError.localizedDescription)")
            }
        }
        
        
        func toggleBoatState(at index: Int64) {
            let toggleFishingBoatStateOperation = ToggleFishingBoatStateOperation(newBoatId: Int64(index))
            DataFlowFunnel.shared.addOperation(toggleFishingBoatStateOperation)
            DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
        }
        
        
        func updateBoatsView(withBoatNode updatedBoat: BoatNode) {
            if let managedBoat = managedBoats.first(where: { $0.boatId == updatedBoat.boatId }) {
                self.managedBoats[Int(managedBoat.boatId)!] = updatedBoat
            }
        }
        
        func addNewBoat() {
            if managedBoats.count < 9 {
                let candidateID = managedBoats.count
                let addNewBoatOperation = AddFishingBoatOperation(newBoatId: Int64(candidateID))
                DataFlowFunnel.shared.addOperation(addNewBoatOperation)
                let describeCurrentData = FetchAndDescribeDataOperation()
                DataFlowFunnel.shared.addOperation(describeCurrentData)
            }
        }
        
        func installNewBoatView(withBoatNode newboat: BoatNode) {
            self.managedBoats.append(newboat)
            self.managedBoats = self.managedBoats.sorted (by: {$0.boatId < $1.boatId})
        }
        
        // MARK: - NSFetchedResultsControllerDelegate
        
        nonisolated public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            print("FishingBoatsViewModel: fetch controllerWillChangeContent")
        }
        
        nonisolated public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            print("FishingBoatsViewModel: fetch controllerDidChangeContent")
        }
        
        
        nonisolated public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
        {
            switch (type) {
            case .insert:
                switch anObject {
                    
                case let insertedBoat as Boat:
                    switch insertedBoat.state {
                        case BoatState.docked.rawValue:
                            guard let boatStorageNum = insertedBoat.boatstorage?.catchTotal else {
                                print("optional processing error")
                                return
                            }
                            let stringBoatId = String(insertedBoat.boatId)
                            let stringBoatStoreNum = String(boatStorageNum)
                            let boatnode = BoatNode(boatId: stringBoatId,
                                                boatStorage: stringBoatStoreNum,
                                                state: BoatState(rawValue: insertedBoat.state)! )
                            defer {
                                Task {
                                    await self.installNewBoatView(withBoatNode: boatnode)
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
                break //.insert
                
            case .update:
                
                switch anObject {
                    case let updatedBoat as Boat:
                    
                        guard let boatStorageNum = updatedBoat.boatstorage?.catchTotal else {
                            print("optional processing error")
                            return
                        }
                        let stringBoatId = String(updatedBoat.boatId)
                        let stringBoatStoreNum = String(boatStorageNum)
                        let boatnode = BoatNode(boatId: stringBoatId,
                                                boatStorage: stringBoatStoreNum,
                                                state: BoatState(rawValue: updatedBoat.state)! )

                        //https://forums.swift.org/t/a-bug-cant-defer-actor-isolated-variable-access/50796
                        //do { Task { @MainActor in self.updateBoatsView(withBoatNode: boatnode) } }
                        do {
                            Task {
                                await self.updateBoatsView(withBoatNode: boatnode)
                            }
                        }
                    case let updatedBoatStorage as BoatCatchStorage:

                        if nil != updatedBoatStorage.associatedBoat {
                    
                            guard let singleboat = updatedBoatStorage.associatedBoat else {
                                print("optional processing error")
                                return
                            }
                            
                            let boatStorageNum = updatedBoatStorage.catchTotal
                            let tempboatid = singleboat.boatId
                            let tempboatState = singleboat.state
                            let boatnode = BoatNode(boatId: String(tempboatid),
                                                        boatStorage: String(boatStorageNum),
                                                        state: BoatState(rawValue: tempboatState)! )
                            
                            //https://forums.swift.org/t/a-bug-cant-defer-actor-isolated-variable-access/50796
                            do {
                                Task {
                                    await self.updateBoatsView(withBoatNode: boatnode)
                                }
                            }
                        }
                
                    break
                    default:
                    break
                }
            break //.update
            case .delete: break
            case .move: break
            @unknown default:
                fatalError()
            }
        }
    }
}
