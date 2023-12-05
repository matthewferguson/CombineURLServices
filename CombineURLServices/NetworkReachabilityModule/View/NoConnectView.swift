//
//  NoConnectView.swift
//
//  Created by Matthew Ferguson on 12/1/23.
//

import SwiftUI
import CoreData
import Foundation

struct NoConnectView: View 
{
    @Environment(\.dismiss) var dismiss
    
    @State private var showingSheet = false
    @StateObject private var viewModel = NoConnectViewModel()
    
    var body: some View 
    {
        VStack
        {
            Spacer()
            Text("We have seen better days.")
            Text("No Internet Connection to perform a search")
            Text("Check your Wifi/Cellular connection")
            .padding()
            Button("I will check my connection")
            {
                 dismiss()
            }
            .buttonStyle(.borderedProminent)
            .font(.headline)
            .padding()
            Spacer()
                
        }
        .onAppear(perform:
        {
           showingSheet = true
        })
    }
}
