//
//  Advanced_SwiftUI_16_06_22App.swift
//  Advanced SwiftUI 16.06.22
//
//  Created by Sergey Kovalev on 6/16/22.
//

import SwiftUI
import FirebaseCore

@main
struct Advanced_SwiftUI_16_06_22App: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
