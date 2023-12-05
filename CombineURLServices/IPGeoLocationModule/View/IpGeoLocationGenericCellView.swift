//
//  IpGeoLocationGenericCellView.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 11/24/23.
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

