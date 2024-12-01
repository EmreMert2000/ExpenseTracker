//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Emre Mert on 1.12.2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
