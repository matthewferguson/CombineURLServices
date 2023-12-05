//
//  BoatCustomCellView.swift
//  PondFishingSwiftUI
//
//  Created by Matthew Ferguson on 5/18/23.
//

import SwiftUI

struct BoatCustomCellView: View {
    var boatInfo: BoatNode
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Spacer()
                Text("Boat ID: " + boatInfo.boatId )
                    .font(.headline)
                Text("Fish Caught and Stored : \(boatInfo.boatStorage)")
                    .font(.headline)
                    .foregroundColor(.black)
                Text(String(describing:"\(boatInfo.state)"))
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
        }
    }
}

