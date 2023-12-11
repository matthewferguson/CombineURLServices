//
//  IpGeoLocationGenericCellView.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import Foundation
import SwiftUI

struct IpGeoLocationGenericCellView: View {
    var nodeInfo: IpGeoLocationGenericNode
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Spacer()
                Text(nodeInfo.ipLocationItem )
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(nodeInfo.value)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
        }
    }
}

