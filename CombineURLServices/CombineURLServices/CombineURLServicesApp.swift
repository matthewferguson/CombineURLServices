//
//  CombineURLServicesApp.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 10/17/23.
//

import SwiftUI

@main
struct CombineURLServicesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            GeoSearchView()
        }
    }
}
