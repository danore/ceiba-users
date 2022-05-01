//
//  ceiba_usersApp.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import SwiftUI

@main
struct ceiba_usersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
