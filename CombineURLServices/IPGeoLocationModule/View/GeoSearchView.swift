//
//  GeoSearchView.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 11/19/23.
//

import SwiftUI
import CoreData
import Foundation

struct GeoSearchView: View {
    @StateObject private var viewModel = GeoSearchViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Input IP address", text: $viewModel.ipAddressInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 80 , maxWidth: 240)
                    .border(Color.black)
            }
            Button("Scan") {
                Task {
                    viewModel.managedIpGeoLocations.removeAll()
                    viewModel.fetchIpGeoLocation()
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
