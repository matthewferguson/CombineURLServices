//
//  GeoSearchView.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import SwiftUI
import CoreData
import Foundation

struct GeoSearchView: View {
    
    @StateObject private var viewModel = GeoSearchViewModel()
    var body: some View {
        VStack {
            Spacer()
            Text("IP Geo Location Check")
                .font(.title)
            Spacer()
            HStack {
                TextField("e.g. 134.220.123.198", text: $viewModel.ipAddressInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 80 , maxWidth: 240)
                    .border(Color.black)
            }
            Button("Scan") {
                Task {
                    viewModel.managedIpGeoLocations.removeAll()
                    viewModel.requestIpGeoServices()
                }
            }
            .buttonStyle(.borderedProminent)
            Spacer()
            List {
                ForEach(viewModel.managedIpGeoLocations, id: \.id) {
                    singleNode in IpGeoLocationGenericCellView(nodeInfo: singleNode)
                        .listRowBackground(Color.white)
                        .contentShape(Rectangle())
                }
                .listRowSeparatorTint(.black)
            }
            Spacer()
        }
        .sheet(isPresented: $viewModel.networkNotAvailable) {
            NoConnectView()
        }
        .onAppear(perform: {
            viewModel.setupFetchControllers()
        })
    }
}
