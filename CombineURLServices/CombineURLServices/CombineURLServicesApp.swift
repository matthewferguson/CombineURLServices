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
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
