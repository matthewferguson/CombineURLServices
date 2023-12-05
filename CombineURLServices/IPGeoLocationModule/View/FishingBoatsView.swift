//
//  FishingBoatsView.swift
//  PondFishingSwiftUI
//
//  Created by Matthew Ferguson on 5/18/23.
//

import SwiftUI
import CoreData
import Foundation

struct FishingBoatsView: View {
    
    @StateObject private var viewModel = FishingBoatsVM()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.managedBoats, id: \.id) 
                    { singleboat in BoatCustomCellView(boatInfo: singleboat)
                            .listRowBackground(singleboat.state == .fishing ? Color.green : Color.blue)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                let selectedBoat = singleboat
                                if let row = viewModel.managedBoats.firstIndex(where: {$0.id == selectedBoat.id}) {
                                    let selectedBoatNode = self.viewModel.managedBoats[row]
                                    guard let boatId = Int64(selectedBoatNode.boatId) else {
                                        return
                                    }
                                    self.viewModel.toggleBoatState(at: boatId)
                                }
                            }
                    } // For Each
                    .listRowSeparatorTint(.black)
                }// List
            }
            .onAppear {
                viewModel.setupFetchControllers()
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItems) {
                        Label("", systemImage: "plus")
                    }
                }
            }
            .navigationTitle(Text("Start Fishing (TAP)"))
        }
    }

    private func addItems() {
        do {
            Task {
                viewModel.addNewBoat()
            }
        }
    }
}


