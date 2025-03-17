//
//  Note_to_SelfApp.swift
//  Note to Self
//
//  Created by Stefan Ekwall on 2025-03-17.
//

import SwiftUI

@main
struct Note_to_SelfApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
